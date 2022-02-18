extends Node
#handles saves, antennas, places, etc

var data = SaveClass.new()

var save="user://save.res"
var denpamaterial = preload("res://materials/denpa.tres")

var places = {
  "catch":"res://scenes/game/CatchScrn.tscn"
}

enum heads { #DPM3 SPEC
  #UNKNOWN AND WHAT to change
  ROUND,  OVAL,  OVAL_V,  NINETYDEGREES,  R_NINETY,
  TVBOX,  R_TVBOX,  DROP,  VASE,  BEAR,  COMICSPEECH,
  THREEPRONGS,  TWOPRONGS,  SQUID,  unknown,  STAR,
  TEDDY,  HEART,  DEVIL,  CRESCENT,  UGLY,  TV_W_SPEAKERS,
  EGG,  YACHT,  DOG,  MESSY_HAIR,  IMP,  TRICORNE,
  UNICORNE,  SUNFLOWER,  BUNNY,  CAKE,  TOWER,  LEGO,
  CAT,  SATURN,  WHAT,  VASE_TWO,  SPHERE
}
enum face { #DPM3 SPEC
  PENTAGON,
  TRAPEZE,
  PUFFYCHEEKS,
  TRIANGLE,
  OVAL,
  DEE,
  ROUNDED_RECT,
  CIRCLE,
  PENTAGON_PUFFY,
  OUTSTANDING_CHIN,
  WEIRD,
  PUFFYTALL
}
enum mouth {
  
  }
enum eyes {
  
  }
enum brows {}
enum hair {
  NONE,
  BABY,
  SIDEBANGS,
  CURLY,
  SIDEBURN,
  
 }
const colors := {
  "RED":        Color(0.717647, 0.227451, 0.227451),
  "WHITE":      Color(0.788235, 0.788235, 0.788235),
  "BLACK":      Color(0, 0, 0),
  "PINK":       Color(0.851471, 0.386719, 1),
  "BLUE":       Color(0, 0.039216, 1),
  "ORANGE":     Color(1, 0.515625, 0),
  "GREEN":      Color(0.027451, 0.827451, 0),
  "YELLOW":     Color(0.886275, 0.87451, 0),
  "LIGHT_BLUE": Color(0, 0.835294, 1),
  "PURPLE":     Color(0.501961, 0, 1),
  "SILVER":     Color(0.431373, 0.431373, 0.45098),
  "GOLD":       Color(0.541176, 0.407843, 0.121569)
  }

func _ready():
  var f = File.new()
  if f.file_exists(save):
    data=load(save)

func change_scene(target:String, delay=0.5):
  yield(get_tree().create_timer(delay), "timeout")
  assert(get_tree().change_scene(places[target]) == OK)
  return

func add_caught(target):
  var scene=PackedScene.new()
  data.caught.append(scene.pack(target))
  return

func get_random(dict):
   var a = dict.keys()
   a = a[randi() % a.size()]
   return a
