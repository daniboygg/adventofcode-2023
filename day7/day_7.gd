extends Node


func _ready():
	var file := FileAccess.open("res://day7/day_7.txt", FileAccess.READ)
	var lines: Array[String] = []
	while file.get_position() < file.get_length():
		var line := file.get_line()
		if line != "":
			lines.append(line)
	file.close()

	var augmented_plays = []
	for line in lines:
		var split := line.split(" ")
		var play := split[0]
		var bid := split[1]
		var augmented_play = [play, bid]

		var counters = {}
		for c in play:
			counters[c] = counters.get(c, 0) + 1

		var values := counters.values()
		values.sort_custom(func (x, y): return x > y)
		match values:
			[5]:
				augmented_play.append(7)
			[4, 1]:
				augmented_play.append(6)
			[3, 2]:
				augmented_play.append(5)
			[3, 1, 1]:
				augmented_play.append(4)
			[2, 2, 1]:
				augmented_play.append(3)
			[2, 1, 1, 1]:
				augmented_play.append(2)
			[1, 1, 1, 1, 1]:
				augmented_play.append(1)

		augmented_plays.append(augmented_play)

	augmented_plays.sort_custom(order.bind(score))

	var result := 0
	for index in augmented_plays.size():
		result += int(augmented_plays[index][1]) * (index + 1)

	print("Result of day 7-1: %d" % result)

	# part 2
	augmented_plays = []
	for line in lines:
		var split := line.split(" ")
		var play := split[0]
		var bid := split[1]
		var augmented_play = [play, bid]

		var counters = {}
		for c in play:
			counters[c] = counters.get(c, 0) + 1

		var jokers = play.count("J")

		var values := counters.values()
		values.sort_custom(func (x, y): return x > y)
		match values:
			[5]:
				augmented_play.append(7)
			[4, 1]:
				if jokers == 1 or jokers == 4:
					augmented_play.append(7)
				else:
					augmented_play.append(6)
			[3, 2]:
				if jokers == 3 or jokers == 2:
					augmented_play.append(7)
				else:
					augmented_play.append(5)
			[3, 1, 1]:
				if jokers == 1 or jokers == 3:
					augmented_play.append(6)
				else:
					augmented_play.append(4)
			[2, 2, 1]:
				if jokers == 2:
					augmented_play.append(6)
				elif jokers == 1:
					augmented_play.append(5)
				else:
					augmented_play.append(3)
			[2, 1, 1, 1]:
				if jokers == 2 or jokers == 1:
					augmented_play.append(4)
				else:
					augmented_play.append(2)
			[1, 1, 1, 1, 1]:
				if jokers == 1:
					augmented_play.append(2)
				else:
					augmented_play.append(1)

		augmented_play.append(jokers)
		augmented_plays.append(augmented_play)

	augmented_plays.sort_custom(order.bind(score2))

	result = 0
	for index in augmented_plays.size():
		result += int(augmented_plays[index][1]) * (index + 1)

	print("Result of day 7-2: %d" % result)



func order(x, y, score_func: Callable) -> bool:
	if x[2] != y[2]:
		return x[2] < y[2]

	for index in x[0].length():
		if x[0][index] == y[0][index]:
			continue

		return score_func.call(x[0][index]) < score_func.call(y[0][index])

	return false


func score(c: String) -> int:
	match c:
		"A":
			return 14
		"K":
			return 13
		"Q":
			return 12
		"J":
			return 11
		"T":
			return 10
		"9":
			return 9
		"8":
			return 8
		"7":
			return 7
		"6":
			return 6
		"5":
			return 5
		"4":
			return 4
		"3":
			return 3
		"2":
			return 2
		_:
			assert(false, "This is an error")
			return 0


func score2(c: String) -> int:
	match c:
		"A":
			return 14
		"K":
			return 13
		"Q":
			return 12
		"J":
			return 1
		"T":
			return 10
		"9":
			return 9
		"8":
			return 8
		"7":
			return 7
		"6":
			return 6
		"5":
			return 5
		"4":
			return 4
		"3":
			return 3
		"2":
			return 2
		_:
			assert(false, "This is an error")
			return 0






