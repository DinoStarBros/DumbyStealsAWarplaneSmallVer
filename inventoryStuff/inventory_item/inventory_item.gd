extends Sprite2D
class_name InventoryItem

var item : UpgradeItem
var size_mult : float
var coord : Vector2i
var domain : Array[Vector2i]
var is_picked : bool = false
var inventory : Inventory
var desired_rotation : float = 0

var wrap_rot : float = 0

var final_rot : float
var final_offset : Vector2

func _ready() -> void:
	size_mult = g.slot_size / 16
	scale *= size_mult
	
	texture = item.texture
	
	#domain.append(coord)
	
	var ydex : int = -1
	for y in item.shape:
		#print(y)
		ydex += 1
		
		var xdex : int = -1
		for x in y:
			xdex += 1
			#print(x)
			var vec2 : Vector2i = Vector2i(coord.x + xdex, coord.y + ydex)
			
			# Only allows 1s in the domain, not 0s
			#print(item.shape[vec2.y - coord.y][vec2.x - coord.x])
			#if item.shape[vec2.y][vec2.x] == 1:
			if item.shape[vec2.y - coord.y][vec2.x - coord.x] == 1:
				domain.append(vec2)
	
	
	modulate = item.color
	
	rotation_degrees = final_rot
	offset = final_offset

func _process(delta: float) -> void:
	is_picked = inventory.current_inv_item == self
	
	if is_picked:
		#modulate.a = 1
		global_position = get_global_mouse_position()
		
		z_index = 10
		
		rotation_degrees = lerp(rotation_degrees, inventory.desired_item_rotation, 20 * delta)
	
	

		
		
	else:
		#modulate.a = 0.9
		z_index = 5
	
	#rotation_degrees = lerp(rotation_degrees, desired_rotation, 20 * delta)

func rotate_sprite(amnt: float) -> void:
	
	desired_rotation += amnt
	
	wrap_rot = wrapf(desired_rotation, 0, 360)
	
	if amnt == 90:
		var pdex = -1
		for point in domain:
			pdex += 1
			
			var temp_vec2 : Vector2i = point
			domain[pdex].x = -temp_vec2.y
			domain[pdex].y = temp_vec2.x
			
	elif amnt == -90:
		var ndex : int = -1
		for point in domain:
			ndex += 1
			
			var temp_vec2 : Vector2i = point
			domain[ndex].x = temp_vec2.y
			domain[ndex].y = -temp_vec2.x
	
	item.domain = domain
