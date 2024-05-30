import SwiftUI

@main
struct Tiger_MaintenanceApp: App {
    
    @UIApplicationDelegateAdaptor(ApplicationDelegate.self) var applicationDelegate
    
    var body: some Scene {
        WindowGroup {
            LoadingTigerMaintenanceView()
        }
    }
}
