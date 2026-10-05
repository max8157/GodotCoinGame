extends Node2D
var playerChoice :int = 0
var score :int = 0 
var bestStreak :int = 0
var coinType :int = 0
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

func checkStreak(streak):
	if streak >= bestStreak:
		bestStreak = streak
		best_streak.text = "Best Streak = " + str(bestStreak)
	else:
		return

func startRound() -> void:
	plus_one_text.hide()
	heads_texture.hide()
	tails_texture.hide()
	button_3.hide()
	button.show()
	button_2.show()
	your_choice_text.text = ""
	coin_result_text.text = ""

func flipCoin() -> void:
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
		score += 1
		plus_one_text.show()
		animation_player_2.play("Text +1")
	else:
		checkStreak(score)
		score = 0
	score_text.text = "Streak: " + str(score)
	button_3.show()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	startRound()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func button1Pressed() -> void:
	playerChoice = 0
	button.hide()
	button_2.hide()
	flipCoin()


func button2Pressed() -> void:
	playerChoice = 1
	button.hide()
	button_2.hide()
	flipCoin()


func _on_button_3_pressed() -> void:
	startRound()
