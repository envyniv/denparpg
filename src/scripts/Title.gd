extends Control

onready var game = $Logo/VBoxContainer/Game
onready var set  = $Logo/VBoxContainer/Options
onready var exit = $Logo/VBoxContainer/Exit

func _ready() -> void:
  game.connect("pressed", self, "_on_game")
  set.connect("pressed", self, "_on_set")
  exit.connect("pressed", self, "_on_exit")
  return

func _on_game() -> void:
  SceneMan.change_scene("Antenna")
  return

func _on_set() -> void:
  SceneMan.change_scene("Settings")
  return

func _on_exit() -> void:
  get_tree().quit()
  return
