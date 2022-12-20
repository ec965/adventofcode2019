const std = @import("std");
const fmt = @import("std").fmt;
const print = @import("std").debug.print;

const input_file = "./inputs/day2.txt";

fn print_parts(parts: *[1024]u32, len: u32) void {
    var i: u32 = 0;
    while (i < len) {
        print("{d} ", .{parts[i]});
        i += 1;
    }
    print("\n", .{});
}

pub fn main() !void {
    var file = try std.fs.cwd().openFile(input_file, .{});
    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var parts: [1024]u32 = undefined;

    var buf: [1024]u8 = undefined;

    var len: u32 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, ',')) |part| {
        const res = fmt.parseInt(u32, part, 10) catch null;
        if (res != null) {
            parts[len] = res.?;
            len += 1;
        } else {
            const remove_end = fmt.parseInt(u32, part[0 .. part.len - 1], 10) catch null;
            if (remove_end != null) {
                parts[len] = remove_end.?;
                len += 1;
            }
        }
    }

    parts[1] = 12;
    parts[2] = 2;

    var i: u32 = 0;
    while (i < len) {
        if (parts[i] == 1) {
            parts[parts[i + 3]] = parts[parts[i + 1]] + parts[parts[i + 2]];
        } else if (parts[i] == 2) {
            parts[parts[i + 3]] = parts[parts[i + 1]] * parts[parts[i + 2]];
        } else if (parts[i] == 99) {
            break;
        }

        i += 4;
    }

    print("part1: {d}\n", .{parts[0]});
}
