extends Node2D

@export var game_canvas : CanvasLayer
@export var viewport : Viewport
@export var HUD : CanvasLayer
@export var viewport_display : TextureRect
@export var other_camera : Camera2D

func _ready() -> void:
	var game_canvas_RID : RID = game_canvas.get_canvas()
	var viewport_RID : RID = viewport.get_viewport_rid()
	RenderingServer.viewport_attach_canvas(viewport_RID, game_canvas_RID)
	var game_world : World2D = get_viewport().world_2d
	viewport.world_2d = game_world



## move the OtherCamera to a random spot 0 - 800
func _on_button_pressed() -> void:
	var x := Vector2(randi_range(0, 1000), randi_range(0, 1000))
	other_camera.position = x
