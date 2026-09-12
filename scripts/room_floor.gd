extends Polygon2D
## Generic adventure-game depth system. Defines a room's walkable floor as a
## polygon (drawn faintly so it's visible during testing); the player clamps
## to it and reads a depth scale off it. near_y (closer to camera, bigger) to
## far_y (further back, smaller) — reused/reskinned per room, not rebuilt.

@export var near_y: float = 500.0
@export var far_y: float = 260.0
@export var near_scale: float = 1.0
@export var far_scale: float = 0.6

func clamp_to_floor(pos: Vector2) -> Vector2:
	if Geometry2D.is_point_in_polygon(pos, polygon):
		return pos
	var closest := pos
	var closest_dist := INF
	var count := polygon.size()
	for i in count:
		var a: Vector2 = polygon[i]
		var b: Vector2 = polygon[(i + 1) % count]
		var candidate: Vector2 = Geometry2D.get_closest_point_to_segment(pos, a, b)
		var dist := pos.distance_squared_to(candidate)
		if dist < closest_dist:
			closest_dist = dist
			closest = candidate
	return closest

func get_depth_scale(y: float) -> float:
	var t: float = clamp(inverse_lerp(near_y, far_y, y), 0.0, 1.0)
	return lerp(near_scale, far_scale, t)
