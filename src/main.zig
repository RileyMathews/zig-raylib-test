// raylib-zig (c) Nikolas Wipper 2023

const rl = @import("raylib");
const std = @import("std");

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;
    rl.setConfigFlags(.{ .vsync_hint = true });

    rl.initWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");
    defer rl.closeWindow(); // Close window and OpenGL context

    var refresh_timer: f32 = 0.0;
    var fps: f32 = 0.0;

    var game_time: f32 = 0.0;
    var text_buffer: [32]u8 = undefined; 

    while (!rl.windowShouldClose()) {
        const frameTime = rl.getFrameTime();
        refresh_timer += frameTime;
        game_time += frameTime;
        if (refresh_timer >= 0.5) {
            refresh_timer = 0.0;
            fps = 1.0 / frameTime;
        }

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.black);
        rl.drawFPS(10, 10);

        rl.drawText("Congrats! You created your first window!", 200, 200, 20, .white);

        const gameTimeString = try std.fmt.bufPrintZ(&text_buffer, "Time: {:.0}s", .{game_time});
        rl.drawText(gameTimeString, 200, 220, 20, .lime);
        const frametimeString = try std.fmt.bufPrintZ(&text_buffer, "Frame Time: {:.3}ms", .{frameTime * 1000.0});
        rl.drawText(frametimeString, 200, 240, 20, .lime);
    }
}
