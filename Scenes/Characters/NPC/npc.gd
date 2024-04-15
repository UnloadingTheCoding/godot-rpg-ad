extends CharacterBody2D


@export var NPCSprite: Sprite2D


@onready var npc_texture = $NPCTexture


func _ready():
	npc_texture.texture = NPCSprite
	
	

