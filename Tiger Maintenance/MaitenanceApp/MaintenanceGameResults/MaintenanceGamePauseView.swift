import SwiftUI

struct MaintenanceGamePauseView: View {
    
    @State var musicInApp = UserDefaults.standard.bool(forKey: "musicInApp") {
        didSet {
            UserDefaults.standard.set(musicInApp, forKey: "musicInApp")
        }
    }
    @Environment(\.presentationMode) var mode
    @Binding var gamePaused: Bool
    
    var replayBtnAction: () -> Void
    var continueAction: () -> Void
    
    var body: some View {
        VStack {
            Image("pause_title")
                .resizable()
                .frame(width: 250, height: 70)
            Spacer()
            
            Button {
                continueAction()
                withAnimation {
                    gamePaused = false
                }
            } label: {
                Image("play_bttn")
                    .resizable()
                    .frame(width: 170, height: 170)
            }
            
            HStack {
                Button {
                    withAnimation {
                        musicInApp = !musicInApp
                    }
                } label: {
                    if musicInApp {
                        Image("sound_on_bttn")
                            .resizable()
                            .frame(width: 100, height: 100)
                    } else {
                        Image("sound_off_bttn")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                }
                
                Button {
                    withAnimation {
                        mode.wrappedValue.dismiss()
                    }
                } label: {
                    Image("menu_bttn")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                Button {
                    replayBtnAction()
                } label: {
                    Image("replay_bttn")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
            }
            
            Spacer()
        }
        .background(
            Image("game_back_3")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    MaintenanceGamePauseView(gamePaused: .constant(true), replayBtnAction: { }, continueAction: { })
}
