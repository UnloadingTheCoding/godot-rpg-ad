extends Node


signal change_game_state(String)
signal warning(String)
signal warning_closed

#DialogSignals
signal dialog_lines(PackedStringArray)
signal is_dialog_complete()

#EntranceExit Signal
signal current_portal(String)
signal scene_changed

signal pause_controls

#ShopMenu Signals
signal shop_sell_item_emitter
signal description_update(String)
signal open_buy_sell_window(String)
signal item_position(int)
signal update_current_buy_sell_item_name(String)
