extends KinematicBody

onready var animplayer = $AnimationPlayer

export(String) var chosen_name = ""
export(int) var level = 90

export(int) var color = 0 #possibly enum
export(int) var antenna = 0 #possibly enum

export(int) var head = 0    #possibly enum
export(int) var face = 0    #possibly enum
export(int) var hair = 0    #possibly enum
export(int) var eyes = 0    #possibly enum
export(int) var mouth = 0    #possibly enum
export(int) var nose = 0    #possibly enum
export(int) var glasses = 0    #possibly enum

export(int) var ATK = 0
export(int) var DEF = 0
export(int) var SPD = 0
export(int) var EVA = 0
export(int) var mHP = 0
export(int) var mAP = 0

export(PoolByteArray) var preview = null

export(String) var origin = "" #for wifi generation

enum states {IDLE, THROW, WANDER, FOLLOW}

var _current_state=states.IDLE

func _physics_process(_delta):
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

func nuclearize() -> void:
  #play animation to dissolve and show particles
  queue_free()
  return

func spawn() -> void:
  #play animation to fade in and show water thingy
  return
