extends Effect
class_name DamageEffect

@export var dmg: int = 1
@export var dmg_per_stack: int = 0 ## how much damage is dealt per stack left
@export var dmg_up_to_stacks: bool = false ## whether to increase DMG up to Stacks
@export var pure: bool = false ## whether to ignore armor

func apply(_source: Stats, target: Stats, stacks: int = 0) -> void:
	var game_state = BattleLogic.game_state
	var remaining_dmg = 0
	var dmg_to_apply = dmg + (dmg_per_stack * stacks) # Modify DMG with stacks

	dmg_to_apply = max(dmg_to_apply, 0) # Do at least 0 DMG
	
	print("* [%s] received %d%sDMG" % [target.name_id, dmg_to_apply, " Pure " if pure else " "])
	remaining_dmg = dmg_to_apply

	if not pure:
		remaining_dmg = max(dmg_to_apply - target.arm, 0) # Reduce DMG by ARM
		target.arm = max(target.arm - dmg_to_apply, 0) # Reduce ARM by DMG

	target.hp = max(target.hp - remaining_dmg, 0) # Reduce HP by remaining DMG

	if dmg_up_to_stacks:
		dmg = min(dmg + 1, stacks) # Increase DMG up to stacks

	# Check for Wounded trigger
	if target.hp < float(target.base_hp) / 2:
		# Check that Wounded has not already been triggered
		if not target.wounded:
			target.wounded = true
			# Trigger Wounded Abilities
			for a in target.abilities[Enums.Trigger.WOUNDED]:
				game_state.abilities_queue.insert(game_state.cur_ability_idx + 1, a)