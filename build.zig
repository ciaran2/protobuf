const std = @import("std");
const print = @import("std").debug.print;

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});
    //const t = target.result;

    var flags = std.ArrayList([]const u8).init(b.allocator);
    defer flags.deinit();

    const lib = b.addStaticLibrary(.{
        .name = "protobuf-wkts",
        .target = target,
        .optimize = optimize,
    });
    lib.addIncludePath(b.path("src"));
    lib.addIncludePath(b.path("src/google/protobuf"));

    const config_header = b.addConfigHeader(
        .{
            .style = .blank,
        },
        .{},
    );
    lib.addConfigHeader(config_header);

    //const version_header = b.addConfigHeader(
    //    .{
    //        .style = .{ .cmake = b.path("lib/includes/nghttp2/nghttp2ver.h.in") },
    //        .include_path = "nghttp2/nghttp2ver.h",
    //    },
    //    .{
    //        .PACKAGE_VERSION = "1.63.0",
    //        .PACKAGE_VERSION_NUM = 0x013f00,
    //    },
    //);
    //lib.addConfigHeader(version_header);
    //lib.installConfigHeader(version_header);

    //flags.appendSlice(&.{
    //    "-DHAVE_CONFIG_H",
    //}) catch unreachable;

    const source_files = [_][]const u8{ "src/google/protobuf/any.pb-c.c", "src/google/protobuf/api.pb-c.c", "src/google/protobuf/duration.pb-c.c", "src/google/protobuf/empty.pb-c.c", "src/google/protobuf/field_mask.pb-c.c", "src/google/protobuf/source_context.pb-c.c", "src/google/protobuf/struct.pb-c.c", "src/google/protobuf/timestamp.pb-c.c", "src/google/protobuf/type.pb-c.c", "src/google/protobuf/wrappers.pb-c.c" };

    lib.linkLibC();
    lib.installHeader(b.path("src/google/protobuf/any.pb-c.h"), "google/protobuf/any.pb-c.h");
    lib.installHeader(b.path("src/google/protobuf/api.pb-c.h"), "google/protobuf/api.pb-c.h");
    lib.installHeader(b.path("src/google/protobuf/duration.pb-c.h"), "google/protobuf/duration.pb-c.h");
    lib.installHeader(b.path("src/google/protobuf/empty.pb-c.h"), "google/protobuf/empty.pb-c.h");
    lib.installHeader(b.path("src/google/protobuf/field_mask.pb-c.h"), "google/protobuf/field_mask.pb-c.h");
    lib.installHeader(b.path("src/google/protobuf/source_context.pb-c.h"), "google/protobuf/source_context.pb-c.h");
    lib.installHeader(b.path("src/google/protobuf/struct.pb-c.h"), "google/protobuf/struct.pb-c.h");
    lib.installHeader(b.path("src/google/protobuf/timestamp.pb-c.h"), "google/protobuf/timestamp.pb-c.h");
    lib.installHeader(b.path("src/google/protobuf/type.pb-c.h"), "google/protobuf/type.pb-c.h");
    lib.installHeader(b.path("src/google/protobuf/wrappers.pb-c.h"), "google/protobuf/wrappers.pb-c.h");
    lib.addCSourceFiles(.{
        .files = &source_files,
        .flags = flags.items,
    });

    b.installArtifact(lib);
}
