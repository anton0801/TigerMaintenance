import SwiftUI

struct MaitenanceMenuView: View {
    
    @State var musicInApp = UserDefaults.standard.bool(forKey: "musicInApp") {
        didSet {
            UserDefaults.standard.set(musicInApp, forKey: "musicInApp")
        }
    }
    
    @State var tigerData = TigerData()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 100)
                Image("title")
                    .resizable()
                    .frame(width: 300, height: 100)
                Spacer()
                
                HStack {
                    Button {
                        withAnimation {
                            musicInApp = !musicInApp
                        }
                    } label: {
                        if musicInApp {
                            Image("sound_on_bttn")
                                .resizable()
                                .frame(width: 85, height: 85)
                        } else {
                            Image("sound_off_bttn")
                                .resizable()
                                .frame(width: 85, height: 85)
                        }
                    }
                    
                    NavigationLink(destination: MaitenanceInfoGameView()
                        .navigationBarBackButtonHidden(true)) {
                        Image("info_bttn")
                            .resizable()
                            .frame(width: 85, height: 85)
                    }
                    
                    NavigationLink(destination: PrivacyPolicyView()
                        .navigationBarBackButtonHidden(true)) {
                        Image("pp_bttn")
                            .resizable()
                            .frame(width: 85, height: 85)
                    }
                    
                    NavigationLink(destination: MaintenanceShopView()
                        .environmentObject(tigerData)
                        .navigationBarBackButtonHidden(true)) {
                        Image("shop_bttn")
                            .resizable()
                            .frame(width: 85, height: 85)
                    }
                }
                
                NavigationLink(destination: DaysGameView()
                    .navigationBarBackButtonHidden()
                    .environmentObject(tigerData)) {
                        Image("play_bttn")
                            .resizable()
                            .frame(width: 150, height: 150)
                    }
            }
            .background(
                Image("menu_bg")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    MaitenanceMenuView()
}
