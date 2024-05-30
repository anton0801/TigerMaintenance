import SwiftUI

struct DaysGameView: View {
    
    @Environment(\.presentationMode) var ppresentationMode
    @EnvironmentObject var tigerData: TigerData
    @State var daysData = DaysGameData()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        ppresentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("close_bttn")
                            .resizable()
                            .frame(width: 70, height: 70)
                    }
                    Spacer().frame(width: 24)
                    Image("days_title")
                        .resizable()
                        .frame(width: 160, height: 60)
                    Spacer()
                    NavigationLink(destination: MaintenanceShopView()
                        .environmentObject(tigerData)
                        .navigationBarBackButtonHidden(true)) {
                        Image("shop_bttn")
                            .resizable()
                            .frame(width: 70, height: 70)
                    }
                }
                .padding()
                ZStack {
                    Image("days_bg")
                        .resizable()
                        .frame(width: 300, height: .infinity)
                    LazyVGrid(columns: [
                        GridItem(.fixed(80)),
                        GridItem(.fixed(80)),
                        GridItem(.fixed(80))
                    ]) {
                        ForEach(days, id: \.id) { dayItem in
                            if daysData.passedDays.contains(where: { $0.id == dayItem.id }) {
                                NavigationLink(destination: MaintenanceGameSceneView(day: dayItem)
                                    .navigationBarBackButtonHidden(true)
                                    .environmentObject(tigerData)) {
                                    ZStack {
                                        Image("level_bttn_full")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                        Text("\(dayItem.dayNum)")
                                            .font(.custom("Jost", size: 20))
                                            .foregroundColor(Color.init(red: 134/255, green: 36/255, blue: 4/255))
                                            .shadow(color: Color.init(red: 254/255, green: 233/255, blue: 38/255), radius: 5)
                                    }
                                }
                            } else if daysData.openedDays.contains(where: { $0.id == dayItem.id }) {
                                NavigationLink(destination: MaintenanceGameSceneView(day: dayItem)
                                    .navigationBarBackButtonHidden(true)
                                    .environmentObject(tigerData)) {
                                    ZStack {
                                        Image("level_bttn_open")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                        Text("\(dayItem.dayNum)")
                                            .font(.custom("Jost", size: 20))
                                            .foregroundColor(Color.init(red: 134/255, green: 36/255, blue: 4/255))
                                            .shadow(color: Color.init(red: 254/255, green: 233/255, blue: 38/255), radius: 5)
                                    }
                                }
                            } else {
                                Image("level_bttn_close")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                            }
                        }
                    }
                }
            }
            .background(
                Image("info_bg")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
            .onAppear {
                daysData.checkAllOpenedDays()
                daysData.checkAllPassedDays()
            }
        }
    }
}

#Preview {
    DaysGameView()
        .environmentObject(TigerData())
}

class DaysGameData: ObservableObject {
    
    @Published var passedDays: [DayItem] = []
    @Published var openedDays: [DayItem] = []
    
    init() {
        if openedDays.isEmpty {
            openedDays.append(days[0])
            UserDefaults.standard.set(true, forKey: "day_1_opened")
        }
        checkAllPassedDays()
        checkAllOpenedDays()
    }
    
    func checkAllPassedDays() {
        passedDays = []
        for day in days {
            if UserDefaults.standard.bool(forKey: "\(day.id)_passed") {
                passedDays.append(day)
            }
        }
    }
    
    func checkAllOpenedDays() {
        openedDays = []
        for day in days {
            if UserDefaults.standard.bool(forKey: "\(day.id)_opened") {
                openedDays.append(day)
            }
        }
    }
    
}
