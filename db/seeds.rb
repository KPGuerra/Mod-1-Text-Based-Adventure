User.destroy_all
Character.destroy_all
Item.destroy_all
Enemy.destroy_all
Encounter.destroy_all

nina = User.create(user_name: "ninas", password: "dog")

characters = [
    Character.create(name: "Grimsborth", role: "Huntress", description: "", hp: 100, level: 1, experience_points: 0, user_id: nina.id ),
    Character.create(name: "Azula", role: "Rogue", description: "Lighting girl", hp: 100, level: 1, experience_points: 0, user_id: nina.id),
    Character.create(name: "Azula", role: "Warrior", description: "Lighting girl", hp: 100, level: 1, experience_points: 0, user_id: nina.id),
    Character.create(name: "Azula", role: "Healer", description: "Lighting girl", hp: 100, level: 1, experience_points: 0, user_id: nina.id)
    ]

enemies = [
    goblin = Enemy.create(name: "Goblin", role: "Warrior", description: "A goblin with a sword", hp: 100, level: 1),
    ghost = Enemy.create(name: "Ghost", role: "Mage", description: "A spooky ghost with magical powers", hp: 100, level: 1),
    yeti = Enemy.create(name: "Yeti", role: "Warrior", description: "A beefy yeti", hp: 100, level: 1),
    dragon = Enemy.create(name: "Dragon", role: "Boss", description: "A fire-breathing dragon", hp: 200, level: 10)
]

items = [
    healing_potion = Item.create(name: "Healing Potion", item_type: "Potion", description: "Healing liquid in a bottle", character_id: azula.id),
    speed_potion = Item.create(name: "Speed Potion", item_type: "Potion", description: "+1 Speed", character_id: azula.id),
    broadsword = Item.create(name: "Broadsword", item_type: "Weapon", description: "+5 Strength", character_id: azula.id)

]

