// raylib-zig (c) Nikolas Wipper 2023

const rl = @import("raylib");
const std = @import("std");

fn createCenteredRectangle(
    outer_rectangle: rl.Rectangle,
    inner_width: f32,
    inner_height: f32,
) rl.Rectangle {
    // Calculate the top-left X coordinate for the inner rectangle
    const inner_x = outer_rectangle.x + (outer_rectangle.width / 2.0) - (inner_width / 2.0);

    // Calculate the top-left Y coordinate for the inner rectangle
    const inner_y = outer_rectangle.y + (outer_rectangle.height / 2.0) - (inner_height / 2.0);

    return rl.Rectangle{
        .x = inner_x,
        .y = inner_y,
        .width = inner_width,
        .height = inner_height,
    };
}

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

    const rectangle = rl.Rectangle{
        .x = 50,
        .y = 50,
        .width = 50,
        .height = 50,
    };

    while (!rl.windowShouldClose()) {
        const frameTime = rl.getFrameTime();
        refresh_timer += frameTime;
        game_time += frameTime;
        if (refresh_timer >= 0.5) {
            refresh_timer = 0.0;
            fps = 1.0 / frameTime;
        }

        const mousePos = rl.getMousePosition();

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.black);
        rl.drawFPS(10, 10);

        rl.drawText("Congrats! You created your first window!", 200, 200, 20, .white);

        const gameTimeString = try std.fmt.bufPrintZ(&text_buffer, "Time: {:.0}s", .{game_time});
        rl.drawText(gameTimeString, 200, 220, 20, .lime);
        const frametimeString = try std.fmt.bufPrintZ(&text_buffer, "Frame Time: {:.3}ms", .{frameTime * 1000.0});
        rl.drawText(frametimeString, 200, 240, 20, .lime);
        const mousePosString = try std.fmt.bufPrintZ(&text_buffer, "Mouse: ({:.0}, {:.0})", .{mousePos.x, mousePos.y});
        rl.drawText(mousePosString, 200, 260, 20, .lime);

        rl.drawRectangleRec(rectangle, .red);
        const innerRect = createCenteredRectangle(rectangle, 25, 10);
        rl.drawRectangleRec(innerRect, .green);
        rl.drawRectangleRec(createCenteredRectangle(rectangle, 10, 25), .blue);

    }
}
