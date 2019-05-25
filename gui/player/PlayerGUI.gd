extends CanvasLayer

func _ready() -> void:
	GameManager.player_gui = self

func on_Player_update_health(_value) -> void:
	$Margin/Container/HBoxContainer/VBoxContainer/HeatlhContainer/HealthBar.value = _value
	
func on_Player_update_power(_value) -> void:
	$Margin/Container/HBoxContainer/VBoxContainer/PowerContainer/PowerBar.value = _value
	
func on_Player_update_combo(_value) -> void:
	$Margin/Container/HBoxContainer/VBoxContainer2/ComboContainer/ComboBar.value = _value
	
func on_Player_update_combo_level(_value) -> void:
	$Margin/Container/HBoxContainer/VBoxContainer2/ComboContainer/ComboCounter.text = str(_value)
	
func on_Player_update_xp(_value) -> void:
	$Margin/Container/HBoxContainer/VBoxContainer2/XPContainer/VBoxContainer/XPCounter.text = str(_value)
	
func on_Game_old_life_picked() -> void:
	$Margin/Container/HBoxContainer/VBoxContainer/HeatlhContainer/Life.show()

func on_Game_player_died() -> void:
	$Margin/Container/HBoxContainer/VBoxContainer/HeatlhContainer/Life.hide()
