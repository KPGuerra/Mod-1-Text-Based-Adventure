User.destroy_all
Character.destroy_all
Item.destroy_all
Enemy.destroy_all
Battle.destroy_all

User.create(name: "Nina", user_name: "ninas", password: "dog")

Character.create(name: "Azula", class: "Mage", description: "Lighting girl", hp: 100, level: 1, experience_points: 0, user_id: 1)