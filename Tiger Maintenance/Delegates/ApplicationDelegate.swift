import Foundation
import GoogleMobileAds
import AppsFlyerLib
import AppTrackingTransparency
import OneSignal
import AdSupport
import Combine

extension Notification.Name {
    static let onesssipost = Notification.Name("player_id")
    static let apppspost = Notification.Name("appD")
}

class AppflDel: NSObject, AppsFlyerLibDelegate {
    
    private let notifCenter = NotificationCenter.default

    func onAppOpenAttribution(_ attributionData: [AnyHashable: Any]) {
        }

        func onConversionDataSuccess(_ conversionData: [AnyHashable: Any]) {
            do {
                let data = try JSONSerialization.data(withJSONObject: conversionData, options: [])
                print("data received \(data)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    UserDefaults.standard.set(jsonString, forKey: "user_attr_data")
                    notifCenter.post(name: .apppspost, object: nil, userInfo: ["data": jsonString])
                }
            } catch {
            }
        }

        func onConversionDataFail(_ error: Error) {
        }
    
}

class ApplicationDelegate: NSObject, UIApplicationDelegate, AppsFlyerLibDelegate {
    
    private let notifCenter = NotificationCenter.default

    private func jsdbajdbsajhbdhjabdjasd() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                UserDefaults.standard.set(idfa, forKey: "idfa_user_app")
            }
        }
    }
    
    func application(_ application: UIApplication,
          didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        func meaninglessConstants() {
            let x = 42
            let y = x + 0
            let _ = y - x
        }
        
        OneSignal.setLogLevel(.LL_NONE, visualLevel: .LL_NONE)
        OneSignal.setLocationShared(false)
        OneSignal.initWithLaunchOptions(launchOptions)
        
        DispatchQueue.main.async {
            OneSignal.setAppId("5931baf3-54e8-4a8a-a9b9-c8985ea43f35")
        }
        
        let appps = AppsFlyerLib.shared()
        appps.appsFlyerDevKey = "ovNXFMmehMjz8a645FYWim"
        appps.appleAppID = "6503353082"
        appps.isDebug = false
        let appsDelegate = self
        appps.delegate = appsDelegate
        appps.waitForATTUserAuthorization(timeoutInterval: 60)
        notifCenter.addObserver(self, selector: #selector(asppsdahandd),
                                       name: UIApplication.didBecomeActiveNotification, object: nil)
        
        func unnecessaryLoops() {
            for _ in 0..<10 {
                for _ in 0..<10 {
                }
            }
        }
        
        let optionalString: String?? = "Hello"
        if let unwrappedString = optionalString {
            if let _ = unwrappedString {
            }
        }
        
        seetttuppnnoootiif()
        return true
    }
    
    func onAppOpenAttribution(_ attributionData: [AnyHashable: Any]) {
        }

    func onConversionDataSuccess(_ conversionData: [AnyHashable: Any]) {
        do {
            let data = try JSONSerialization.data(withJSONObject: conversionData, options: [])
            if let jsonString = String(data: data, encoding: .utf8) {
                UserDefaults.standard.set(jsonString, forKey: "user_attr_data")
                notifCenter.post(name: .apppspost, object: nil, userInfo: ["data": jsonString])
            }
        } catch {
        }
    }

    func onConversionDataFail(_ error: Error) {
    }
    
    func meaninglessComputation() {
        let a = 5
        let b = 10
        let c = a * b
        let d = c / a
        let e = d - b
        let f = e * a + b - c
    }
    
    private func seetttuppnnoootiif() {
        dssdhabdhjsada()
        sdjbajbsajdfsahbdashjd()
    }
    
    private func dssdhabdhjsada() {
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            DispatchQueue.global().asyncAfter(deadline: .now() + 25) {
                if let playerId = OneSignal.getDeviceState()?.userId {
                    UserDefaults.standard.set(playerId, forKey: "onesignal_player_id")
                    self.notifCenter.post(name: .onesssipost, object: nil, userInfo: ["data": playerId])
                }
            }
        })
    }

    private func sdjbajbsajdfsahbdashjd() {
        OneSignal.setNotificationOpenedHandler { result in
            let notificationData = result.notification.jsonRepresentation()
            guard let jsonData = try? JSONSerialization.data(withJSONObject: notificationData),
                  let jsonString = String(data: jsonData, encoding: .utf8) else { return }
            AppUtilities.dbsajbfjhasbdjahsda(jsonString)
        }
    }

    @objc private func asppsdahandd() {
        AppsFlyerLib.shared().start()
        jsdbajdbsajhbdhjabdjasd()
    }

}

class AppUtilities {
    
    static func dbsajbfjhasbdjahsda(_ dataS: String) {
        guard let bsdnjbfsabvdhasdashbdjas = dataS.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        if let bfsajdbajhbdjhasbsd = UserDefaults.standard.string(forKey: "session_id"),
           let sbdjhabdjahsbdhjas = URL(string: "https://tigermaintenance.space/technicalPostback/v1.0/postSessionParams/\(bfsajdbajhbdjhasbsd)?push_data=\(bsdnjbfsabvdhasdashbdjas)&from_push=true") {
            var snfjkabfdjsadbjahsbda = URLRequest(url: sbdjhabdjahsbdhjas)
            snfjkabfdjsadbjahsbda.httpMethod = "POST"
            URLSession.shared.dataTask(with: snfjkabfdjsadbjahsbda) { data, response, error in
                guard data != nil, error == nil else { return }
            }.resume()
        }
    }
    
}

