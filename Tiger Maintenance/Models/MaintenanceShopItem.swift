import Foundation


struct MaintenanceShopItem: Identifiable {
    let id: String
    let item: String
    let price: Int
    let items: [String]
}

let foodShopItems = [
    MaintenanceShopItem(id: "food_1", item: "shop_food_1", price: 1000, items: ["food_11", "food_12", "food_10"]),
    MaintenanceShopItem(id: "food_2", item: "shop_food_2", price: 5000, items: ["food_14", "food_13", "food_15"]),
    MaintenanceShopItem(id: "food_3", item: "shop_food_3", price: 10000, items: ["food_17", "food_16", "food_9"])
]

let guestsShopItems = [
    MaintenanceShopItem(id: "guests_1", item: "shop_guests_1", price: 15000, items: ["guest_2"]),
    MaintenanceShopItem(id: "guests_2", item: "shop_guests_2", price: 20000, items: ["guest_3"]),
    MaintenanceShopItem(id: "guests_3", item: "shop_guests_3", price: 25000, items: ["guest_4"]),
    MaintenanceShopItem(id: "guests_4", item: "shop_guests_4", price: 30000, items: ["guest_5", "guest_6"]),
    MaintenanceShopItem(id: "guests_5", item: "shop_guests_5", price: 35000, items: ["guest_7", "guest_8"]),
    MaintenanceShopItem(id: "guests_6", item: "shop_guests_6", price: 40000, items: ["guest_9", "guest_10"])
]
