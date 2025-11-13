const std = @import("std");
const input_utils = @import("utils/input/input.zig");
const solution = @import("solutions/day01.zig");

pub fn main() !void {
    const day = 1;
    const buffer = try std.heap.page_allocator.alloc(u8, 1024);
    defer std.heap.page_allocator.free(buffer);

    const bytes_read = input_utils.get_input(&buffer, day) catch |err| {
        std.debug.print("Error: {any}\n", .{err});
        return err;
    };

    const input = buffer[0..bytes_read];

    const response_1: u32 = try solution.part1(&input);
    const response_2: u32 = try solution.part2(&input);

    std.debug.print("Day {d} | Part 1: {d}\n", .{ day, response_1 });
    std.debug.print("Day {d} | Part 2: {d}\n", .{ day, response_2 });
}
