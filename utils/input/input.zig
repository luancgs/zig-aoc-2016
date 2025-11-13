const std = @import("std");
const fs = std.fs;

const year = 2016;

pub fn get_input(buffer: *const []u8, day: comptime_int) anyerror!usize {
    const file_buffer = try std.heap.page_allocator.alloc(u8, 4096 * 4);
    defer std.heap.page_allocator.free(file_buffer);

    const cwd = fs.cwd();
    const open_file_flags = fs.File.OpenFlags{ .mode = .read_only };

    var filename_buffer: [64]u8 = undefined;
    const file_path = try std.fmt.bufPrint(&filename_buffer, "./inputs/{d}/day0{d}.txt", .{ year, day });
    const file = try cwd.openFile(file_path, open_file_flags);
    const bytes_read = try file.read(file_buffer);

    _ = try std.fmt.bufPrint(buffer.*, "{s}\n", .{file_buffer[0..bytes_read]});

    return bytes_read;
}
