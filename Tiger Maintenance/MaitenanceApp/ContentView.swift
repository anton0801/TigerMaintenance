import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            if UserDefaults.standard.string(forKey: "l_save") != nil {
                MaitenanceMenuViewS()
            } else {
                MaitenanceMenuView()
            }
        }
    }
}

#Preview {
    ContentView()
}
