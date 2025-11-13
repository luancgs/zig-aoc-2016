const std = @import("std");
const input_utils = @import("utils/input/input.zig");
const solution = @import("solutions/day02.zig");

pub fn main() !void {
    const day = 2;
    const buffer = try std.heap.page_allocator.alloc(u8, 4096 * 4);
    defer std.heap.page_allocator.free(buffer);

    const bytes_read = input_utils.get_input(&buffer, day) catch |err| {
        std.debug.print("Error: {any}\n", .{err});
        return err;
    };

    const input = buffer[0..bytes_read];

    // std.debug.print("input: {s}\n", .{input});

    const response_1 = try solution.part1(&input);
    const response_2 = try solution.part2(&input);

    std.debug.print("Day {d} | Part 1: {s}\n", .{ day, response_1 });
    std.debug.print("Day {d} | Part 2: {s}\n", .{ day, response_2 });
}
