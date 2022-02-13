extends KinematicBody

onready var animplayer = $AnimationPlayer

export(String) var chosen_name = ""
export(int) var level = 90

export(int) var antenna = 0 #possibly enum
export(int) var head = 0    #possibly enum
export(int) var face = 0    #possibly enum
export(int) var hair = 0    #possibly enum
export(int) var eyes = 0    #possibly enum
export(int) var mouth = 0    #possibly enum
export(int) var nose = 0    #possibly enum
export(int) var glasses = 0    #possibly enum
var color = 0


var origin = null #for wifi generation

enum states {IDLE, THROW, WANDER, FOLLOW}

var _current_state=states.IDLE

func _physics_process(delta):
  match _current_state:
    states.IDLE:
      Idle()
    states.THROW:
      Throw()
    states.WANDER:
      Wander()
    states.FOLLOW:
      #Wander(target)
      pass

  return

func Wander() -> void:

  return

func Throw() -> void:
  return

func Idle() -> void:
  if !(animplayer.is_playing()):
    match randi() % 5:
      0:
        #play sitting anim
        pass
      1:
        #play look around
        pass
      3:
        _current_state=states.WANDER
      4:
        _current_state=states.THROW
      5:
        pass # nothing
  return
