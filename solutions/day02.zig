const std = @import("std");
const utils = @import("../utils/utils.zig");

fn format_input(input: *const []u8) ![][]const u8 {
    const buffer = try std.heap.page_allocator.alloc([]const u8, 1024);

    const bytes_read = utils.split_string(input.*, "\n", buffer) catch |err| {
        std.debug.print("Error: {any}\n", .{err});
        std.heap.page_allocator.free(buffer);
        return err;
    };

    const final_list = try std.heap.page_allocator.realloc(buffer, bytes_read);

    return final_list;
}

fn navigate_part1_dpad(position: u8, direction: u8) u8 {
    switch (position) {
        '1' => switch (direction) {
            'U' => return '1',
            'D' => return '4',
            'L' => return '1',
            'R' => return '2',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        '2' => switch (direction) {
            'U' => return '2',
            'D' => return '5',
            'L' => return '1',
            'R' => return '3',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        '3' => switch (direction) {
            'U' => return '3',
            'D' => return '6',
            'L' => return '2',
            'R' => return '3',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        '4' => switch (direction) {
            'U' => return '1',
            'D' => return '7',
            'L' => return '4',
            'R' => return '5',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        '5' => switch (direction) {
            'U' => return '2',
            'D' => return '8',
            'L' => return '4',
            'R' => return '6',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        '6' => switch (direction) {
            'U' => return '3',
            'D' => return '9',
            'L' => return '5',
            'R' => return '6',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        '7' => switch (direction) {
            'U' => return '4',
            'D' => return '7',
            'L' => return '7',
            'R' => return '8',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        '8' => switch (direction) {
            'U' => return '5',
            'D' => return '8',
            'L' => return '7',
            'R' => return '9',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        '9' => switch (direction) {
            'U' => return '6',
            'D' => return '9',
            'L' => return '8',
            'R' => return '9',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        else => std.debug.panic("Invalid D-pad position: {c}\n", .{position}),
    }
}

fn navigate_part2_dpad(position: u8, direction: u8) u8 {
    switch (position) {
        '1' => switch (direction) {
            'U' => return '1',
            'D' => return '3',
            'L' => return '1',
            'R' => return '1',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        '2' => switch (direction) {
            'U' => return '2',
            'D' => return '6',
            'L' => return '2',
            'R' => return '3',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        '3' => switch (direction) {
            'U' => return '1',
            'D' => return '7',
            'L' => return '2',
            'R' => return '4',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        '4' => switch (direction) {
            'U' => return '4',
            'D' => return '8',
            'L' => return '3',
            'R' => return '4',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        '5' => switch (direction) {
            'U' => return '5',
            'D' => return '5',
            'L' => return '5',
            'R' => return '6',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        '6' => switch (direction) {
            'U' => return '2',
            'D' => return 'A',
            'L' => return '5',
            'R' => return '7',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        '7' => switch (direction) {
            'U' => return '3',
            'D' => return 'B',
            'L' => return '6',
            'R' => return '8',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        '8' => switch (direction) {
            'U' => return '4',
            'D' => return 'C',
            'L' => return '7',
            'R' => return '9',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        '9' => switch (direction) {
            'U' => return '9',
            'D' => return '9',
            'L' => return '8',
            'R' => return '9',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        'A' => switch (direction) {
            'U' => return '6',
            'D' => return 'A',
            'L' => return 'A',
            'R' => return 'B',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        'B' => switch (direction) {
            'U' => return '7',
            'D' => return 'D',
            'L' => return 'A',
            'R' => return 'C',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        'C' => switch (direction) {
            'U' => return '8',
            'D' => return 'C',
            'L' => return 'B',
            'R' => return 'C',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        'D' => switch (direction) {
            'U' => return 'B',
            'D' => return 'D',
            'L' => return 'D',
            'R' => return 'D',
            else => std.debug.panic("Invalid direction: {c}\n", .{direction}),
        },
        else => std.debug.panic("Invalid D-pad position: {c}\n", .{position}),
    }
}

pub fn part1(input: *const []u8) ![]u8 {
    const input_list = try format_input(input);

    var position: u8 = '5';

    const output_buffer = try std.heap.page_allocator.alloc(u8, 32);

    for (input_list, 0..input_list.len) |line, i| {
        for (line) |direction| {
            position = navigate_part1_dpad(position, direction);
        }

        output_buffer[i] = position;
    }

    const final_sequence = try std.heap.page_allocator.realloc(output_buffer, input_list.len);

    return final_sequence;
}

pub fn part2(input: *const []u8) ![]u8 {
    const input_list = try format_input(input);

    var position: u8 = '5';

    const output_buffer = try std.heap.page_allocator.alloc(u8, 32);

    for (input_list, 0..input_list.len) |line, i| {
        for (line) |direction| {
            position = navigate_part2_dpad(position, direction);
        }

        output_buffer[i] = position;
    }

    const final_sequence = try std.heap.page_allocator.realloc(output_buffer, input_list.len);

    return final_sequence;
}
