import SwiftUI

struct MaintenanceGameLoseView: View {
    
    var replayBtnAction: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                replayBtnAction()
            } label: {
                Image("replay_bttn")
                    .resizable()
                    .frame(width: 170, height: 170)
            }
            Spacer().frame(height: 150)
        }
        .background(
            Image("loss_bg")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    MaintenanceGameLoseView(replayBtnAction: { })
}
