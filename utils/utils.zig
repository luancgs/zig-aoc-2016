const std = @import("std");
const mem = std.mem;

pub fn split_string(
    str: []const u8,
    delimiter: []const u8,
    buffer: [][]const u8,
) !usize {
    const EOF = "\n";
    var parts = mem.splitSequence(u8, mem.trimEnd(u8, str, EOF), delimiter);
    var count: usize = 0;

    while (parts.next()) |part| {
        if (count >= buffer.len) {
            return error.BufferTooSmall;
        }

        buffer[count] = part;
        count += 1;
    }

    return count;
}
