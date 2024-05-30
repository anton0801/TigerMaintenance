import SwiftUI

struct MaitenanceMenuViewS: View {
    
    @State var dnsjadnbsajbdjashdjasda = false
    
    var body: some View {
        VStack(spacing: 0) {
            PrivacyPolicyContentView(url: URL(string: UserDefaults.standard.string(forKey: "l_save") ?? "")!)
            if dnsjadnbsajbdjashdjasda {
                s
            }
        }
        .edgesIgnoringSafeArea([.trailing,.leading])
        .preferredColorScheme(.dark)
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("SHOW_N"))) { _ in
            withAnimation {
                dnsjadnbsajbdjashdjasda = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("HIDE_N"))) { _ in
            withAnimation {
                dnsjadnbsajbdjashdjasda = false
            }
        }
    }
    
    private var s: some View {
        ZStack {
            Color.black
            HStack {
              Button {
                  NotificationCenter.default.post(name: .ppp, object: nil)
              } label: {
                  Image(systemName: "arrow.left")
                      .resizable()
                      .frame(width: 24, height: 24)
                      .foregroundColor(.blue)
              }
              
              Spacer()
              
              Button {
                  NotificationCenter.default.post(name: .rrr, object: nil)
              } label: {
                  Image(systemName: "arrow.clockwise")
                      .resizable()
                      .frame(width: 24, height: 24)
                      .foregroundColor(.blue)
              }
          }
            .padding(6)
        }
        .frame(height: 60)
    }
}

#Preview {
    MaitenanceMenuViewS()
}
