extends Control

onready var DName=$Paper/Generic/Name
onready var LV=$Paper/Generic/LV2
onready var mHP=$Paper/VBoxContainer/Stats/Values/HP
onready var mAP=$Paper/VBoxContainer/Stats/Values/AP
onready var ATK=$Paper/VBoxContainer/Stats/Values/ATK
onready var DEF=$Paper/VBoxContainer/Stats/Values/DEF
onready var SPD=$Paper/VBoxContainer/Stats/Values/SPD
onready var EVA=$Paper/VBoxContainer/Stats/Values/EVA
onready var Weak=$Paper/VBoxContainer/Weaknesses
onready var Acquire=$Paper/VBoxContainer/Acquired
onready var Antenna=$Paper/Antenna

onready var world = $ViewportContainer/Viewport/Catch


func _ready() -> void:
  update_catch()
  return

func update_catch() -> void:
  var tar = load("user://test.scn").instance()
  DName.text   = tar.chosen_name
  LV.text      = str(tar.level)
  mHP.text     = str(tar.mHP)
  mAP.text     = str(tar.mAP)
  ATK.text     = str(tar.ATK)
  DEF.text     = str(tar.DEF)
  SPD.text     = str(tar.SPD)
  EVA.text     = str(tar.EVA)
  Weak.text    = str(tar.color)
  Acquire.text = tar.origin
  Antenna.text = str(tar.antenna)

  world.add_child(tar)
  return
