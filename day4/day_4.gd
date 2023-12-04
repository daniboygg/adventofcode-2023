extends Node

func _ready():
	var file := FileAccess.open("res://day4/day_4.txt", FileAccess.READ)
	var lines := []
	while file.get_position() < file.get_length():
		var line := file.get_line()
		if line != "":
			lines.append(line)
	file.close()

	var final_points = 0
	var games := []
	for line: String in lines:
		var number_regex := RegEx.new()
		number_regex.compile("\\d+")

		var game_number_str = line.split(":")[0]
		var game_regex := RegEx.new()
		game_regex.compile("Card.+\\d+")
		var game_number: int = int(game_regex.search(game_number_str).get_string())

		var game = line.split(":")[1]
		var winners = game.split("|")[0].strip_edges()
		var play = game.split("|")[1].strip_edges()

		var winners_set = {}
		for winner in number_regex.search_all(winners):
			winners_set[int(winner.get_string())] = 0

		var line_points = 0
		var number_of_winners = 0

		var number_array = []
		for number in number_regex.search_all(play):
			var int_number := int(number.get_string())
			number_array.append(int_number)
			if winners_set.has(int_number):
				number_of_winners += 1
				if line_points == 0:
					line_points = 1
				else:
					line_points *= 2

		final_points += line_points
		games.append([winners_set, number_array, number_of_winners, 1])

	for index in games.size():
		var game = games[index]
		var number_of_winners = game[2]

		for i in range(min(index+1, games.size()), min(index+number_of_winners+1, games.size())):
			games[i][3] = games[i][3] + game[3]

	var total_cards = 0
	for game in games:
		total_cards += game[3]

	print("Result of day 4-1: %d" % final_points)
	print("Result of day 4-2: %d" % total_cards)
