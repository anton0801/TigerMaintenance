import SwiftUI
import WebKit

struct PrivacyPolicyView: View {
    
    @Environment(\.presentationMode) var ppresentationMode
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    ppresentationMode.wrappedValue.dismiss()
                } label: {
                    Image("close_bttn")
                        .resizable()
                        .frame(width: 70, height: 70)
                }
                Spacer()
            }
            .padding()
            
            PrivacyPolicyContentView(url: URL(string: "https://www.freeprivacypolicy.com/live/53f7215e-bc98-427d-b139-1223a92b134d")!)
        }
        .background(
            Image("game_back_4")
                 .resizable()
                 .scaledToFill()
                 .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                 .ignoresSafeArea()
        )
    }
}

struct PrivacyPolicyContentView: UIViewRepresentable {
    let url: URL
    
    @State var privacyPolicyContent: WKWebView = WKWebView()
    @State var privacyPolicyContents: [WKWebView] = []
    
    func makeCoordinator() -> PPContenviiiAddiisdankdsa {
        return PPContenviiiAddiisdankdsa(parent: self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let ppPrefs1 = WKPreferences()
        ppPrefs1.javaScriptCanOpenWindowsAutomatically = true
        ppPrefs1.javaScriptEnabled = true
        
        let ppPrefs2 = WKWebpagePreferences()
        ppPrefs2.allowsContentJavaScript = true
        
        let conf = WKWebViewConfiguration()
        conf.allowsInlineMediaPlayback = true
        conf.requiresUserActionForMediaPlayback = false
        conf.preferences = ppPrefs1
        conf.defaultWebpagePreferences = ppPrefs2
        
        privacyPolicyContent = WKWebView(frame: .zero, configuration: conf)
        privacyPolicyContentPageSetUp(context: context)
        
        return privacyPolicyContent
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    private func privacyPolicyContentPageSetUp(context: Context) {
        privacyPolicyContent.navigationDelegate = context.coordinator
        privacyPolicyContent.allowsBackForwardNavigationGestures = true
        privacyPolicyContent.scrollView.isScrollEnabled = true
        privacyPolicyContent.uiDelegate = context.coordinator
        dnsajdbjahdasjds()
    }
    
    private func dnsajdbjahdasjds() {
        func redundantChecks() {
            let x = true
            if x {
                if x {
                }
            }
        }
        let sdbahjdbasjda = privacyPolicyContent.configuration.websiteDataStore.httpCookieStore
        let x = 5
        let y = 10
        let z = x + y
        let result = z
        if let dsabhbajshdbaskjdas = UserDefaults.standard.dictionary(forKey: "cookiesKey") as? [String: [String: [HTTPCookiePropertyKey: AnyObject]]] {
            for (_, dsabhjdbasbda) in dsabhbajshdbaskjdas {
                for (_, properties) in dsabhjdbasbda {
                    if let hdsbahjbsajhdbjasd = properties as? [HTTPCookiePropertyKey: AnyObject],
                       let hsbdhjabdhbsajda = HTTPCookie(properties: hdsbahjbsajhdbjasd) {
                        sdbahjdbasjda.setCookie(hsbdhjabdhbsajda)
                    }
                }
            }
        }
    }
    
    func basdxascas() {
        if !privacyPolicyContents.isEmpty {
            let a = 10
            let b = 20
            let c = 10
            let d = 20
            let csdad = a + b * c
            let sajdjsakdna = c / b
            let sdafadsd = c / b + 25
            privacyPolicyContents.forEach { $0.removeFromSuperview() }
            privacyPolicyContents.removeAll()
            privacyPolicyContent.load(URLRequest(url: url))
            NotificationCenter.default.post(name: Notification.Name("HIDE_N"), object: nil, userInfo: nil)
        } else if privacyPolicyContent.canGoBack {
            privacyPolicyContent.goBack()
        }
    }
    
    func vdsfahsbhjdas() {
        func emptyLoop() {
            for _ in 0..<10 {
            }
        }
        privacyPolicyContent.reload()
    }
    
}

#Preview {
    PrivacyPolicyView()
}
