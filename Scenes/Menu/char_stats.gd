extends Control

@onready var texture_rect = $HBoxContainer/TextureRect

@onready var char_name = $HBoxContainer/VBoxContainer/CharacterNameAndLevel/CharName
@onready var lvl_quantity = $HBoxContainer/VBoxContainer/CharacterNameAndLevel/LvlQuantity


@onready var current_hp = $HBoxContainer/VBoxContainer/HPContainer/CurrentHP
@onready var max_hp = $HBoxContainer/VBoxContainer/HPContainer/MaxHP

@onready var current_mp = $HBoxContainer/VBoxContainer/MPContainer/CurrentMP
@onready var max_mp = $HBoxContainer/VBoxContainer/MPContainer/MaxMP

@onready var level_text = $HBoxContainer/VBoxContainer/LevelText
@onready var progress_bar = $HBoxContainer/VBoxContainer/ProgressBar
