extends Node


func _ready():
	var file := FileAccess.open("res://day6/day_6.txt", FileAccess.READ)
	var lines := []
	while file.get_position() < file.get_length():
		var line := file.get_line()
		if line != "":
			lines.append(line)
	file.close()

	var times = Array(lines[0].split(":")[1].split(" ")).filter(func (x): return x != "").map(func (x): return int(x))
	var distances = Array(lines[1].split(":")[1].split(" ")).filter(func (x): return x != "").map(func (x): return int(x))

	var posibilities: Array = []
	for index in times.size():
		var winner_posibilities = 0
		for time in range(1, times[index]):
			var distance = time * (times[index] - time)
			if distance > distances[index]:
				winner_posibilities += 1

		posibilities.append(winner_posibilities)

	var result = posibilities.reduce(func (x, y): return x * y, 1)
	print("Result of day 6-1: %d" % result)

	# part 2
	times = int("".join(PackedStringArray(Array(lines[0].split(":")[1].split(" ")).filter(func (x): return x != ""))))
	distances = int("".join(PackedStringArray(Array(lines[1].split(":")[1].split(" ")).filter(func (x): return x != ""))))

	posibilities = []
	var winner_posibilities = 0
	for time in range(1, times):
		var distance = time * (times - time)
		if distance > distances:
			winner_posibilities += 1

	posibilities.append(winner_posibilities)

	result = posibilities.reduce(func (x, y): return x * y, 1)
	print("Result of day 6-2: %d" % result)
