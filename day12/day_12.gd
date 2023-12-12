extends Node

func _ready():
	var file := FileAccess.open("res://day12/day_12.txt", FileAccess.READ)
	var lines: Array[String] = []
	while file.get_position() < file.get_length():
		var line := file.get_line()
		if line != "":
			lines.append(line)
	file.close()

	var total_arrangements = 0
	for line in lines:
		var split := line.split(" ")
		var problem := split[0]
		var damaged := split[1]

		var groups: Array = Array(damaged.split(",")).map(func (x): return int(x))

		var unkowns: Array[int] = []
		for i in problem.length():
			if problem[i] == "?":
				unkowns.append(i)

		var arrangements = 0
		var combinations = combinations(unkowns.size())
		for combination in combinations:
			for u_index in unkowns.size():
				problem[unkowns[u_index]] = combination[u_index]

			var clusters = calculate_clusters(problem)
			if groups == clusters:
				arrangements += 1

		total_arrangements += arrangements

	print("Result of day 12-1: %d" % total_arrangements)


func calculate_clusters(problem: String):
	var clusters = []
	var regex = RegEx.new()
	regex.compile("#+")
	for result in regex.search_all(problem):
		clusters.append(result.get_string(0).length())
	return clusters


func combinations(number: int):
	if number == 1:
		return [".", "#"]
	else:
		var a = []
		for i in [".", "#"]:
			for j in combinations(number - 1):
				a.append(i + j)
		return a




