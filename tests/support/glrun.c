// Draws one full-screen triangle with a vertex and a fragment shader on the local OpenGL (EGL, no window) into an
// RGBA32F target and writes its pixels, row 0 at the bottom, as raw little-endian floats.
//
//   glrun glsl  VERT FRAG W H OUT [RES]    shaders as GLSL source (any #version the driver takes)
//   glrun spirv VERT FRAG W H OUT [RES]    shaders as SPIR-V binaries (ARB_gl_spirv), entry point "main"
//
// The vertex shader is run for vertices 0, 1, 2 (gl_VertexID / VertexIndex).
// RES sets what the shaders read, one per line, the same way for both kinds of shader. A name is what the GLSL
// declares: GLSL source is looked up by it, SPIR-V (which carries no names) by the LOCATION given next to it.
//   attribute NAME LOCATION N V...   a vertex attribute of N floats a vertex, three vertices
//   uniform NAME LOCATION f V...     glUniform{1,2,3,4}fv, or glUniformMatrix4fv for 16 values
//   uniform NAME LOCATION i V...     glUniform{1,2,3,4}iv
//   block BINDING V...               a uniform buffer of these floats at that binding
//   texture UNIT W H LEVELS          an RGBA8 texture of a fixed pattern, every level filled, trilinear, repeat
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
#define MAX_VALUES 64
#define MAT4 16
#define BYTE 255
#define TARGET_UNIT 15

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

static unsigned char texel(int x, int y, int level, int channel) {
    static const int mul[CHANNELS][3] = {{37, 101, 53}, {59, 17, 97}, {13, 71, 29}, {83, 41, 7}};
    return (unsigned char)((x * mul[channel][0] + y * mul[channel][1] + level * mul[channel][2] + channel * 11) & BYTE);
}

static void texture(int unit, int w, int h, int levels) {
    GLuint t;
    glActiveTexture(GL_TEXTURE0 + unit);
    glGenTextures(1, &t);
    glBindTexture(GL_TEXTURE_2D, t);
    glTexStorage2D(GL_TEXTURE_2D, levels, GL_RGBA8, w, h);
    for (int l = 0; l < levels; l++) {
        int lw = w >> l > 0 ? w >> l : 1, lh = h >> l > 0 ? h >> l : 1;
        unsigned char *px = malloc((size_t)lw * lh * CHANNELS);
        for (int y = 0; y < lh; y++)
            for (int x = 0; x < lw; x++)
                for (int c = 0; c < CHANNELS; c++) px[(y * lw + x) * CHANNELS + c] = texel(x, y, l, c);
        glTexSubImage2D(GL_TEXTURE_2D, l, 0, 0, lw, lh, GL_RGBA, GL_UNSIGNED_BYTE, px);
        free(px);
    }
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
}

static int values(FILE *f, int ints, float *fv, int *iv) {
    int n = 0;
    for (;;) {
        int c = fgetc(f);
        while (c == ' ' || c == '\t') c = fgetc(f);
        if (c == '\n' || c == EOF) return n;
        ungetc(c, f);
        if (n == MAX_VALUES) die("too many values");
        if (ints ? fscanf(f, "%d", &iv[n]) != 1 : fscanf(f, "%f", &fv[n]) != 1) die("a value");
        n++;
    }
}

static void resources(const char *path, GLuint prog, int spirv, int linked) {
    FILE *f = fopen(path, "r");
    if (!f) die(path);
    char kind[16], name[64];
    float fv[MAX_VALUES];
    int iv[MAX_VALUES];
    while (fscanf(f, "%15s", kind) == 1) {
        if (strcmp(kind, "texture") == 0) {
            int unit, w, h, levels;
            if (fscanf(f, "%d %d %d %d", &unit, &w, &h, &levels) != 4) die("texture UNIT W H LEVELS");
            if (linked) texture(unit, w, h, levels);
            continue;
        }
        if (strcmp(kind, "attribute") == 0) {
            int at, size;
            if (fscanf(f, "%63s %d %d", name, &at, &size) != 3) die("attribute NAME LOCATION N V...");
            int n = values(f, 0, fv, iv);
            if (n != size * VERTICES) die("an attribute needs N values for each of the three vertices");
            if (!linked) {
                glBindAttribLocation(prog, at, name);
                continue;
            }
            GLuint b;
            glGenBuffers(1, &b);
            glBindBuffer(GL_ARRAY_BUFFER, b);
            glBufferData(GL_ARRAY_BUFFER, n * sizeof(float), fv, GL_STATIC_DRAW);
            glVertexAttribPointer(at, size, GL_FLOAT, GL_FALSE, 0, 0);
            glEnableVertexAttribArray(at);
            continue;
        }
        if (strcmp(kind, "block") == 0) {
            int at;
            if (fscanf(f, "%d", &at) != 1) die("block BINDING V...");
            int n = values(f, 0, fv, iv);
            if (!linked) continue;
            GLuint b;
            glGenBuffers(1, &b);
            glBindBuffer(GL_UNIFORM_BUFFER, b);
            glBufferData(GL_UNIFORM_BUFFER, n * sizeof(float), fv, GL_STATIC_DRAW);
            glBindBufferBase(GL_UNIFORM_BUFFER, at, b);
            continue;
        }
        if (strcmp(kind, "uniform") != 0) die(kind);
        int at;
        char ty[2];
        if (fscanf(f, "%63s %d %1s", name, &at, ty) != 3) die("uniform NAME LOCATION f|i V...");
        int n = values(f, ty[0] == 'i', fv, iv);
        if (!linked) continue;
        if (!spirv) {
            at = glGetUniformLocation(prog, name);
            if (at < 0) die(name);
        }
        if (ty[0] == 'i') {
            void (*set[])(GLint, GLsizei, const GLint *) = {glUniform1iv, glUniform2iv, glUniform3iv, glUniform4iv};
            if (n < 1 || n > CHANNELS) die("1 to 4 ints");
            set[n - 1](at, 1, iv);
        } else if (n == MAT4) {
            glUniformMatrix4fv(at, 1, GL_FALSE, fv);
        } else {
            void (*set[])(GLint, GLsizei, const GLfloat *) = {glUniform1fv, glUniform2fv, glUniform3fv, glUniform4fv};
            if (n < 1 || n > CHANNELS) die("1 to 4 floats, or 16");
            set[n - 1](at, 1, fv);
        }
    }
    fclose(f);
}

int main(int argc, char **argv) {
    if (argc != 7 && argc != 8) die("usage: glrun glsl|spirv VERT FRAG W H OUT [RES]");
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
    if (argc == 8) resources(argv[7], prog, spirv, 0);
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
    glGenVertexArrays(1, &vao);
    glBindVertexArray(vao);
    glUseProgram(prog);
    if (argc == 8) resources(argv[7], prog, spirv, 1);
    glActiveTexture(GL_TEXTURE0 + TARGET_UNIT);

    glGenTextures(1, &tex);
    glBindTexture(GL_TEXTURE_2D, tex);
    glTexStorage2D(GL_TEXTURE_2D, 1, GL_RGBA32F, w, h);
    glGenFramebuffers(1, &fbo);
    glBindFramebuffer(GL_FRAMEBUFFER, fbo);
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, tex, 0);
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE) die("framebuffer");

    glViewport(0, 0, w, h);
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
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
