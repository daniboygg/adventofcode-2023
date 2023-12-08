extends Node


func _ready():
	var file := FileAccess.open("res://day8/day_8.txt", FileAccess.READ)
	var lines: Array[String] = []
	while file.get_position() < file.get_length():
		var line := file.get_line()
		if line != "":
			lines.append(line)
	file.close()

	var instructions: String = lines.pop_front()

	var rules := {}
	var starters := {}
	var enders := {}
	for line in lines:
		var split := line.split(" = ")
		var rule1 := split[1].substr(1, 3)
		var rule2 := split[1].substr(6, 3)
		var origin := split[0]
		if origin.ends_with("A"):
			starters[origin] = null
		if origin.ends_with("Z"):
			enders[origin] = null
		rules[origin] = [rule1, rule2]

	part1(instructions, rules)
	part2(instructions, rules, starters, enders)


func part1(instructions, rules):
	var current := "AAA"
	var last := "ZZZ"

	var index = 0
	var steps = 0
	while current != last:
		var c = instructions[index]
		if c == "R":
			current = rules[current][1]
		elif c == "L":
			current = rules[current][0]

		steps += 1

		index = (index + 1) % instructions.length()

	print("Result of day 8-1: %d" % steps)

func part2(instructions, rules, starters_dict, enders_dict):
	var enders: Array = enders_dict.keys()
	var currents: Array = starters_dict.keys()

	var index_instructions := 0
	var loop_counts = currents.map(func (x): return 0)
	var finished_loop_count = currents.map(func (x): return false)
	while not finished_loop_count.all(func (x): return x):
		for index in currents.size():
			var instruction = instructions[index_instructions]
			if instruction == "R":
				currents[index] = rules[currents[index]][1]
			elif instruction == "L":
				currents[index] = rules[currents[index]][0]

			if currents[index].ends_with("Z"):
				loop_counts[index] = loop_counts[index] + 1
				finished_loop_count[index] = true
			elif not finished_loop_count[index]:
				loop_counts[index] = loop_counts[index] + 1

		index_instructions = (index_instructions + 1) % instructions.length()

	print("Result of day 8-2: %d" % loop_counts.reduce(func (accum, number): return lcm(accum, number), 1))


func lcm(a, b):
	var result = a * (b / gcd(a, b))
	return result


func gcd(a, b):
	return a if b == 0 else gcd(b, a % b)

