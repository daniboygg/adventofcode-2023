extends Node


func _ready():
	var file := FileAccess.open("res://day5/day_5.txt", FileAccess.READ)
	var lines := []
	while file.get_position() < file.get_length():
		var line := file.get_line()
		if line != "":
			lines.append(line)
	file.close()

	var seeds = lines[0].split(": ")[1]
	seeds = line_to_numbers(seeds)

	var mappers = []

	# each number is eache one of the maps above
	var parse_map = 0
	for index in range(1, lines.size()):
		var line: String = lines[index]

		var new_parse_map = select_parse_map(line, parse_map)
		if new_parse_map != parse_map:
			mappers.append(Mapper.new())
			parse_map = new_parse_map
			continue

		var numbers = line_to_numbers(line)
		mappers[parse_map-1].add_rule(numbers[0], numbers[1], numbers[2])

	var positions = []
	for seed in seeds:
		var value = seed
		for mapper in mappers:
			value = mapper.calculate_next(value)
		positions.append(value)

	print("Result of day 5-1: %d" % positions.min())


	# Remake mappers with inverse ranges
	parse_map = 0
	mappers = []
	for index in range(1, lines.size()):
		var line: String = lines[index]

		var new_parse_map = select_parse_map(line, parse_map)
		if new_parse_map != parse_map:
			mappers.append(Mapper.new())
			parse_map = new_parse_map
			continue

		var numbers = line_to_numbers(line)
		# swap origin and destination to do the inverse mapper
		mappers[parse_map-1].add_rule(numbers[1], numbers[0], numbers[2])

	var seeder = Seeder.new()
	for i in range(0, seeds.size(), 2):
		seeder.add_rule(seeds[i], seeds[i+1])

	var position = 0
	var found = false
	# go through mappers in reverse order, from positions to seed
	mappers.reverse()

	while not found:
		var value = position
		for mapper in mappers:
			value = mapper.calculate_next(value)

		if seeder.is_valid_seed(value):
			break

		position += 1

	print("Result of day 5-2: %d" % position)


class Mapper:
	var origin: Array = []
	var destination: Array = []

	func add_rule(destination: int, origin: int, elements: int) -> void:
		self.origin.append([origin, origin + elements])
		self.destination.append([destination, destination + elements])

	func calculate_next(origin: int) -> int:
		for i in range(self.origin.size()):
			if self.origin[i][0] <= origin and origin < self.origin[i][1]:
				return origin - self.origin[i][0] + self.destination[i][0]

		return origin


class Seeder:
	var origin: Array = []

	func add_rule(origin: int, elements: int) -> void:
		self.origin.append([origin, origin + elements])

	func is_valid_seed(seed: int) -> bool:
		for i in range(self.origin.size()):
			if self.origin[i][0] <= seed and seed < self.origin[i][1]:
				return true
		return false


func select_parse_map(line: String, parse_map: int) -> int:
	if line.contains("seed-"):
		return 1
	if line.contains("soil-"):
		return 2
	if line.contains("fertilizer-"):
		return 3
	if line.contains("water-"):
		return 4
	if line.contains("light-"):
		return 5
	if line.contains("temperature-"):
		return 6
	if line.contains("humidity-"):
		return 7

	return parse_map


func line_to_numbers(line: String) -> Array:
	return Array(line.split(" ")).map(func (x): return int(x))
