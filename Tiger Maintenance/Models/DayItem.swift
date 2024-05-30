import Foundation
import SwiftyJSON

struct DayItem: Identifiable {
    let id: String
    let dayNum: Int
    let customers: Int
    let time: Int
}


struct MaintenanceAppDO: Codable {
    var appsflyer: JSON
    var facebook_deeplink: String
}

struct MaintenanceAppDT: Decodable {
    var client_id: String
    var session_id: String
    var response: String?
}

let days = [
    DayItem(id: "day_1", dayNum: 1, customers: 3, time: 40),
    DayItem(id: "day_2", dayNum: 2, customers: 5, time: 50),
    DayItem(id: "day_3", dayNum: 3, customers: 6, time: 55),
    DayItem(id: "day_4", dayNum: 4, customers: 7, time: 60),
    DayItem(id: "day_5", dayNum: 5, customers: 8, time: 70),
    DayItem(id: "day_6", dayNum: 6, customers: 9, time: 80),
    DayItem(id: "day_7", dayNum: 7, customers: 10, time: 90),
    DayItem(id: "day_8", dayNum: 8, customers: 11, time: 100),
    DayItem(id: "day_9", dayNum: 9, customers: 13, time: 120),
    DayItem(id: "day_10", dayNum: 10, customers: 15, time: 130),
    DayItem(id: "day_11", dayNum: 11, customers: 16, time: 140),
    DayItem(id: "day_12", dayNum: 12, customers: 17, time: 150),
    DayItem(id: "day_13", dayNum: 13, customers: 18, time: 160),
    DayItem(id: "day_14", dayNum: 14, customers: 19, time: 150),
    DayItem(id: "day_15", dayNum: 15, customers: 20, time: 160),
    DayItem(id: "day_16", dayNum: 16, customers: 24, time: 160),
    DayItem(id: "day_17", dayNum: 17, customers: 25, time: 160),
    DayItem(id: "day_18", dayNum: 18, customers: 27, time: 170),
    DayItem(id: "day_19", dayNum: 19, customers: 28, time: 180),
    DayItem(id: "day_20", dayNum: 20, customers: 29, time: 180),
    DayItem(id: "day_21", dayNum: 21, customers: 30, time: 100)
]
