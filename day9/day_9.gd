extends Node


func _ready():
	var file := FileAccess.open("res://day9/day_9.txt", FileAccess.READ)
	var lines: Array[String] = []
	while file.get_position() < file.get_length():
		var line := file.get_line()
		if line != "":
			lines.append(line)
	file.close()

	var part_1 = 0
	var part_2 = 0
	for line in lines:
		var numbers: Array = Array(line.split(" ")).map(func (x): return int(x))

		var results = [numbers]
		while not results[-1].all(func (x): return x == 0):
			results.append([])
			for index in range(1, results[-2].size()):
				results[-1].append(results[-2][index] - results[-2][index - 1])

		results.reverse()
		results[0].append(0)
		results[0].push_front(0)
		for index in range(1, results.size()):
			results[index].append(results[index][-1] + results[index - 1][-1])
			results[index].push_front(results[index][0] - results[index -1][0])

		part_1 += results[-1][-1]
		part_2 += results[-1][0]

	print("Result of day 9-1: %d" % part_1)
	print("Result of day 9-2: %d" % part_2)

