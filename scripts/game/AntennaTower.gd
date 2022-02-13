extends Control

export(Color) var inSight = Color(0.572549, 0.388235, 0.670588)

onready var camera=$ViewportContainer/Viewport/Spatial/Player
onready var Crosshair=$Crosshair
onready var Name=$HBoxContainer/Name
onready var Level=$HBoxContainer/Level
onready var Antenna=$HBoxContainer/Antenna

func _ready() -> void:
  camera.connect("available", self, "on_available")
  camera.connect("not_available", self, "on_gone")
  return

func on_available(target = null) -> void:
  Crosshair.modulate=inSight
  if target:
    Name.text = target.chosen_name
    Level.text = "Level: "+str(target.level)
    #Antenna.text =
    Name.show()
    Level.show()
    Antenna.show()

func on_gone() -> void:
  Crosshair.modulate=Color(1,1,1)
  Name.hide()
  Level.hide()
  Antenna.hide()
