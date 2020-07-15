extends Sprite

var gameWidth: int = OS.get_window_size().x
var gameHeight: int = OS.get_window_size().y
var spriteWidth: int = get_texture().get_width()
var spriteHeight: int = get_texture().get_height()
var halfSpriteHeight: int = spriteHeight / 2
var halfSpriteWidth: int = spriteWidth / 2
export var currentSpeed: float = 1000.0

enum STATE {LEFT,RIGHT,UP,DOWN,IDLE}
var currentState: int = STATE.IDLE

# Limits
var lowerLimit: int = gameHeight - halfSpriteHeight
var upperLimit: int = 0 + halfSpriteHeight
var leftLimit: int = 0 + halfSpriteWidth
var rightLimit: int = gameWidth - halfSpriteWidth

func _enter_tree():
	positionMiddle()

func _physics_process(delta: float) -> void:
	moveRight(delta)
	moveLeft(delta)
	moveUp(delta)
	moveDown(delta)

# Causes Small Issues
# we will always enter the event.pressed false once
# we cannot move in two directions at the same time
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		print(event.pressed)
		if event.pressed:
			if event.scancode == KEY_D:
				currentState = STATE.RIGHT
			
			if event.scancode == KEY_A:
				currentState = STATE.LEFT
			
			if event.scancode == KEY_W:
				currentState = STATE.UP
			
			if event.scancode == KEY_S:
				currentState = STATE.DOWN
		elif event.pressed == false:
			currentState = STATE.IDLE

func moveRight(delta: float) -> void:
	if currentState == STATE.RIGHT:
		if position.x < rightLimit:
			position.x += currentSpeed * delta
		if position.x > rightLimit:
			position.x = rightLimit

func moveLeft(delta: float) -> void:
	if currentState == STATE.LEFT:
		if position.x > leftLimit:
			position.x -= currentSpeed * delta
		if position.x < leftLimit:
			position.x = leftLimit

func moveUp(delta: float) -> void:
	if currentState == STATE.UP:
		if position.y > upperLimit:
			position.y -= currentSpeed * delta
		if position.y < upperLimit:
			position.y = upperLimit

func moveDown(delta: float) -> void:
	if currentState == STATE.DOWN:
		if position.y < lowerLimit:
			position.y += currentSpeed * delta
		if position.y > lowerLimit:
			position.y = lowerLimit




func positionMiddle() -> void:
	self.position.x = gameWidth / 2
	self.position.y = gameHeight / 2
