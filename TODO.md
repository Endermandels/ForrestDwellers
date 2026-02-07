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
- [High Bar]: Collect items and armor for yourself and your companions

## Mechanics
### Beginning
- Choose your starting companion
- Your player character always starts with the same stats
### Game Loop
- Battle Start
- Battle
- Battle Resolution
- Event #1
- Event #2
- Repeat until final battle
### Battle Start
- Encounter 1-3 enemies
- Player can have up to 2 animal companions
- Turn order starts with the highest speed stat and goes to the lowest speed stat
### Battle
- The following applies to the player or animal whose turn it is:
- Resolve start of turn effects (gain 1 atk if you have armor, etc.)
- Choose an action: Attack, Special Ability, Flee
    - Attack: Choose an enemy and attack it
    - Special Ability: If you have enough MP, you may use this option
    - Flee: Exit the fight and the slowest party member suffers DMG equal to half the strongest enemy's ATK.  Enemies are unable to flee by default. Cannot flee from the final boss
- If no enemies remain, go to Battle Resolution
- Resolve end of turn effects (poison, etc.)
### Battle Resolution
- If the player dies, Game Over
- Otherwise, party members gain XP scaled to the number and difficulty of the enemies
- Some animals drop different items used for trading with the trader
### Event #1
- Campfire: Heal a party member
### Event #2
- Trader: Must trade all animal loot for increased stats on one or more party members
- Blue Fairy: Offer to increase a chosen party member's MP.  However, it may be a trick fairy which will also drain your party member's MP to half.
- Red Fairy: Offer to swap a stat on one party member with a different stat on a different party member.  If solo, swap a stat within the player's stats. However, it may be a trick fairy which will swap two random stats on the selected party members.
- Green Fairy: TODO

## Stats
- HP (reach critical HP at 5% max HP)
- ATK (temporarily reduced by 1 at critical HP)
- ARMOR (reduced on attack and does not regenerate during battle)
- SPD (temporarily reduced by 1 at critical HP)
- MP (reduced when using a special ability or for a passive ability)

## Start of Turn Effects (in order)
- Stun X: Skip action phase. Reduce X by 1. When X is 0, remove.
- Intimidate X: Temporarily reduce ATK by X this turn.  Remove.

## End of Turn Effects (in order)
- Bleed X: Deal X damage.  Reduce X by 1.  When X is 0, remove.
- Poison X: Deal 1 damage.  Increase damage dealt by 1 until damage dealt is X.
- Regenerate X: Heal X. Reduce X by 1. When X is 0, remove.
- Fly X: Cannot be attacked until its next turn.  Reduce X by 1.  When X is 0, remove.
- DEATH CHECK: If HP is 0, this animal is dead

## Animals
### Wolf
- Starter animal
- +ATK, +SPD, 0 ARMOR
- Howl: Spend MP to give all enemies Intimidate 1

### Owl
- Starter animal
- -HP, 0 ARMOR
- Silent Flight: Spend MP to gain Fly 2
- Passive: Cannot be Intimidated

### Snake
- -ATK, 0 ARMOR
- Shed: Spend MP to remove all status effects and gain 1 SPD for the rest of the battle
- Passive: On a successful attack that reduces the target's HP, spend MP to give that target Poison 1

### Bear
- +HP, +ATK, 0 SPD, +ARMOR
- Sleep: Spend MP to gain Stun 2 and Regenerate 4

### Elk
- +SPD, 0 ARMOR

# February
- Develop Game Description and Plan
- Create MVP

# March
- Create Smooth UI and Assets

# April
- Market Game



