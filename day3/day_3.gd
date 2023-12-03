extends Node


func _ready():
	var file := FileAccess.open("res://day3/day_3.txt", FileAccess.READ)
	var lines := []
	while file.get_position() < file.get_length():
		var line := file.get_line()
		if line != "":
			lines.append(line)
	file.close()

	var elements: Array = []
	var rows := lines.size()
	# we assume all lines are the same size and almos 1 line exist
	var cols: int = lines[0].length()

	for index in rows:
		var line: String = lines[index]
		var row_elements := []
		for character_index in line.length():
			var position := Vector2i(character_index, index)
			var c: String = line[character_index]
			match c:
				"0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
					row_elements.append(Element.new(position, c, PositionType.NUMBER))
				".":
					row_elements.append(Element.new(position, c, PositionType.DOT))
				_:
					row_elements.append(Element.new(position, c, PositionType.SYMBOL))

		elements.append(row_elements)

	for element_row in elements:
		for element in element_row:
			if element.type != PositionType.NUMBER:
				continue

			var lookup_position = element.position + Vector2i.LEFT
			if is_valid_position(lookup_position, rows, cols):
				if elements[lookup_position.y][lookup_position.x].type == PositionType.SYMBOL:
					element.is_valid = true
					element.adjacent_symbol = elements[lookup_position.y][lookup_position.x].value
					element.adjacent_symbol_position = elements[lookup_position.y][lookup_position.x].position

			lookup_position = element.position + Vector2i.LEFT + Vector2i.UP
			if is_valid_position(lookup_position, rows, cols):
				if elements[lookup_position.y][lookup_position.x].type == PositionType.SYMBOL:
					element.is_valid = true
					element.adjacent_symbol = elements[lookup_position.y][lookup_position.x].value
					element.adjacent_symbol_position = elements[lookup_position.y][lookup_position.x].position

			lookup_position = element.position + Vector2i.UP
			if is_valid_position(lookup_position, rows, cols):
				if elements[lookup_position.y][lookup_position.x].type == PositionType.SYMBOL:
					element.is_valid = true
					element.adjacent_symbol = elements[lookup_position.y][lookup_position.x].value
					element.adjacent_symbol_position = elements[lookup_position.y][lookup_position.x].position

			lookup_position = element.position + Vector2i.UP + Vector2i.RIGHT
			if is_valid_position(lookup_position, rows, cols):
				if elements[lookup_position.y][lookup_position.x].type == PositionType.SYMBOL:
					element.is_valid = true
					element.adjacent_symbol = elements[lookup_position.y][lookup_position.x].value
					element.adjacent_symbol_position = elements[lookup_position.y][lookup_position.x].position

			lookup_position = element.position + Vector2i.RIGHT
			if is_valid_position(lookup_position, rows, cols):
				if elements[lookup_position.y][lookup_position.x].type == PositionType.SYMBOL:
					element.is_valid = true
					element.adjacent_symbol = elements[lookup_position.y][lookup_position.x].value
					element.adjacent_symbol_position = elements[lookup_position.y][lookup_position.x].position

			lookup_position = element.position + Vector2i.RIGHT + Vector2i.DOWN
			if is_valid_position(lookup_position, rows, cols):
				if elements[lookup_position.y][lookup_position.x].type == PositionType.SYMBOL:
					element.is_valid = true
					element.adjacent_symbol = elements[lookup_position.y][lookup_position.x].value
					element.adjacent_symbol_position = elements[lookup_position.y][lookup_position.x].position

			lookup_position = element.position + Vector2i.DOWN
			if is_valid_position(lookup_position, rows, cols):
				if elements[lookup_position.y][lookup_position.x].type == PositionType.SYMBOL:
					element.is_valid = true
					element.adjacent_symbol = elements[lookup_position.y][lookup_position.x].value
					element.adjacent_symbol_position = elements[lookup_position.y][lookup_position.x].position

			lookup_position = element.position + Vector2i.DOWN + Vector2i.LEFT
			if is_valid_position(lookup_position, rows, cols):
				if elements[lookup_position.y][lookup_position.x].type == PositionType.SYMBOL:
					element.is_valid = true
					element.adjacent_symbol = elements[lookup_position.y][lookup_position.x].value
					element.adjacent_symbol_position = elements[lookup_position.y][lookup_position.x].position

	var result_sum := 0
	var gear_numbers = {}
	for element_row in elements:
		for element in element_row:
			if element.is_valid and not element.visited:
				var number: String = ""
				var i: int = element.position.x
				while i >= 0 and element_row[i].type == PositionType.NUMBER:
					number = element_row[i].value + number
					element_row[i].visited = true
					i -= 1

				i = element.position.x + 1
				while i < cols and element_row[i].type == PositionType.NUMBER:
					number = number + element_row[i].value
					element_row[i].visited = true
					i += 1

				if element.adjacent_symbol == "*":
					if gear_numbers.has(element.adjacent_symbol_position):
						gear_numbers[element.adjacent_symbol_position].append(int(number))
					else:
						gear_numbers[element.adjacent_symbol_position] = [int(number)]

				result_sum += int(number)


	var gear_sum := 0
	for key in gear_numbers:
		if (gear_numbers[key] as Array).size() == 2:
			gear_sum += gear_numbers[key][0] * gear_numbers[key][1]

	print("Result of day 3-1: %d" % result_sum)
	print("Result of day 3-2: %d" % gear_sum)


func is_valid_position(position: Vector2i, rows, cols):
	return position.x >= 0 and position.x < cols and position.y >= 0 and position.y < rows


enum PositionType { NUMBER, SYMBOL, DOT}

class Element:
	# maybe this position is not needed, we could look array of arrays whith for loops indexes
	var position: Vector2i
	var value: String
	var type: PositionType
	var is_valid := false
	var visited := false
	var adjacent_symbol: String = ""
	var adjacent_symbol_position: Vector2i

	func _init(position: Vector2i, value: String, type: PositionType) -> void:
		self.position = position
		self.value = value
		self.type = type

	func is_gear():
		return self.value == "*"
