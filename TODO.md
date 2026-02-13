# Game Ideas
1. Forrest themed, start with companion animal, gain animals as you go through the woods, animals have persistent stats, come across different events which heal or power up you or your creatures.  Mission: Dragon that attacked your town, and the person who defeats the dragon gets the King's daughter in marriage. Obstacles: Other woodland creatures, Dragon.

2. Play as a dragon.  Adventurers travel into your cave seeking to kill you and/or take your treasures.  You have to exit the cave in order to find food to eat.  There is a chance adventurers will either take your treasures or set up an ambush for you when you return.  Start with a lot of health and magic.  However, as time goes on and you fight more heros, your strength decreases.  Mission: Retain as much power as possible for the final fight against the HERO.  Choices: When to leave your home, when to return, what abilities to use.

3. You play as an animal.  Mission: Survive until you find a mate.  Hunger, thirst, shelter from natural disasters.  Predator: gain stats and special abilities defeating different animals, but your hunger increases faster.  Prey: food is abundant, but you have to out maneuver predators.  He Is Coming movement style with gates for certain types of animals, to make it easier for prey to run away.

## Chosen Game: Forrest Dwellers (1)

# Game Description

## Objective
- Slay the Dragon.

## How to reach the objective
- Gather animals along the way (or don't)
- Upgrade stats through events and battles
- Collect items and armor for yourself and your companions

## Mechanics
### Game Loop
- Battle Start
- Battle
- Battle Resolution
- Event #1
- Event #2
- Repeat until final battle
### Battle Start
- For the first battle, encounter a starting animal with 100% chance to ask to join the player on its first turn
- Otherwise, encounter 1-3 enemies
- Player can have up to 3 animal companions
- Turn order starts with the highest speed stat and goes to the lowest speed stat
- Resolve Battle Start effects
### Battle
- The following applies to the player or animal whose turn it is:
- Resolve start of turn effects (stun, etc.)
- If it is the player's turn, choose which animal(s) to attack
- Otherwise, choose which animal(s) to attack based on attack preference
- If it is an enemy, it may offer to join the Player's group on its turn instead of attacking.  This is made more likely based on how low the enemy's health is.
- If no enemies remain or the player dies, go to Battle Resolution
- Resolve end of turn effects (poison, etc.)
### Battle Resolution
- If the player dies, Game Over
- Otherwise, party members gain XP scaled to the number and difficulty of the enemies
- When an animal or player levels up, their stats increase (except MP)
- Some animals drop different items (pelts, teeth, etc.) used for trading with the trader
### Event #1
- Campfire: Heal a party member (HP and MP restored).  May heal another party member, but if you do there is a risk that it will be healed halfway and Event #2 will be skipped.
### Event #2
- Trader: May trade animal loot for items (like in He Is Coming).
- Blue Fairy: Offer to increase a chosen party member's MP.  However, it may be a trick fairy which will also drain your party member's MP to half.
- Red Fairy: Offer to sacrifice an animal to give half its stats to a different party member.  However, it may be a trick fairy which will just give all of one stat to the other party member.
- Green Fairy: Infuse one of your animal's special ability into another party member (yes even the player).  This can stack.  However, it may be a trick fairy, and the party member who received the ability may die.  The odds of the party member dying increase each time that particular party member is infused with another animal's ability.

## Stats
- HP (reach critical HP at 5% max HP)
- ATK (temporarily reduced by 1 at critical HP)
- ARM (reduced on attack and does not regenerate during battle)
- SPD (temporarily reduced by 1 at critical HP)
- MP (reduced when using a special ability or for a passive ability)
- ITM (how many Items this unit can carry)

## Start of Turn Effects (in order)
- Stun X: Skip action phase. Reduce X by 1. When X is 0, remove.
- Stench X: X/(if party member: 30 else: 10) chance to flee the confrontation. Reduce by 1. When X is 0, remove.
- Intimidate X: Temporarily reduce ATK by X this turn.  Remove.
- Rejuvinate X: Restore X MP. Reduce X by 1. When X is 0, remove.
- Acid X: Remove X ARMOR or deal 1 DMG if ARMOR is already 0. Reduce X by 1. When X is 0, remove.
- Burn X: Deal X DMG. Reduce X by 1.  When X is 0, remove.
- Fly X: Cannot interact with ground units until its next turn.  Reduce X by 1.  When X is 0, remove.
- Regenerate X: Restore X HP. Reduce X by 1. When X is 0, remove.
- DEATH CHECK: If HP is 0, this animal is dead

## End of Turn Effects (in order)
- Bleed X: Deal X DMG (ignore ARMOR).  Reduce X by 1.  When X is 0, remove.
- Poison X: Deal 1 DMG (ignore ARMOR).  Increase DMG dealt by 1 until DMG dealt is X.
- DEATH CHECK: If HP is 0, this animal is dead

## Key Terms
- Targets: Targets a specific type of unit first, then randomly.
- Battle Start: At the start of the battle
- Turn Start: At the start of this unit's turn
- Wounded: When this unit falls below 50% HP
- On Hit: When this unit hits another unit
- On Hurt: When this unit is hit by another unit
- Wounded On Hurt: When this unit falls below 50% HP on an attack from another unit
- Drained: When this unit hits 0 MP
- Passive: Always applicable
- Discard: Remove this item from inventory after use
- Alternate X: At the start of every X turn (X = 3 means every third turn)
- One Time Passive: A passive that is applicable only once

## Items
- P Items can be equipped on the player.
- A Items may be equipped on animals.
- PA Items may be equipped on either.
- Rarity is: Common (50%), Uncommon (35%), Rare (14%), Epic (1%)

### Bandage
- Common
- PA
- Wounded: Gain Regenerate 3. Discard.

### Stimulant Herb
- Common
- PA
- Battle Start: Gain Rejuvinate 1. Discard.

### Mana Leaf
- Common
- PA
- Drained: Restore 1 MP. Discard.

### Rusty Dagger
- Common
- PA
- On Hit: If the target has ARMOR, deal 1 DMG

### Filthy Rags
- Common
- PA
- Battle Start: Gain Stench 1
- On Hit: Give Stench 1

### Torch
- Common
- PA
- On Hit: 1/5 chance to give Burn 1

### Healing Potion
- Uncommon
- PA
- Wounded: Restore 5 HP. Discard.

### Elixer
- Uncommon
- PA
- Drained: Gain Rejuvinate 3. Discard.

### Shield of Protection
- Uncommon
- P
- Passive: Gain 4 ARMOR (applies like He Is Coming)

### Sword of Slashing
- Uncommon
- P
- Passive: Gain 2 ATK

### Boots of Speed
- Uncommon
- P
- Passive: Gain 3 SPD

### Sharp Dagger
- Uncommon
- PA
- On Hit: If the target has 0 ARMOR, give the target Bleed 2

### Acid Flask
- Uncommon
- P
- Battle Start: Target enemy gains 2 Acid. Discard

### Reeking Flask
- Uncommon
- P
- Battle Start: Target enemy gains 3 Stench. Discard

### Molting Charm
- Uncommon
- A
- Wounded: Spend 1 MP to remove all status effects and gain Regenerate 2

### Serrated Collar
- Uncommon
- A
- On Hit: If the target has 0 ARMOR, deal 1 DMG

### Reeking Bladder
- Uncommon
- PA
- Battle Start: Gain 1 Stench
- On Hurt: The attacker gains Stench 5. Discard

### Acidic Bladder
- Uncommon
- PA
- Battle Start: Gain 1 Acid
- On Hurt: The attacker gains Acid 4. Discard

### Life Root
- Rare
- PA
- Wounded: Restore full HP. Discard.

### Poison Dagger
- Rare
- PA
- On Hit: Give the target Poison 1 if their ARMOR is 0

### Iron spikes
- Rare
- PA
- On Hurt: Deal 1 DMG to the attacker

### Venom Coating
- Rare
- PA
- Passive: When dealing DMG On Hurt, give the attacker Poison 1 if their ARMOR is 0

### Venomous Fang
- Rare
- A
- Passive: When this unit applies Poison, apply an extra Poison

### Hunter's Whistle
- Rare
- P
- Battle Start: Choose one of your animals to start first

### Leader's Whistle
- Rare
- P
- Battle Start: Increase the odds of enemy animals asking to join your party

### Arcane Stone
- Epic
- PA
- Passive: For every effect applied on this unit, gain Rejuvinate equal to that effect

### Divine Protection
- Epic
- A
- One Time Passive: If this animal should die, it lives on 1 HP, clears all status effects, and gains Fly 1

### Vampire's Fang
- Epic
- PA
- On Hit: Deal 1 DMG.  For each DMG dealt, gain Regenerate 1.

## Units
### Player
- HP    20
- ATK   1
- ARMOR 0
- SPD   0
- MP    5
- ITEM  8

### Wolf
- Starter animal
- Targets: Highest ATK
- HP    10
- ATK   5
- ARMOR 0
- SPD   5
- MP    5
- ITEM  1
- Battle Start: Spend 1 MP to give all ground enemies Intimidate 1

### Owl
- Starter animal
- Targets: Lowest Max HP
- HP    7
- ATK   2
- ARMOR 0
- SPD   6
- MP    8
- ITEM  1
- Alternate 2: Gain Fly 1
- Passive: CONDITION(flying), this unit cannot be targeted

### Snake
- Starter animal
- Targets: Highest Max HP
- HP    8
- ATK   1
- ARMOR 0
- SPD   3
- MP    4
- ITEM  1
- On Hit: CONDITION(Enemy.ARMOR == 0), spend 1 MP to give that target Poison 1
- Wounded: Remove all status effects on this animal and gain 2 SPD

### Turtle
- Starter animal
- Targets: Random
- HP    7
- ATK   1
- ARMOR 10
- SPD   0
- MP    3
- ITEM  1
- Turn Start: CONDITION(self.ARMOR > 0), Spend 1 MP to gain an extra strike this turn
- Turn Start: CONDITION(self.ARMOR == 0), gain 1 SPD

### Porcupine
- Starter animal
- Targets: Random
- HP    7
- ATK   1
- ARMOR 0
- SPD   1
- MP    3
- ITEM  1
- Battle Start: Spend 1 MP to give all ground enemies Stench 1
- On Hurt: Deal 1 DMG to the attacker.  Trigger this animal's On Hit abilities

### Vulture
- Starter animal
- Targets: Lowest HP
- HP    8
- ATK   2
- ARMOR 0
- SPD   5
- MP    3
- ITEM  1
- Battle Start: Gain Fly 2
- Alternate 4: Gain Fly 2
- Wounded On Hurt: Spend 1 MP to give the attacker Acid 3.

### Bear
- Targets: Highest ATK
- HP    12
- ATK   4
- ARMOR 2
- SPD   1
- MP    2
- ITEM  1
- Battle Start: Spend 1 MP to give ground enemies Intimidate 1
- On Hit: CONDITION(Enemy.HP == Enemy.Base_HP), give that target Stun 1

### Dragon
- Targets: Random
- HP    20
- ATK   10
- ARMOR 15
- SPD   3
- MP    10
- ITEM  0
- Battle Start: Spend 1 MP to give all enemies Intimidate 2
- Alternate 4: Spend 1 MP to deal 4 DMG to every enemy.  1/10 Chance to give each afflicted enemy Burn 2
- Alternate 3: Gain Fly 2
- Passive: Immune to Stench

# February
- Develop Game Description and Plan
- Develop Battle
- Develop Crude UI and Assets

# March
- Develop Event #1
- Develop Event #2
- Develop Smooth UI
- Develop Nice Assets

# April
- Develop SFX 
- Develop Music
- Playtest and Balance
- Market Game
