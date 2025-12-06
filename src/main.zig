const rl = @import("raylib");
const za = @import("zaudio");
const std = @import("std");

pub fn main() anyerror!void {
    // za initialization
    const alloc = std.heap.page_allocator;
    za.init(alloc);
    defer za.deinit();

    const engine = try za.Engine.create(null);
    defer engine.destroy();

    const sound = try engine.createSoundFromFile("/home/riley/music/rivers-run-cold.wav", .{});
    defer sound.destroy();

    try sound.start();

    // rl initialization
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");
    defer rl.closeWindow(); // Close window and OpenGL context

    rl.setConfigFlags(.{
        .vsync_hint = true,
    });

    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.white);

        rl.drawText("Congrats! You created your first window!", 190, 200, 20, .light_gray);
    }
}
