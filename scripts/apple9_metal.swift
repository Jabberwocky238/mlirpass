// Apple9 (an M4: Metal's applegpu_g16g) through Metal, on the Mac itself: the oracle and the runner of the apple9
// target. There is no Mesa model of Apple9; what the hardware does with the code is the reference.
//
//   swiftc -O scripts/apple9_metal.swift -o target/apple9-metal
//   apple9-metal dump FILE.metal                 each kernel: `kernel NAME`, `text HEX` (__TEXT,__text of the GPU
//                                                Mach-O), `const HEX` (the constant program's pool)
//   apple9-metal archive FILE.metal KERNEL OUT   the serialized archive of KERNEL's pipeline
//   apple9-metal run FILE.metal KERNEL [--text HEX] [--threads N | --grid X,Y,Z] [--group N] BUF...
//        BUF is `u32:N[:i|:0|:HEX,HEX..]` (N dwords: their index, zero, or the given words), bound at 0, 1 ...
//        --text replaces the kernel's main (from `_agc.main` on) by HEX, padded with `halt` to its length;
//        prints every buffer after the dispatch as `buf K HEX..` (little-endian dwords).
//
// How a kernel is found and replaced: Metal serializes an MTLBinaryArchive as a fat Mach-O; its `applegpu` slice
// holds one GPU Mach-O per pipeline in `__TEXT,__compute`, whose `__TEXT,__text` is the code (`_agc.main` after the
// constant program). Metal runs what the archive holds: a pipeline made with failOnBinaryArchiveMiss from an archive
// whose `__text` was rewritten runs the rewritten code (no signature, checked 2026-11-08 on a Mac16,12).

import Foundation
import Metal

struct Section { let seg: String; let sect: String; let offset: Int; let size: Int }

/// The sections and symbols of the 64-bit Mach-O at `base` in `b`.
struct MachO {
    let sections: [Section]
    let symbols: [(String, Int)]

    init?(_ b: [UInt8], at base: Int) {
        func u32(_ p: Int) -> Int { Int(b[p]) | Int(b[p + 1]) << 8 | Int(b[p + 2]) << 16 | Int(b[p + 3]) << 24 }
        func u64(_ p: Int) -> Int { u32(p) | u32(p + 4) << 32 }
        func str(_ p: Int, _ n: Int) -> String { String(decoding: b[p..<p + n].prefix { $0 != 0 }, as: UTF8.self) }
        guard base + 32 <= b.count, u32(base) == 0xfeed_facf else { return nil }
        var sections: [Section] = []
        var symbols: [(String, Int)] = []
        var p = base + 32
        for _ in 0..<u32(base + 16) {
            let (cmd, size) = (u32(p), u32(p + 4))
            if cmd == 0x19 {
                for s in 0..<u32(p + 64) {
                    let q = p + 72 + 80 * s
                    sections.append(Section(seg: str(q + 16, 16), sect: str(q, 16), offset: base + u32(q + 48), size: u64(q + 40)))
                }
            } else if cmd == 0x2 {
                let (symoff, nsyms, stroff) = (u32(p + 8), u32(p + 12), u32(p + 16))
                for k in 0..<nsyms {
                    let e = base + symoff + 16 * k
                    var n = base + stroff + u32(e)
                    var name: [UInt8] = []
                    while b[n] != 0 { name.append(b[n]); n += 1 }
                    symbols.append((String(decoding: name, as: UTF8.self), u64(e + 8)))
                }
            }
            p += size
        }
        self.sections = sections
        self.symbols = symbols
    }

    func section(_ seg: String, _ sect: String) -> Section? { sections.first { $0.seg == seg && $0.sect == sect } }
}

/// The kernels' GPU Mach-Os in a serialized archive (the `applegpu` slice of the fat file).
func kernels(_ b: [UInt8]) -> [MachO] {
    func be(_ p: Int) -> Int { Int(b[p]) << 24 | Int(b[p + 1]) << 16 | Int(b[p + 2]) << 8 | Int(b[p + 3]) }
    var out: [MachO] = []
    for k in 0..<be(4) {
        let a = 8 + 20 * k
        guard be(a) == 0x0100_0013, let slice = MachO(b, at: be(a + 8)) else { continue }
        for s in slice.sections where s.seg == "__TEXT" && s.sect == "__compute" {
            if let inner = MachO(b, at: s.offset) { out.append(inner) }
        }
    }
    return out
}

func hex<C: Collection>(_ c: C) -> String where C.Element == UInt8 { c.map { String(format: "%02x", $0) }.joined() }

func bytes(_ s: String) -> [UInt8] {
    var out: [UInt8] = []
    var i = s.startIndex
    while i < s.endIndex {
        let j = s.index(i, offsetBy: 2)
        out.append(UInt8(s[i..<j], radix: 16)!)
        i = j
    }
    return out
}

func fail(_ m: String) -> Never {
    FileHandle.standardError.write((m + "\n").data(using: .utf8)!)
    exit(1)
}

func need<T>(_ v: T?, _ m: @autoclosure () -> String) -> T {
    guard let v else { fail(m()) }
    return v
}

let dev = need(MTLCreateSystemDefaultDevice(), "no Metal device")
guard dev.architecture.name.hasPrefix("applegpu_g16") else { fail("\(dev.architecture.name): not an Apple9 GPU (an M4: applegpu_g16)") }

/// `name`'s pipeline in a fresh archive, serialized: its bytes.
func archive(_ lib: MTLLibrary, _ name: String) -> [UInt8] {
    let ar = try! dev.makeBinaryArchive(descriptor: MTLBinaryArchiveDescriptor())
    let cd = MTLComputePipelineDescriptor()
    cd.computeFunction = need(lib.makeFunction(name: name), "no kernel \(name)")
    try! ar.addComputePipelineFunctions(descriptor: cd)
    let url = FileManager.default.temporaryDirectory.appendingPathComponent("apple9-\(getpid())-\(name).bin")
    try! ar.serialize(to: url)
    defer { try? FileManager.default.removeItem(at: url) }
    return [UInt8](try! Data(contentsOf: url))
}

/// The constant program's pool: the words after its name in `__GPU_METADATA` (count, then the bytes).
func constants(_ b: [UInt8], _ m: MachO) -> [UInt8] {
    guard let s = m.section("__GPU_METADATA", "__compute") else { return [] }
    let md = Array(b[s.offset..<s.offset + s.size])
    let key = Array("constant_program".utf8)
    guard let at = (0...(md.count - key.count)).first(where: { Array(md[$0..<$0 + key.count]) == key }) else { return [] }
    var p = at + key.count
    while p < md.count && md[p] == 0 { p += 1 }
    let n = Int(md[p]) | Int(md[p + 1]) << 8
    return Array(md[p + 4..<min(md.count, p + 4 + n)])
}

func library(_ path: String) -> MTLLibrary {
    let src = need(try? String(contentsOfFile: path, encoding: .utf8), "cannot read \(path)")
    do { return try dev.makeLibrary(source: src, options: nil) } catch { fail("\(path): \(error)") }
}

let args = Array(CommandLine.arguments.dropFirst())
switch args.first {
case "dump":
    guard args.count == 2 else { fail("dump FILE.metal") }
    let lib = library(args[1])
    for name in lib.functionNames.sorted() {
        let b = archive(lib, name)
        guard let m = kernels(b).first, let t = m.section("__TEXT", "__text") else { fail("\(name): no GPU code") }
        let main = m.symbols.first { $0.0 == "_agc.main" }?.1 ?? 0
        print("kernel \(name) main=\(main)")
        print("text \(hex(b[t.offset..<t.offset + t.size]))")
        print("const \(hex(constants(b, m)))")
    }

case "archive":
    guard args.count == 4 else { fail("archive FILE.metal KERNEL OUT") }
    try! Data(archive(library(args[1]), args[2])).write(to: URL(fileURLWithPath: args[3]))

case "run":
    guard args.count >= 3 else { fail("run FILE.metal KERNEL [--text HEX] [--threads N | --grid X,Y,Z] [--group N] BUF...") }
    let lib = library(args[1])
    let name = args[2]
    var text: [UInt8]? = nil
    var threads = 64, group = 32
    var grid: [Int]? = nil
    var specs: [String] = []
    var i = 3
    while i < args.count {
        switch args[i] {
        case "--text": text = bytes(args[i + 1]); i += 2
        case "--threads": threads = Int(args[i + 1])!; i += 2
        case "--group": group = Int(args[i + 1])!; i += 2
        case "--grid": grid = args[i + 1].split(separator: ",").map { Int($0)! }; i += 2
        default: specs.append(args[i]); i += 1
        }
    }
    // The archive comes from a child process: a pipeline compiled in this one is cached by the process, and a
    // pipeline asked of the archive afterwards is that cached one, not the archive's (seen 2026-11-08).
    let made = FileManager.default.temporaryDirectory.appendingPathComponent("apple9-made-\(getpid()).bin")
    let child = Process()
    child.executableURL = URL(fileURLWithPath: CommandLine.arguments[0])
    child.arguments = ["archive", args[1], name, made.path]
    try! child.run()
    child.waitUntilExit()
    guard child.terminationStatus == 0 else { fail("archive: child failed") }
    var b = [UInt8](try! Data(contentsOf: made))
    try? FileManager.default.removeItem(at: made)
    if let code = text {
        guard let m = kernels(b).first, let t = m.section("__TEXT", "__text") else { fail("\(name): no GPU code") }
        let main = need(m.symbols.first { $0.0 == "_agc.main" }?.1, "no _agc.main")
        let room = t.size - main
        guard code.count <= room, code.count % 2 == 0 else { fail("--text: \(code.count) bytes, main has \(room)") }
        // halt (0e 00 00 00) after the code; a 2-byte tail stays as Metal left it (never reached)
        var fill = code
        while fill.count + 4 <= room { fill += [0x0e, 0, 0, 0] }
        for (k, x) in fill.enumerated() { b[t.offset + main + k] = x }
    }
    let url = FileManager.default.temporaryDirectory.appendingPathComponent("apple9-run-\(getpid()).bin")
    try! Data(b).write(to: url)
    defer { try? FileManager.default.removeItem(at: url) }
    let d = MTLBinaryArchiveDescriptor()
    d.url = url
    let ar = try! dev.makeBinaryArchive(descriptor: d)
    let cd = MTLComputePipelineDescriptor()
    cd.computeFunction = need(lib.makeFunction(name: name), "no kernel \(name)")
    cd.binaryArchives = [ar]
    let p: MTLComputePipelineState
    do { p = try dev.makeComputePipelineState(descriptor: cd, options: [.failOnBinaryArchiveMiss], reflection: nil) } catch { fail("pipeline: \(error)") }
    var bufs: [MTLBuffer] = []
    for s in specs {
        let f = s.split(separator: ":", omittingEmptySubsequences: false).map(String.init)
        guard f.count >= 2, f[0] == "u32", let n = Int(f[1]) else { fail("buffer \(s): u32:N[:i|:0|:HEX,..]") }
        let buf = dev.makeBuffer(length: max(4, 4 * n), options: .storageModeShared)!
        let w = buf.contents().bindMemory(to: UInt32.self, capacity: n)
        let given = f.count > 2 && f[2] != "i" && f[2] != "0" ? f[2].split(separator: ",").map { UInt32($0, radix: 16)! } : []
        for k in 0..<n { w[k] = f.count > 2 && f[2] == "i" ? UInt32(k) : k < given.count ? given[k] : 0 }
        bufs.append(buf)
    }
    let q = dev.makeCommandQueue()!, cb = q.makeCommandBuffer()!, e = cb.makeComputeCommandEncoder()!
    e.setComputePipelineState(p)
    for (k, buf) in bufs.enumerated() { e.setBuffer(buf, offset: 0, index: k) }
    if let g = grid, g.count == 3 {
        // threadgroups of `group` threads, X × Y × Z of them
        e.dispatchThreadgroups(MTLSize(width: g[0], height: g[1], depth: g[2]), threadsPerThreadgroup: MTLSize(width: group, height: 1, depth: 1))
    } else {
        e.dispatchThreads(MTLSize(width: threads, height: 1, depth: 1), threadsPerThreadgroup: MTLSize(width: group, height: 1, depth: 1))
    }
    e.endEncoding()
    cb.commit()
    cb.waitUntilCompleted()
    guard cb.status == .completed else { fail("command buffer: \(cb.status.rawValue) \(cb.error.map { "\($0)" } ?? "")") }
    for (k, buf) in bufs.enumerated() {
        let n = buf.length / 4
        let w = buf.contents().bindMemory(to: UInt32.self, capacity: n)
        print("buf \(k) " + (0..<n).map { String(format: "%08x", w[$0]) }.joined(separator: " "))
    }

default:
    fail("apple9-metal dump FILE.metal | run FILE.metal KERNEL [--text HEX] [--threads N | --grid X,Y,Z] [--group N] BUF...")
}
