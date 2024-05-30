import SwiftUI
import SpriteKit

struct MaintenanceGameSceneView: View {
    
    var day: DayItem
    @State var updatableDayItem: DayItem!
    
    @State var maintenanceScene: MaintenanceGameScene?
    
    @State var gamePaused = false
    @State var gameWon = false
    @State var gameLose = false
    
    var body: some View {
        ZStack {
            if let maintenanceScene = maintenanceScene {
                SpriteView(scene: maintenanceScene)
                    .ignoresSafeArea()
            }
            
            if gamePaused {
                MaintenanceGamePauseView(gamePaused: $gamePaused) {
                    maintenanceScene = maintenanceScene?.replayGame()
                    withAnimation {
                        gamePaused = false
                    }
                } continueAction: {
                    maintenanceScene?.continueWorkDay()
                }
                .transition(.slide)
            }
            
            if gameLose {
                MaintenanceGameLoseView() {
                    maintenanceScene = maintenanceScene?.replayGame()
                    withAnimation {
                        gameLose = false
                    }
                }
                .transition(.slide)
            }
            
            if gameWon {
                MaintenanceGameWinView(withAdBonusView: Bool.random(), winGolda: 250 * Int.random(in: 1...5), replayBtnAction: {
                    maintenanceScene = maintenanceScene?.replayGame()
                    withAnimation {
                        gameWon = false
                    }
                }, nextDayAction: {
                    let newDay = days[days.firstIndex(where: { $0.id == updatableDayItem.id })! + 1]
                    updatableDayItem = newDay
                    maintenanceScene = maintenanceScene?.replayGame(newDay: newDay)
                    withAnimation {
                        gameWon = false
                    }
                })
                .onAppear {
                    UserDefaults.standard.set(true, forKey: "\(day.id)_passed")
                    if day.dayNum < 21 {
                        let nextDay = days[days.firstIndex(where: { $0.id == day.id })! + 1]
                        UserDefaults.standard.set(true, forKey: "\(nextDay.id)_opened")
                    }
                }
                .transition(.slide)
            }
        }
        .onAppear {
            maintenanceScene = MaintenanceGameScene(size: CGSize(width: 750, height: 1335), day: day)
            updatableDayItem = day
        }
        .onReceive(NotificationCenter.default.publisher(for: .winGame)) { _ in 
            withAnimation {
                gameWon = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .loseGame)) { _ in
            withAnimation {
                gameLose = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .pauseGame)) { _ in
            withAnimation {
                gamePaused = true
            }
        }
    }
}

#Preview {
    MaintenanceGameSceneView(day: DayItem(id: "day_1", dayNum: 1, customers: 5, time: 40))
}
