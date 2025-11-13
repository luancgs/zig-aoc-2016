const std = @import("std");
const utils = @import("../utils/utils.zig");

const Bearing = enum {
    NORTH,
    EAST,
    SOUTH,
    WEST,
};

fn format_input(input: *const []u8) ![][]const u8 {
    const buffer = try std.heap.page_allocator.alloc([]const u8, 1024);

    const bytes_read = utils.split_string(input.*, ", ", buffer) catch |err| {
        std.debug.print("Error: {any}\n", .{err});
        std.heap.page_allocator.free(buffer);
        return err;
    };

    const final_list = try std.heap.page_allocator.realloc(buffer, bytes_read);

    return final_list;
}

fn visit_points(
    allocator: *std.mem.Allocator,
    points_visited: *std.StringHashMap(bool),
    start_x: i32,
    start_y: i32,
    steps: u8,
    dx: i32,
    dy: i32,
) !?u32 {
    var x = start_x;
    var y = start_y;

    for (0..steps) |_| {
        x += dx;
        y += dy;

        const key = try std.fmt.allocPrint(
            allocator.*,
            "{d}:{d}",
            .{ x, y },
        );
        errdefer allocator.*.free(key);

        if (points_visited.contains(key)) {
            return @abs(x) + @abs(y);
        }

        try points_visited.put(key, true);
    }

    return null;
}

pub fn part1(input: *const []u8) !u32 {
    var bearing: Bearing = Bearing.NORTH;
    var blocks_away_x: i32 = 0;
    var blocks_away_y: i32 = 0;

    const input_list = try format_input(input);

    for (input_list) |direction| {
        switch (direction[0]) {
            'R' => {
                bearing = switch (bearing) {
                    Bearing.NORTH => Bearing.EAST,
                    Bearing.EAST => Bearing.SOUTH,
                    Bearing.SOUTH => Bearing.WEST,
                    Bearing.WEST => Bearing.NORTH,
                };
            },
            'L' => {
                bearing = switch (bearing) {
                    Bearing.NORTH => Bearing.WEST,
                    Bearing.WEST => Bearing.SOUTH,
                    Bearing.SOUTH => Bearing.EAST,
                    Bearing.EAST => Bearing.NORTH,
                };
            },
            else => std.debug.panic("Invalid direction: {s}\n", .{direction}),
        }

        const steps = std.fmt.parseInt(u8, direction[1..], 10) catch |err| {
            std.debug.print("Error: {any}\n", .{err});
            return err;
        };

        switch (bearing) {
            Bearing.NORTH => blocks_away_y += steps,
            Bearing.SOUTH => blocks_away_y -= steps,
            Bearing.EAST => blocks_away_x += steps,
            Bearing.WEST => blocks_away_x -= steps,
        }
    }

    return @abs(blocks_away_x) + @abs(blocks_away_y);
}

pub fn part2(input: *const []u8) !u32 {
    var bearing: Bearing = Bearing.NORTH;
    var blocks_away_x: i32 = 0;
    var blocks_away_y: i32 = 0;

    const input_list = try format_input(input);

    const hash_alloc = std.heap.page_allocator;
    var key_alloc = std.heap.page_allocator;

    var points_visited = std.StringHashMap(bool).init(hash_alloc);
    defer points_visited.deinit();

    for (input_list) |direction| {
        switch (direction[0]) {
            'R' => {
                bearing = switch (bearing) {
                    Bearing.NORTH => Bearing.EAST,
                    Bearing.EAST => Bearing.SOUTH,
                    Bearing.SOUTH => Bearing.WEST,
                    Bearing.WEST => Bearing.NORTH,
                };
            },
            'L' => {
                bearing = switch (bearing) {
                    Bearing.NORTH => Bearing.WEST,
                    Bearing.WEST => Bearing.SOUTH,
                    Bearing.SOUTH => Bearing.EAST,
                    Bearing.EAST => Bearing.NORTH,
                };
            },
            else => std.debug.panic("Invalid direction: {s}\n", .{direction}),
        }

        const steps = std.fmt.parseInt(u8, direction[1..], 10) catch |err| {
            std.debug.print("Error: {any}\n", .{err});
            return err;
        };

        switch (bearing) {
            Bearing.NORTH => {
                const distance = try visit_points(
                    &key_alloc,
                    &points_visited,
                    blocks_away_x,
                    blocks_away_y,
                    steps,
                    0,
                    1,
                );
                if (distance != null) return distance.?;
                blocks_away_y += steps;
            },
            Bearing.SOUTH => {
                const distance = try visit_points(
                    &key_alloc,
                    &points_visited,
                    blocks_away_x,
                    blocks_away_y,
                    steps,
                    0,
                    -1,
                );
                if (distance != null) return distance.?;
                blocks_away_y -= steps;
            },
            Bearing.EAST => {
                const distance = try visit_points(
                    &key_alloc,
                    &points_visited,
                    blocks_away_x,
                    blocks_away_y,
                    steps,
                    1,
                    0,
                );
                if (distance != null) return distance.?;
                blocks_away_x += steps;
            },
            Bearing.WEST => {
                const distance = try visit_points(
                    &key_alloc,
                    &points_visited,
                    blocks_away_x,
                    blocks_away_y,
                    steps,
                    -1,
                    0,
                );
                if (distance != null) return distance.?;
                blocks_away_x -= steps;
            },
        }
    }

    std.debug.panic("No valid location found", .{});
}
