import SwiftUI

struct MaintenanceShopView: View {
    
    @Environment(\.presentationMode) var ppresentationMode
    @EnvironmentObject var tigerData: TigerData
    @State var maintenanceShopData = MaintenanceShopData()
    @State var errorInBuy = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    ppresentationMode.wrappedValue.dismiss()
                } label: {
                    Image("menu_bttn")
                        .resizable()
                        .frame(width: 70, height: 70)
                }
                Spacer().frame(width: 24)
                Image("shop_title")
                    .resizable()
                    .frame(width: 160, height: 60)
                Spacer()
            }
            .padding()
            
            ZStack {
                Image("score_bg")
                    .resizable()
                    .frame(width: 200, height: 40)
                HStack {
                    Spacer().frame(width: 24)
                    Image("golda")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Spacer()
                    Text("\(tigerData.golda)")
                        .font(.custom("Jost", size: 24))
                        .foregroundColor(Color.init(red: 134/255, green: 36/255, blue: 4/255))
                        .shadow(color: Color.init(red: 254/255, green: 233/255, blue: 38/255), radius: 5)
                    Spacer()
                    Spacer()
                }
                .frame(width: 200, height: 40)
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    Image("food_title")
                        .resizable()
                        .frame(width: 150, height: 50)
                        .padding(.leading)
                    HStack {
                        ForEach(foodShopItems, id: \.id) { foodItem in
                            VStack(spacing: 0) {
                                Image(foodItem.item)
                                    .resizable()
                                    .frame(width: 90, height: 90)
                                
                                Text("\(foodItem.price)")
                                    .font(.custom("Jost", size: 20))
                                    .foregroundColor(Color.init(red: 134/255, green: 36/255, blue: 4/255))
                                    .shadow(color: Color.init(red: 254/255, green: 233/255, blue: 38/255), radius: 5)
                                
                                if !tigerData.foodInUse.contains(foodItem.id) && !maintenanceShopData.itemsInStock.contains(where: { $0.id == foodItem.id }) {
                                    Button {
                                        maintenanceShopData.obtainItem(tigerData, foodItem)
                                        errorInBuy = maintenanceShopData.errorInObtain
                                    } label: {
                                        Image("buy_bttn")
                                            .resizable()
                                            .frame(width: 90, height: 35)
                                    }
                                } else if !tigerData.foodInUse.contains(foodItem.id) && maintenanceShopData.itemsInStock.contains(where: { $0.id == foodItem.id }) {
                                    Button {
                                        var nowFoodUsed = tigerData.foodInUse
                                        nowFoodUsed.append(foodItem.id)
                                        tigerData.foodInUse = nowFoodUsed
                                    } label: {
                                        Image("use_bttn")
                                            .resizable()
                                            .frame(width: 90, height: 35)
                                    }
                                } else if tigerData.foodInUse.contains(foodItem.id) && maintenanceShopData.itemsInStock.contains(where: { $0.id == foodItem.id }) {
                                    Image("used_bttn")
                                        .resizable()
                                        .frame(width: 90, height: 35)
                                }
                            }
                            .background(
                                Image("shop_item_bg")
                                    .resizable()
                                    .frame(width: 130, height: 220)
                            )
                            .padding(16)
                        }
                    }
                    .padding(.top)
                }
                
                Spacer().frame(height: 24)
                
                VStack(alignment: .leading) {
                    Image("guests_title")
                        .resizable()
                        .frame(width: 150, height: 50)
                        .padding(.leading)
                    HStack {
                        ForEach(Array(guestsShopItems[0..<3]), id: \.id) { guestItem in
                            VStack(spacing: 0) {
                                Image(guestItem.item)
                                    .resizable()
                                    .frame(width: 90, height: 90)
                                
                                Text("\(guestItem.price)")
                                    .font(.custom("Jost", size: 20))
                                    .foregroundColor(Color.init(red: 134/255, green: 36/255, blue: 4/255))
                                    .shadow(color: Color.init(red: 254/255, green: 233/255, blue: 38/255), radius: 5)
                                
                                if !maintenanceShopData.itemsInStock.contains(where: { $0.id == guestItem.id }) {
                                    Button {
                                        maintenanceShopData.obtainItem(tigerData, guestItem)
                                        errorInBuy = maintenanceShopData.errorInObtain
                                    } label: {
                                        Image("buyclose_bttn")
                                            .resizable()
                                            .frame(width: 90, height: 35)
                                    }
                                } else {
                                    Image("used_bttn")
                                        .resizable()
                                        .frame(width: 90, height: 35)
                                }
                                
                            }
                            .background(
                                Image("shop_item_bg")
                                    .resizable()
                                    .frame(width: 130, height: 220)
                            )
                            .padding(16)
                        }
                    }
                    .padding(.top)
                    
                    Spacer().frame(height: 42)
                    
                    HStack {
                        ForEach(Array(guestsShopItems[3..<6]), id: \.id) { guestItem in
                            VStack(spacing: 0) {
                                Image(guestItem.item)
                                    .resizable()
                                    .frame(width: 90, height: 90)
                                
                                Text("\(guestItem.price)")
                                    .font(.custom("Jost", size: 20))
                                    .foregroundColor(Color.init(red: 134/255, green: 36/255, blue: 4/255))
                                   .shadow(color: Color.init(red: 254/255, green: 233/255, blue: 38/255), radius: 5)
                                
                                if !maintenanceShopData.itemsInStock.contains(where: { $0.id == guestItem.id }) {
                                    Button {
                                        maintenanceShopData.obtainItem(tigerData, guestItem)
                                        errorInBuy = maintenanceShopData.errorInObtain
                                    } label: {
                                        Image("buyclose_bttn")
                                            .resizable()
                                            .frame(width: 90, height: 35)
                                    }
                                } else {
                                    Image("used_bttn")
                                        .resizable()
                                        .frame(width: 90, height: 35)
                                }
                            }
                            .background(
                                Image("shop_item_bg")
                                    .resizable()
                                    .frame(width: 130, height: 220)
                            )
                            .padding(16)
                        }
                    }
                    
                    Spacer().frame(height: 42)
                }
            }
            
            Spacer()
        }
        .preferredColorScheme(.dark)
        .background(
            Image("game_back_4")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
                .opacity(0.8)
        )
        .alert(isPresented: $errorInBuy) {
            Alert(
                title: Text("Not enought gold!"),
                message: Text("You need more gold to purchase this item! You need to serve more of your customers!"),
                dismissButton: .cancel(Text("OK!"))
            )
        }
    }
}

#Preview {
    MaintenanceShopView()
        .environmentObject(TigerData())
}

class MaintenanceShopData: ObservableObject {
    
    @Published var itemsInStock = [MaintenanceShopItem]()
    @Published var errorInObtain = false
    
    init() {
        checkItemsInStock()
    }
    
    func checkItemsInStock() {
        let foodAndGuests = foodShopItems + guestsShopItems
        let defaults = UserDefaults.standard
        for item in foodAndGuests {
            if defaults.bool(forKey: "\(item.id)_stock") {
                itemsInStock.append(item)
            }
        }
    }
    
    func obtainItem(_ tigerData: TigerData, _ item: MaintenanceShopItem) {
        if tigerData.golda >= item.price {
            UserDefaults.standard.set(true, forKey: "\(item.id)_stock")
            checkItemsInStock()
            tigerData.golda -= item.price
            errorInObtain = false
        } else {
            errorInObtain = true
        }
    }
    
}
