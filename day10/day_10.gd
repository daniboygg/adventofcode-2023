extends Node


func _ready():
	var file := FileAccess.open("res://day10/day_10.txt", FileAccess.READ)
	var lines: Array[String] = []
	while file.get_position() < file.get_length():
		var line := file.get_line()
		if line != "":
			lines.append(line)
	file.close()

	var map: Array = []
	var start: Vector2i = Vector2i.ZERO
	for row_index in lines.size():
		var map_row: Array = []
		for col_index in lines[row_index].length():
			if lines[row_index][col_index] == "S":
				start = Vector2i(col_index, row_index)
			map_row.append(lines[row_index][col_index])
		map.append(map_row)

	var rows := lines.size()
	var cols := lines[0].length()

	var distances := Array()
	for row in rows:
		var row_distances := Array()
		for col in cols:
			row_distances.append(-1)
		distances.append(row_distances)

	var current_position := start
	var is_first = true
	var distance := 1

	while current_position != start or is_first:
		is_first = false

		var current_element: String = map[current_position.y][current_position.x]
		var lookup_position := current_position + Vector2i.LEFT
		if is_valid_position(lookup_position, rows, cols):
			var next_element: String = map[lookup_position.y][lookup_position.x]
			if next_element != "." and distances[lookup_position.y][lookup_position.x] == -1:
				if current_element in ["S", "-", "J", "7"] and next_element in ["S", "-", "L", "F"]:
					distances[current_position.y][current_position.x] = distance
					distance += 1
					current_position = lookup_position
					continue

		lookup_position = current_position + Vector2i.UP
		if is_valid_position(lookup_position, rows, cols):
			var next_element: String = map[lookup_position.y][lookup_position.x]
			if next_element != "." and distances[lookup_position.y][lookup_position.x] == -1:
				if current_element in ["S", "|", "L", "J"] and next_element in ["S", "|", "7", "F"]:
					distances[current_position.y][current_position.x] = distance
					distance += 1
					current_position = lookup_position
					continue

		lookup_position = current_position + Vector2i.RIGHT
		if is_valid_position(lookup_position, rows, cols):
			var next_element: String = map[lookup_position.y][lookup_position.x]
			if next_element != "." and distances[lookup_position.y][lookup_position.x] == -1:
				if current_element in ["S", "-", "L", "F"] and next_element in ["S", "-", "J", "7"]:
					distances[current_position.y][current_position.x] = distance
					distance += 1
					current_position = lookup_position
					continue

		lookup_position = current_position + Vector2i.DOWN
		if is_valid_position(lookup_position, rows, cols):
			var next_element: String = map[lookup_position.y][lookup_position.x]
			if next_element != "." and distances[lookup_position.y][lookup_position.x] == -1:
				if current_element in ["S", "|", "7", "F"] and next_element in ["S", "|", "L", "J"]:
					distances[current_position.y][current_position.x] = distance
					distance += 1
					current_position = lookup_position
					continue

		distances[current_position.y][current_position.x] = distance
		break

	print_d(distances)
	print("Result of day 10-1: %d" % round(distance/2))

	# TODO part 2
	#print("Result of day 10-2: %d" % inner_cells)


func print_d(distances):
	for d in distances:
		print(d.map(func (x): return "%3d" % x if x != -1 else "   "))
	print()

func is_valid_position(position: Vector2i, rows: int, cols: int) -> bool:
	return position.x >= 0 and position.x < cols and position.y >= 0 and position.y < rows
