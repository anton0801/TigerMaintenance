import SwiftUI
import GoogleMobileAds

struct MaintenanceGameWinView: View {
    
    @Environment(\.presentationMode) var mode
    var withAdBonusView: Bool
    var winGolda: Int
    
    @State var menuBg: String = "win_bg"
    
    var replayBtnAction: () -> Void
    var nextDayAction: () -> Void
    
    @StateObject private var coordinator = RewardedAdCoordinator()
    
    var body: some View {
        VStack {
            Spacer().frame(height: 180)
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
                    Text("+\(winGolda)")
                        .font(.custom("Jost", size: 24))
                        .foregroundColor(Color.init(red: 134/255, green: 36/255, blue: 4/255))
                        .shadow(color: Color.init(red: 254/255, green: 233/255, blue: 38/255), radius: 5)
                    Spacer()
                    Spacer()
                }
                .frame(width: 200, height: 40)
            }
            if withAdBonusView {
                Spacer()
                
                Button {
                    if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
                        coordinator.showAd(from: rootViewController) {
                            let doubleWin = winGolda * 2
                        }
                    }
                } label: {
                    Image("ads_bttn")
                        .resizable()
                        .frame(width: 150, height: 150)
                }
                
                HStack {
                    Spacer()
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("menu_bttn")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    Spacer()
                    Button {
                        nextDayAction()
                    } label: {
                        Image("next_bttn")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    Spacer()
                    Button {
                        replayBtnAction()
                    } label: {
                        Image("replay_bttn")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    Spacer()
                }
                
                Spacer().frame(height: 40)
            } else {
                Spacer()
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("menu_bttn")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    
                    Button {
                        nextDayAction()
                    } label: {
                        Image("next_bttn")
                            .resizable()
                            .frame(width: 170, height: 170)
                    }
                    
                    Button {
                        replayBtnAction()
                    } label: {
                        Image("replay_bttn")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                }
                Spacer().frame(height: 80)
            }
        }
        .onAppear {
            if withAdBonusView {
                coordinator.loadAd()
                menuBg = "win_2_bg"
            }
        }
        .background(
            Image(menuBg)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    MaintenanceGameWinView(withAdBonusView: true, winGolda: 150, replayBtnAction: { }, nextDayAction: { })
}


class RewardedAdCoordinator: NSObject, GADFullScreenContentDelegate, ObservableObject {
    
    @Published var rewardedAd: GADRewardedAd?
    
    var rewardedAdId = "ca-app-pub-9929197471816951/8580745635"

    func loadAd() {
        GADRewardedAd.load(withAdUnitID: rewardedAdId, request: GADRequest()) { ad, error in
            if let error = error {
                print("error load ad \(error)")
                return
            }
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self
        }
    }

    func showAd(from rootViewController: UIViewController, _ adShowedAndGetReward: @escaping () -> Void) {
        if let ad = rewardedAd {
            ad.present(fromRootViewController: rootViewController) {
                adShowedAndGetReward()
            }
        } else {
        }
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        loadAd()
    }

    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        loadAd()
    }
    
}
