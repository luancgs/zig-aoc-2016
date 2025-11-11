const std = @import("std");
const input_utils = @import("utils/input/input.zig");

pub fn main() !void {
    const buffer = try std.heap.page_allocator.alloc(u8, 1024);
    defer std.heap.page_allocator.free(buffer);

    const bytes_read = input_utils.get_input(&buffer, 1) catch |err| {
        std.debug.print("Error: {any}\n", .{err});
        return err;
    };

    const input = buffer[0..bytes_read];

    std.debug.print("{s}\n", .{input});
}
