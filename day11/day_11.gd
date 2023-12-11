extends Node


func _ready():
	var file := FileAccess.open("res://day11/day_11.txt", FileAccess.READ)
	var lines: Array[String] = []
	while file.get_position() < file.get_length():
		var line := file.get_line()
		if line != "":
			lines.append(line)
	file.close()

	var rows_to_expand = []
	for row in lines.size():
		if "#" not in lines[row]:
			rows_to_expand.append(row)

	var additional = 0
	for row in rows_to_expand:
		var content := Array()
		content.resize(lines[0].length())
		content.fill(".")
		lines.insert(row + additional, "".join(content))
		additional += 1

	var cols_to_expand = []
	for col in lines[0].length():
		var col_content = ""
		for row in lines.size():
			col_content += lines[row][col]
		if "#" not in col_content:
			cols_to_expand.append(col)

	additional = 0
	for col in cols_to_expand:
		for row in lines.size():
			lines[row] = lines[row].insert(col + additional, ".")
		additional += 1

	var galaxies: Array[Vector2i] = []
	for row in lines.size():
		if "#" in lines[row]:
			var i = -1
			while i < lines[row].length():
				i = lines[row].find("#", i + 1)
				if i == -1:
					break
				galaxies.append(Vector2i(i, row))

	var path_lengths = 0
	for pair in combinations(galaxies):
		path_lengths += manhattan(pair[0], pair[1])

	print("Result of day 11-1: %d" % path_lengths)


func combinations(array: Array[Vector2i]):
	var pairs = {}
	for el1 in array:
		for el2 in array:
			if el1 == el2:
				break
			if [el2, el1] not in pairs:
				pairs[[el1, el2]] = null
	return pairs.keys()


func manhattan(p1, p2):
	return abs(p1.x - p2.x) + abs(p1.y - p2.y)
