User.destroy_all
Character.destroy_all
Item.destroy_all
Enemy.destroy_all
Encounter.destroy_all

#Users====================================================================================================================
nina = User.create(user_name: "ninas", password: "dog")
test_user = User.create(user_name: "test", password: "testy")
ben = User.create(user_name: "ben", password: "benny")

#Enemies====================================================================================================================
#Enemies --- Level 1
goblin = Enemy.create(name: "Goblin", role: "Jailor", description: "A goblin with a sword", hp: [75,80,100].sample, level: 1, attack_power: [5,6,8].sample, encounter_id: nil, boss: false)
varos = Enemy.create(name: 'Varos', role: 'Guard', description: 'Trash', hp: 50, level: 1, attack_power: 3, encounter_id: 1, boss:false)
# ghost = Enemy.create(name: "Ghost", role: "Mage", description: "A spooky ghost with magical powers", hp: 100, level: 1),
# yeti = Enemy.create(name: "Yeti", role: "Warrior", description: "A beefy yeti", hp: 100, level: 1),

#Boss --- Level 1
dragon = Enemy.create(name: "Dragon", role: "Boss", description: "A fire-breathing dragon", hp: 200, level: 10)

#Characters===================================================================================================================
#Characters --- Level 1
grimsborth = Character.create(name: 'Grimsborth', role: 'Warrior', description: 'Combatant', hp: 150, level: 1, experience_points: 0, attack_power: [8,9,10].sample, current_weapon: 'Basic Broadsword', base_hp: 150)
kinklesburg = Character.create(name: "Kinklesburg", role: "Mercenary", description: "", hp: 100, level: 1, experience_points: 0, attack_power: [6,7,8].sample, current_weapon: "Basic Knife", base_hp: 100)
croseus = Character.create(name: "Croseus", role: "Huntress", description: "", hp: 110, level: 1, experience_points: 0, attack_power: [5,6,7].sample, current_weapon: 'Basic Bow', base_hp: 110)
luminol = Character.create(name: "Luminol", role: "Mage", description: "", hp: 90, level: 1, experience_points: 0, attack_power: [9,10,11].sample, current_weapon: 'Basic Staff', base_hp: 90)

#Encounters===================================================================================================================
first_encounter = Encounter.create(enemy: true, item: false, result: nil, character_id: grimsborth.id)


#Items====================================================================================================================
# healing_potion = Item.create(name: "Healing Potion", item_type: "Potion", description: "Healing liquid in a bottle", character_id: azula.id),
# speed_potion = Item.create(name: "Speed Potion", item_type: "Potion", description: "+1 Speed", character_id: azula.id),
# broadsword = Item.create(name: "Broadsword", item_type: "Weapon", description: "+5 Strength", character_id: azula.id)

