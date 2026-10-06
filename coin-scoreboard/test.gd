extends Node2D
var playerChoice :int = 0
var score :int = 0 
var bestStreak :int = 0
var coinType :int = 0
var money :int = 1000
var wagerAmount :int = 0
@onready var button :Button = $Button
@onready var button_2: Button = $Button2
@onready var score_text: RichTextLabel = $ScoreText
@onready var coin_result_text: RichTextLabel = $coinResultText
@onready var your_choice_text: RichTextLabel = $yourChoiceText
@onready var button_3: Button = $Button3
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var heads_texture: TextureRect = $HeadsTexture
@onready var tails_texture: TextureRect = $TailsTexture
@onready var plus_one_text: RichTextLabel = $plusOneText
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2
@onready var best_streak: RichTextLabel = $bestStreak
@onready var spin_box: SpinBox = $SpinBox
@onready var money_text: RichTextLabel = $moneyText

func buttonHandler(buttonNum :int):
	wagerAmount = spin_box.value
	if wagerAmount <= money:
		if buttonNum == 0:
			playerChoice = 0
		else:
			playerChoice = 1
		button.hide()
		button_2.hide()
		flipCoin(wagerAmount)
	else:
		#ADD ERROR TEXT
		return

func processBet(wager :int, result :int):
	if result == 1:
		money = money + wager
	else:
		money = money - wager
	money_text.text = "Money: " + str(money)
	if money == 0:
		get_tree().quit()
	button_3.show()
	
func checkStreak(streak):
	if streak >= bestStreak:
		bestStreak = streak
		best_streak.text = "Best Streak = " + str(bestStreak)
	else:
		return

func startRound() -> void:
	animation_player.stop()
	plus_one_text.hide()
	heads_texture.hide()
	tails_texture.hide()
	button_3.hide()
	button.show()
	button_2.show()
	your_choice_text.text = ""
	coin_result_text.text = ""
	spin_box.max_value = money

func flipCoin(wager :int) -> void:
	var result :int
	if playerChoice == 0:
		your_choice_text.text = "Your Choice: Heads"
	else:
		your_choice_text.text = "Your Choice: Tails"
	var coinResult :int = randi_range(0,1)
	if coinResult == 0:
		coin_result_text.text = "Coin Result: Heads"
		heads_texture.show()
		animation_player.play("coinHeads")
	else:
		coin_result_text.text = "Coin Result: Tails"
		tails_texture.show()
		animation_player.play("coin")
	print(coin_result_text.text)
	if playerChoice == coinResult:
		result = 1
		score += 1
		plus_one_text.show()
		animation_player_2.play("Text +1")
	else:
		result = 0
		checkStreak(score)
		score = 0
	score_text.text = "Streak: " + str(score)
	processBet(wager, result)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	money_text.text = "Money: " + str(money)
	startRound()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func button1Pressed() -> void:
	buttonHandler(0)


func button2Pressed() -> void:
	buttonHandler(1)


func _on_button_3_pressed() -> void:
	startRound()
