extends Control
class_name Inventory

@onready var item_grid: GridContainer = %ItemGrid
@onready var stored_items: GridContainer = %stored_items

@export var dimensions : Vector2i = Vector2(5,5)

var inventory_slot_layers : Array[Array]
var items : Array[ItemData]
var inv_items : Array[InventoryItem]
var current_inv_item : InventoryItem
var desired_item_rotation : float ## Just for the lerping visuals
var current_item_rotation : float
var current_item_offset : Vector2
var item_upgrades : Array[Upgrade]
var item_upgrade_names : Array[String]

var debug_shape : Array

const inv_slot_scn : PackedScene = preload("res://inventoryStuff/inventory_slot/inventory_slot.tscn")
const inv_item_scn : PackedScene = preload("res://inventoryStuff/inventory_item/inventory_item.tscn")
const stored_item_button_scn : PackedScene = preload("res://inventoryStuff/stored_item_button/stored_item_button.tscn")

const t3 : ItemData = preload("res://inventoryStuff/resources/T3.tres")
const t4 : ItemData = preload("res://inventoryStuff/resources/T4.tres")
const t5 : ItemData = preload("res://inventoryStuff/resources/T5.tres")

func _ready() -> void:
	item_grid.columns = dimensions.x
	instantiate_inv_slots(item_grid)
	init_inv_slots_array()
	
	add_item_to_storage(References.items_res[0])
	add_item_to_storage(References.items_res[1])

func instantiate_inv_slots(grid: GridContainer) -> void:
	# Instantiates all the inventory slots
	# Amount depends on the dimensions
	for y in dimensions.y:
		for x in dimensions.x:
			var inv_slot : InventorySlot = inv_slot_scn.instantiate()
			grid.add_child(inv_slot)

func init_inv_slots_array() -> void:
	# Creates the inventory slots array
	# With the rows and columns
	# It starts empty, so all 0s
	inventory_slot_layers.resize(dimensions.y)
	for layer in inventory_slot_layers:
		layer.resize(dimensions.x)
		layer.fill(0)
	#print_debugs()

func add_item(item: ItemData, at: Vector2i) -> void: ## Adds an item, it'll check if it can fit or nah
	var inventory_item : InventoryItem = inv_item_scn.instantiate()
	inventory_item.item = item
	inventory_item.position += item_grid.position + Vector2(at * g.slot_size)
	inventory_item.coord = at
	inventory_item.inventory = self
	
	inventory_item.final_rot = current_item_rotation
	inventory_item.final_offset = current_item_offset
	
	add_child(inventory_item)
	
	# Instantiates the Inventory Item sprite to add to the grid
	
	if not can_fit(item, at):
		var stored_item_button : StoredItemButton = stored_item_button_scn.instantiate()
		
		stored_item_button.item = item
		stored_item_button.scale = Vector2(0.6, 0.6)
		stored_item_button.inventory = self
		
		stored_items.add_child(stored_item_button)
		
		inventory_item.queue_free()
		return
	
	#print(get_slot_coord(inventory_item.global_position))
	
	var ydex : int = -1
	for layer in item.shape:
		ydex += 1
		#print(item.shape[ydex])
		var xdex : int = -1
		for x in layer:
			xdex += 1
			if x == 1:
				inventory_slot_layers[at.y + ydex][at.x + xdex] = item.shape[ydex][xdex]
	
	
	# Allat adds the shape of the item to the item layers array
	# 1 is occupied, 0 unoccupied
	
	
	item.upgrade.apply_player(g.player)
	g.player.upgrades.append(item.upgrade)
	g.player.upgrade_names.append(item.upgrade.name)
	
	items.append(item)
	item_upgrades.append(item.upgrade)
	item_upgrade_names.append(item.upgrade.name)
	inv_items.append(inventory_item)
	#print(inv_items)

func print_debugs() -> void: ## Prints the whole inventory slot layers to see which slots are occupied or nah
	#for layer in items[0].shape:
	#	print(layer)
	for layer in inventory_slot_layers:
		print(layer)
	
	print("")

func _gui_input(event: InputEvent) -> void:
	# Only runs when pressing in the control node
	
	if not event is InputEventMouseButton:
		return
	
	if Input.is_action_just_pressed("lmb"):
		if current_inv_item:
			var coord : Vector2i = get_slot_coord(get_global_mouse_position())
			if can_fit(current_inv_item.item, coord):
				add_item(current_inv_item.item, coord)
				current_inv_item.queue_free()
				#items.remove_at(items.find(current_inv_item.item))
			
		else:
			select_item()

func get_slot_coord(pos: Vector2i) -> Vector2i: ## Put a position, returns coords of slot
	return (pos - Vector2i(item_grid.global_position)) / g.slot_size

func get_slot_idx(pos: Vector2) -> int: ## Put position, returns index of slot
	var coord : Vector2i = get_slot_coord(pos)
	
	var idx = coord.x % dimensions.x + (coord.y * dimensions.x)
	
	return idx

func get_slot_coord_from_idx(idx: int) -> Vector2i: ## Put index, returns coordinates of slot
	var x = idx % dimensions.x
	var y = float(idx) / float(dimensions.x)
	
	return Vector2i(int(x), int(y))

func get_slot_idx_from_coord(coord: Vector2i) -> int: ## Put coordinates, returns index of slot
	
	var idx = coord.x % dimensions.x + (coord.y * dimensions.x)
	
	return idx

func can_fit(item: ItemData, at: Vector2i) -> bool: ## Checks if the shape can fit or nah
	if at.x > dimensions.x - 1 or at.y > dimensions.y - 1:
		return false
	
	if at.x < 0 or at.y < 0:
		return false
	
	var shape : Array = item.shape
	
	var intersections : Array[bool] = []
	
	var ydex : int = -1
	
	for layer in item.shape:
		ydex += 1
		#print(item.shape[ydex])
		#print(inventory_slot_layers[ydex + at.y])
		#print("")
		
		var xdex : int = -1
		for x in layer:
			xdex += 1
			#print(item.shape[ydex][xdex])
			#print(inventory_slot_layers[ydex + at.y][xdex + at.x] == 0)
			if (
			(xdex + at.x < dimensions.x and ydex + at.y < dimensions.y) 
			and 
			(xdex + at.x >= 0 and ydex + at.y >= 0)
			):
				
				intersections.append(
				(inventory_slot_layers[ydex + at.y][xdex + at.x] == 0)
				or
				(item.shape[0][0] == 0)
				or
				item.shape[ydex][xdex] == 0
				)
				#pass
			else:
				return false
				#pass
	
	#if current_item_domain[0] == get_slot_coord(get_global_mouse_position()):
	#	for point in current_item_domain:
	#		
	#		if (not point.y > inventory_slot_layers.size() - 1 and
	#		not point.x > inventory_slot_layers[point.y].size() - 1):
	#			intersections.append(inventory_slot_layers[point.y][point.x] == 0)
	#		else:
	#			return false
	return intersections.count(false) == 0

func find_item_at_pos(pos: Vector2) -> void:
	get_slot_coord(get_global_mouse_position())

func select_item() -> void:
	
	desired_item_rotation = 0
	current_item_rotation = 0
	
	var coord = get_slot_coord(get_global_mouse_position())
	for item : InventoryItem in inv_items:
	
		for thing in item.domain:
		
		# Iterates through the item's domain / area
		# Basically, it's origin and occupied slots in the inventory grid
		# If the domain matches up with the mouse's coordinates in the grid,
		# it'll see which item that is
			
			
			if thing == coord and inventory_slot_layers[thing.y][thing.x] == 1:
				current_inv_item = item
				#print(inventory_slot_layers[thing.y])
				#print(item)
				
				#prints(item.domain)
				
				
				inv_items.remove_at(inv_items.find(item))
				items.remove_at(items.find(item.item))
				item_upgrades.remove_at(item_upgrades.find(item.item.upgrade))
				item_upgrade_names.remove_at(item_upgrade_names.find(item.item.upgrade.name))
				
				
				
				for slice in item.domain:
					
					inventory_slot_layers[slice.y][slice.x] = 0
					# I have to delete the item from the inventory_slot_layers array
					# Turning that part to 0s

func grab_item_from_stored(item: ItemData) -> void:
	desired_item_rotation = 0
	current_item_rotation = 0
	
	var inventory_item : InventoryItem = inv_item_scn.instantiate()
	inventory_item.item = item
	inventory_item.inventory = self
	add_child(inventory_item)
	current_inv_item = inventory_item

func _process(delta: float) -> void:
	%store_back.visible = current_inv_item != null
	
	texts()
	#if Input.is_action_just_pressed("rot_left"):
	#	change_rotation(90)
	#if Input.is_action_just_pressed("rot_right"):
	#	change_rotation(-90)

func _on_store_back_pressed() -> void:
	if current_inv_item:
		var stored_item_button : StoredItemButton = stored_item_button_scn.instantiate()
		
		stored_item_button.item = current_inv_item.item
		stored_item_button.scale = Vector2(0.6, 0.6)
		stored_item_button.inventory = self
		
		stored_items.add_child(stored_item_button)
		
		current_inv_item.queue_free()

func add_item_to_storage(item: ItemData) -> void:
	var stored_item_button : StoredItemButton = stored_item_button_scn.instantiate()
	
	stored_item_button.item = item
	stored_item_button.scale = Vector2(0.6, 0.6)
	stored_item_button.inventory = self
	
	stored_items.add_child(stored_item_button)

func texts() -> void:
	var ndex : int = -1
	for label in %layers_txt.get_children():
		if label is Label:
			ndex += 1
			label.text = str(inventory_slot_layers[ndex])
	
	%items_txt.text = str(g.player.upgrade_names)

func change_rotation(amnt: float) -> void:
	desired_item_rotation += amnt
	
	current_item_rotation = wrapf(desired_item_rotation, 0, 360)
