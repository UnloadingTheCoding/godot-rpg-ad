extends Node


signal change_game_state(String)

#DialogSignals
signal dialog_lines(PackedStringArray)
signal is_dialog_complete()

#EntranceExit Signal
signal current_portal(String)

signal pause_controls

#ShopMenu Signals
signal description_update(String)
signal open_buy_sell_window
