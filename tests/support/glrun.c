// Draws one full-screen triangle with a vertex and a fragment shader on the local OpenGL (EGL, no window) into an
// RGBA32F target and writes its pixels, row 0 at the bottom, as raw little-endian floats.
//
//   glrun glsl  VERT FRAG W H OUT    shaders as GLSL source (any #version the driver takes)
//   glrun spirv VERT FRAG W H OUT    shaders as SPIR-V binaries (ARB_gl_spirv), entry point "main"
//
// The vertex shader gets no attributes; it is run for vertices 0, 1, 2 (gl_VertexID / VertexIndex).
#include <EGL/egl.h>
#include <EGL/eglext.h>
#define GL_GLEXT_PROTOTYPES
#include <GL/gl.h>
#include <GL/glext.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define VERTICES 3
#define CHANNELS 4

static void die(const char *what) {
    fprintf(stderr, "glrun: %s\n", what);
    exit(1);
}

static char *slurp(const char *path, long *size) {
    FILE *f = fopen(path, "rb");
    if (!f) die(path);
    fseek(f, 0, SEEK_END);
    *size = ftell(f);
    fseek(f, 0, SEEK_SET);
    char *buf = malloc(*size + 1);
    if (fread(buf, 1, *size, f) != (size_t)*size) die(path);
    buf[*size] = 0;
    fclose(f);
    return buf;
}

static GLuint shader(GLenum kind, const char *path, int spirv) {
    long size;
    char *src = slurp(path, &size);
    GLuint s = glCreateShader(kind);
    if (spirv) {
        glShaderBinary(1, &s, GL_SHADER_BINARY_FORMAT_SPIR_V_ARB, src, (GLsizei)size);
        glSpecializeShaderARB(s, "main", 0, NULL, NULL);
    } else {
        const char *text = src;
        glShaderSource(s, 1, &text, NULL);
        glCompileShader(s);
    }
    GLint ok;
    glGetShaderiv(s, GL_COMPILE_STATUS, &ok);
    if (!ok) {
        char log[4096];
        glGetShaderInfoLog(s, sizeof log, NULL, log);
        fprintf(stderr, "glrun: %s: %s\n", path, log);
        exit(1);
    }
    free(src);
    return s;
}

int main(int argc, char **argv) {
    if (argc != 7) die("usage: glrun glsl|spirv VERT FRAG W H OUT");
    int spirv = strcmp(argv[1], "spirv") == 0;
    int w = atoi(argv[4]), h = atoi(argv[5]);

    EGLDisplay dpy = eglGetPlatformDisplay(EGL_PLATFORM_SURFACELESS_MESA, EGL_DEFAULT_DISPLAY, NULL);
    if (!eglInitialize(dpy, NULL, NULL)) die("eglInitialize");
    eglBindAPI(EGL_OPENGL_API);
    EGLint ctx_attrs[] = {EGL_CONTEXT_MAJOR_VERSION, 4, EGL_CONTEXT_MINOR_VERSION, 6, EGL_CONTEXT_OPENGL_PROFILE_MASK, EGL_CONTEXT_OPENGL_CORE_PROFILE_BIT, EGL_NONE};
    EGLContext ctx = eglCreateContext(dpy, EGL_NO_CONFIG_KHR, EGL_NO_CONTEXT, ctx_attrs);
    if (ctx == EGL_NO_CONTEXT) die("eglCreateContext");
    if (!eglMakeCurrent(dpy, EGL_NO_SURFACE, EGL_NO_SURFACE, ctx)) die("eglMakeCurrent");

    GLuint prog = glCreateProgram();
    glAttachShader(prog, shader(GL_VERTEX_SHADER, argv[2], spirv));
    glAttachShader(prog, shader(GL_FRAGMENT_SHADER, argv[3], spirv));
    glLinkProgram(prog);
    GLint ok;
    glGetProgramiv(prog, GL_LINK_STATUS, &ok);
    if (!ok) {
        char log[4096];
        glGetProgramInfoLog(prog, sizeof log, NULL, log);
        fprintf(stderr, "glrun: link: %s\n", log);
        return 1;
    }

    GLuint tex, fbo, vao;
    glGenTextures(1, &tex);
    glBindTexture(GL_TEXTURE_2D, tex);
    glTexStorage2D(GL_TEXTURE_2D, 1, GL_RGBA32F, w, h);
    glGenFramebuffers(1, &fbo);
    glBindFramebuffer(GL_FRAMEBUFFER, fbo);
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, tex, 0);
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE) die("framebuffer");
    glGenVertexArrays(1, &vao);
    glBindVertexArray(vao);

    glViewport(0, 0, w, h);
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    glUseProgram(prog);
    glDrawArrays(GL_TRIANGLES, 0, VERTICES);

    size_t bytes = (size_t)w * h * CHANNELS * sizeof(float);
    float *px = malloc(bytes);
    glReadPixels(0, 0, w, h, GL_RGBA, GL_FLOAT, px);
    if (glGetError() != GL_NO_ERROR) die("a GL error");
    FILE *out = fopen(argv[6], "wb");
    if (!out || fwrite(px, 1, bytes, out) != bytes) die(argv[6]);
    fclose(out);
    return 0;
}
