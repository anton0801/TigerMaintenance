import Foundation


class TigerData: ObservableObject {
    @Published var golda: Int = UserDefaults.standard.integer(forKey: "golda") {
        didSet {
            UserDefaults.standard.set(golda, forKey: "golda")
        }
    }
    
    @Published var foodInUse = UserDefaults.standard.string(forKey: "food_in_use")?.components(separatedBy: ",") ?? [] {
        didSet {
            UserDefaults.standard.set(foodInUse.joined(separator: ","), forKey: "food_in_use")
        }
    }
}
