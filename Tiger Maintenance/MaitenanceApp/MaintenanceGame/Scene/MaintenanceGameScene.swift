import Foundation
import WebKit
import SwiftUI
import SpriteKit

extension Notification.Name {
    static let loseGame = Notification.Name("lose_game")
    static let winGame = Notification.Name("win_game")
    static let ppp = Notification.Name("goBackNotification")
    static let rrr = Notification.Name("reloadNotification")
    static let pauseGame = Notification.Name("pause_game")
    static let restartGame = Notification.Name("pause_game")
}

class MaintenanceGameScene: SKScene {
    
    var day: DayItem!
    
    init(size: CGSize, day: DayItem) {
        super.init(size: size)
        self.day = day
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var pauseBtn: SKSpriteNode!
    
    private var timeLabel: SKLabelNode!
    private var time: Int = 40 {
        didSet {
            timeLabel.text = "\(formatSecondsToMinutesSeconds(seconds: time))"
            if time == 0 {
                isPaused = true
                NotificationCenter.default.post(name: .loseGame, object: nil, userInfo: nil)
            }
        }
    }
    private var timer: Timer!
    
    func formatSecondsToMinutesSeconds(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    private var guestsAvailable: [String] = ["guest_1"]
    private var availableFood: [String] = ["food_1", "food_2", "food_3", "food_4", "food_5", "food_6", "food_7", "food_8", "food_9", "food_10", "food_11", "food_12"]
    
    private var onlineGuests: [Int: Guest] = [:]
    
    private var errors: Int = 0 {
        didSet {
            setCorrectAndIncorrectsSubmissions()
        }
    }
    private var customersCompleted = 0
    
    override func didMove(to view: SKView) {
        size = CGSize(width: 750, height: 1335)
        setUpGuestsList()
        setUpFoodListMenu()
        gameBack()
        setCorrectAndIncorrectsSubmissions()
        gameUi()
        spawnGuests()
        spawnMenuItems()
        
        time = day.time
        
        timer = .scheduledTimer(timeInterval: 1, target: self, selector: #selector(workDayCounterTime), userInfo: nil, repeats: true)
    }
    
    @objc private func workDayCounterTime() {
        if !isPaused {
            time -= 1
        }
    }
    
    func replayGame() -> MaintenanceGameScene {
        let newMaintenanceGameScene = MaintenanceGameScene(size: size, day: day)
        view?.presentScene(newMaintenanceGameScene)
        return newMaintenanceGameScene
    }
    
    func replayGame(newDay: DayItem) -> MaintenanceGameScene {
        let newMaintenanceGameScene = MaintenanceGameScene(size: size, day: newDay)
        view?.presentScene(newMaintenanceGameScene)
        return newMaintenanceGameScene
    }
    
    private func gameBack() {
        let backImage = SKSpriteNode(imageNamed: "game_back_3")
        backImage.position = CGPoint(x: size.width / 2, y: size.height / 2)
        backImage.size = size
        addChild(backImage)
    }
    
    private func gameUi() {
        pauseBtn = SKSpriteNode(imageNamed: "pause_bttn")
        pauseBtn.position = CGPoint(x: 80, y: size.height - 80)
        pauseBtn.size = CGSize(width: 100, height: 85)
        addChild(pauseBtn)
        
        timeLabel = SKLabelNode(text: "00:40")
        timeLabel.position = CGPoint(x: size.width / 2, y: size.height - 120)
        timeLabel.fontName = "Jost"
        timeLabel.fontSize = 42
        timeLabel.color = UIColor.init(red: 238/255, green: 179/255, blue: 25/255, alpha: 1)
        addChild(timeLabel)
        
        let table = SKSpriteNode(imageNamed: "table")
        table.position = CGPoint(x: size.width / 2, y: size.height / 2 - 160)
        table.size = CGSize(width: size.width, height: 150)
        table.zPosition = 5
        addChild(table)
        
        let table2 = SKSpriteNode(imageNamed: "table_2")
        table2.position = CGPoint(x: size.width / 2, y: size.height / 2 - 450)
        table2.size = CGSize(width: size.width, height: 450)
        table2.zPosition = 5
        addChild(table2)
    }
    
    private func setUpGuestsList() {
        let shopGuest = ["guests_1", "guests_2", "guests_3", "guests_4", "guests_5", "guests_6"]
        for guest in shopGuest {
            if UserDefaults.standard.bool(forKey: "\(guest)_stock") {
                guestsAvailable.append(contentsOf: guestsShopItems.filter { $0.id == guest }[0].items)
            }
        }
    }
    
    private func setUpFoodListMenu() {
        let foodsBuyList = ["food_1", "food_2", "food_3"]
        for boughtMenu in foodsBuyList {
            if UserDefaults.standard.bool(forKey: "\(boughtMenu)_stock") {
                availableFood.append(contentsOf: foodShopItems.filter { $0.id == boughtMenu }[0].items)
            }
        }
    }
    
    private func spawnMenuItems() {
        var yIndex = 1
        var xIndex = 1
        for (index, food) in availableFood.enumerated() {
            let foodNode = SKSpriteNode(imageNamed: food)
            var x = CGFloat(80 + (xIndex * 100))
            var y = CGFloat(140 + (yIndex * 100))
            if x >= size.width {
                xIndex = 1
                yIndex += 1
                x = CGFloat(80 + (xIndex * 80))
                y = CGFloat(140 + (yIndex * 100))
            }
            foodNode.position = CGPoint(x: x, y: y)
            foodNode.size = CGSize(width: 100, height: 95)
            foodNode.zPosition = 10
            foodNode.name = food
            addChild(foodNode)
            xIndex += 1
        }
    }
    
    private func spawnGuests() {
        for guest in 0..<3 {
            spawnGuest(index: guest)
        }
    }
    
    private func spawnGuest(index: Int) {
        let guestSource = guestsAvailable.randomElement() ?? "guest_1"
        let food = availableFood.randomElement() ?? "food_1"
        let guest = GuestNode(texture: nil, color: .clear, size: CGSize(width: 200, height: 250), food: food, guestSource: guestSource, index: index)
        guest.position = CGPoint(x: 50 + CGFloat(230 * index), y: size.height / 2 - 20)
        guest.name = "guest_\(index)"
        let guestItem = Guest(source: guestSource, food: food, node: guest)
        onlineGuests[index] = guestItem
        addChild(guest)
    }
    
    private var correctAndIncorrectStatus: [SKSpriteNode] = []
    
    private func setCorrectAndIncorrectsSubmissions() {
        for c in correctAndIncorrectStatus {
            c.removeFromParent()
        }
        correctAndIncorrectStatus = []
        for i in 0..<3 {
            if i < errors {
                let node = SKSpriteNode(imageNamed: "incorrect")
                let a = size.width / 2 + 65
                let b = CGFloat(i * 70)
                let c = a - b
                node.position = CGPoint(x: c, y: size.height - 250)
                node.size = CGSize(width: 50, height: 45)
                addChild(node)
                correctAndIncorrectStatus.append(node)
            } else {
                let node = SKSpriteNode(imageNamed: "correct")
                let a = size.width / 2 + 65
                let b = CGFloat(i * 70)
                let c = a - b
                node.position = CGPoint(x: c, y: size.height - 250)
                node.size = CGSize(width: 50, height: 45)
                addChild(node)
                correctAndIncorrectStatus.append(node)
            }
        }
        
        if errors == 3 {
            isPaused = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                NotificationCenter.default.post(name: .loseGame, object: nil, userInfo: nil)
            }
        }
    }
    
    func guestLeave(index: Int) {
        do {
            let guest = onlineGuests[index]!
            guest.node.removeFromParent()
            onlineGuests.removeValue(forKey: index)
            errors += 1
            customersCompleted += 1
            if customersCompleted < day.customers {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.spawnGuest(index: index)
                }
            }
        } catch {
            
        }
    }
    
    private var movedFoodName: String? = nil
    private var prevPositionOfSelectedFood: CGPoint? = nil
    private var prevMovedFoodNode: SKNode? = nil
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let obj = nodes(at: location)
            for object in obj {
                let name = object.name
                if movedFoodName == name || movedFoodName == nil {
                    if name?.contains("food") == true {
                        if prevPositionOfSelectedFood == nil {
                            prevPositionOfSelectedFood = object.position
                        }
                        object.position = location
                        movedFoodName = name
                        prevMovedFoodNode = object
                    }
                }
                
            }
        }
    }
    
    func continueWorkDay() {
        isPaused = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch == nil {
            return
        }
        let objects = nodes(at: touch!.location(in: self))
        if objects.contains(pauseBtn) {
            isPaused = true
            NotificationCenter.default.post(name: .pauseGame, object: nil, userInfo: nil)
            return
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch == nil {
            return
        }
        let location = touch!.location(in: self)
        let guests = nodes(at: location)
        var foundTarget = false
        for guest in guests {
            if guest.name?.contains("guest") == true {
                foundTarget = true
                let guestIndex = guest.name!.components(separatedBy: "_")[1]
                checkGuestFood(guestIndex: Int(guestIndex) ?? -1)
                let moveAction = SKAction.move(to: prevPositionOfSelectedFood!, duration: 0.4)
                prevMovedFoodNode?.run(moveAction)
                prevPositionOfSelectedFood = nil
                prevMovedFoodNode = nil
                movedFoodName = nil
                return
            }
        }
        if !foundTarget {
            if let pos = prevPositionOfSelectedFood {
                let moveAction = SKAction.move(to: pos, duration: 0.4)
                prevMovedFoodNode?.run(moveAction)
                prevPositionOfSelectedFood = nil
                prevMovedFoodNode = nil
                movedFoodName = nil
            }
        }
    }
    
    private func checkGuestFood(guestIndex: Int) {
        let guest = onlineGuests[guestIndex]!
        if guest.food == movedFoodName {
            guest.node.removeFromParent()
            onlineGuests.removeValue(forKey: guestIndex)
            customersCompleted += 1
            if customersCompleted < day.customers {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.spawnGuest(index: guestIndex)
                }
            } else if customersCompleted == day.customers {
                isPaused = true
                if errors < 3 {
                    NotificationCenter.default.post(name: .winGame, object: nil, userInfo: nil)
                } else {
                    NotificationCenter.default.post(name: .loseGame, object: nil, userInfo: nil)
                }
            }
        } else {
            errors += 1
        }
    }
    
}

struct Guest {
    let source: String
    let food: String
    let node: GuestNode
}

class GuestNode: SKSpriteNode {
    
    private var guestFood: SKSpriteNode!
    private var guestNode: SKSpriteNode!
    
    private var patience: Int = 100 {
        didSet {
            let totalWidth = size.width
            let widthNow = totalWidth * CGFloat(Double(patience) / 100.0)
            patienceNode.size.width = widthNow
            patienceNode.position.x -= CGFloat(Double(patience) / 100.0)
        }
    }
    
    private var patienceNode: SKSpriteNode!
    
    private var food: String!
    private var guestSource: String!
    private var index: Int!
    
    private var patienceTimer: Timer!
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, food: String, guestSource: String, index: Int) {
        super.init(texture: texture, color: color, size: size)
        self.food = food
        self.guestSource = guestSource
        self.index = index
        
        let foodBg = SKSpriteNode(imageNamed: "food_guest_bg")
        foodBg.position = CGPoint(x: size.width / 2, y: size.height)
        foodBg.size = CGSize(width: 140, height: 130)
        addChild(foodBg)
        
        guestFood = SKSpriteNode(imageNamed: food)
        guestFood.position = CGPoint(x: size.width / 2, y: size.height)
        guestFood.size = CGSize(width: 90, height: 80)
        addChild(guestFood)
        
        guestNode = SKSpriteNode(imageNamed: guestSource)
        guestNode.position = CGPoint(x: size.width / 2, y: 0)
        guestNode.size = CGSize(width: size.width, height: 250)
        addChild(guestNode)
        
        let patienceBorder = SKSpriteNode(imageNamed: "patience_border")
        patienceBorder.position = CGPoint(x: size.width / 2, y: 150)
        patienceBorder.size = CGSize(width: size.width, height: 25)
        addChild(patienceBorder)
        
        patienceNode = SKSpriteNode(imageNamed: "patience_full")
        patienceNode.position = CGPoint(x: size.width / 2, y: 150)
        patienceNode.size = CGSize(width: size.width, height: 25)
        addChild(patienceNode)
        
        patienceTimer = .scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(patienceRest), userInfo: nil, repeats: true)
    }
    
    @objc private func patienceRest() {
        if !isPaused {
            patience -= 1
            if patience <= 0 {
               patienceTimer.invalidate()
               (parent as? MaintenanceGameScene)?.guestLeave(index: index)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class PPContenviiiAddiisdankdsa: NSObject, WKNavigationDelegate, WKUIDelegate {
    var parent: PrivacyPolicyContentView
    
    init(parent: PrivacyPolicyContentView) {
        self.parent = parent
    }
    
    @objc func hn(_ notification: Notification) {
        if notification.name == .ppp {
            parent.basdxascas()
        } else if notification.name == .rrr {
            parent.vdsfahsbhjdas()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        NotificationCenter.default.addObserver(self, selector: #selector(hn), name: .ppp, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hn), name: .rrr, object: nil)
        func redundantSwitch() {
            let value = 1
            switch value {
            case 1:
                break
            case 2:
                break
            default:
                break
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            let urlString = url.absoluteString
            if ["tg://", "viber://", "whatsapp://"].contains(where: urlString.hasPrefix) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        guard let currentURL = webView.url else { return }
        
        func redundantCondition() {
            let value = true
            if value == true {
            }
        }
        
        let sjbfdajbdjhsadbjsandjsafsada = webView.configuration.websiteDataStore.httpCookieStore
        sjbfdajbdjhsadbjsandjsafsada.getAllCookies { jsbdnfjabndjadjasd in
            var snfdjanfjadsnakjdnasjnfa = [String: [String: HTTPCookie]]()
            
            if let dnjsaknfkjasnkdnsakda = UserDefaults.standard.dictionary(forKey: "cookiesKey") as? [String: [String: [HTTPCookiePropertyKey: AnyObject]]] {
                for (djsabnfjbasjdad, dnjsanfjandkasd) in dnjsaknfkjasnkdnsakda {
                    var domainLevelDataCos = snfdjanfjadsnakjdnasjnfa[djsabnfjbasjdad] ?? [:]
                    for (_, properties) in dnjsanfjandkasd {
                        if let sbnfjabdjshabdbjaksda = properties as? [HTTPCookiePropertyKey: AnyObject],
                           let levelDataCo = HTTPCookie(properties: sbnfjabdjshabdbjaksda) {
                            domainLevelDataCos[levelDataCo.name] = levelDataCo
                        }
                    }
                    snfdjanfjadsnakjdnasjnfa[djsabnfjbasjdad] = domainLevelDataCos
                }
            }
            
            func emptyClosures() {
                let closure: () -> Void = {
                }
                closure()
            }
            
            for dsnajknfbhjasbdad in jsbdnfjabndjadjasd {
                var bhdsbajhfbahjdbsahjbdjhasd = snfdjanfjadsnakjdnasjnfa[dsnajknfbhjasbdad.domain] ?? [:]
                bhdsbajhfbahjdbsahjbdjhasd[dsnajknfbhjasbdad.name] = dsnajknfbhjasbdad
                snfdjanfjadsnakjdnasjnfa[dsnajknfbhjasbdad.domain] = bhdsbajhfbahjdbsahjbdjhasd
            }
            
            self.djsanbdjadjabd(snfdjanfjadsnakjdnasjnfa)
        }
    }
    
    private func djsanbdjadjabd(_ dnasjidnadnadsa: [String: [String: HTTPCookie]]) {
        var bdhjsabhjasbjfbjad = [String: [String: AnyObject]]()
        for (ddsdjdnajdjsa, ndaskdjbsajdbaksbdas) in dnasjidnadnadsa {
            var domainLevelDataCos = bdhjsabhjasbjfbjad[ddsdjdnajdjsa] ?? [:]
            for (name, levelDataCo) in ndaskdjbsajdbaksbdas {
                domainLevelDataCos[name] = levelDataCo.properties as AnyObject?
            }
            bdhjsabhjasbjfbjad[ddsdjdnajdjsa] = domainLevelDataCos
        }
        UserDefaults.standard.set(bdhjsabhjasbjfbjad, forKey: "cookiesKey")
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        
        let value: Int? = 10
        if let value = value {
        }
        
        func emptyStringOperations() {
            let str1 = ""
            let str2 = str1 + ""
            let str3 = str2 + ""
        }
        
        if navigationAction.targetFrame == nil {
            return ppppperpadshbdjasds(configuration: configuration)
        } else {
            NotificationCenter.default.post(name: Notification.Name("HIDE_N"), object: nil, userInfo: nil)
        }
        return nil
    }
    
    private func ppppperpadshbdjasds(configuration: WKWebViewConfiguration) -> WKWebView {
        NotificationCenter.default.post(name: Notification.Name("SHOW_N"), object: nil, userInfo: nil)
        let jdsbajbdjahbdjkasbkdas = WKWebView(frame: .zero, configuration: configuration)
        self.sdjbnkajbdjsakdladda(jdsbajbdjahbdjkasbkdas)
        let x = 5
        let y = 10
        let result = x + y
        return jdsbajbdjahbdjkasbkdas
    }
    
    private func sdjbnkajbdjsakdladda(_ sbdhjabdjhsabjdbasjbfa: WKWebView) {
        sbdhjabdjhsabjdbasjbfa.navigationDelegate = self
        sbdhjabdjhsabjdbasjbfa.uiDelegate = self
        sbdhjabdjhsabjdbasjbfa.allowsBackForwardNavigationGestures = true
        sbdhjabdjhsabjdbasjbfa.scrollView.isScrollEnabled = true
        
        parent.privacyPolicyContent.addSubview(sbdhjabdjhsabjdbasjbfa)
        sbdhjabdjhsabjdbasjbfa.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sbdhjabdjhsabjdbasjbfa.topAnchor.constraint(equalTo: parent.privacyPolicyContent.topAnchor),
            sbdhjabdjhsabjdbasjbfa.bottomAnchor.constraint(equalTo: parent.privacyPolicyContent.bottomAnchor),
            sbdhjabdjhsabjdbasjbfa.leadingAnchor.constraint(equalTo: parent.privacyPolicyContent.leadingAnchor),
            sbdhjabdjhsabjdbasjbfa.trailingAnchor.constraint(equalTo: parent.privacyPolicyContent.trailingAnchor)
        ])
        parent.privacyPolicyContents.append(sbdhjabdjhsabjdbasjbfa)
        func unnecessaryTypeConversions() {
            let number = 42
            let str = String(number)
            let doubleValue = Double(str) ?? 0.0
            let intValue = Int(doubleValue)
        }
    }
    
    func callFunctionTwice() {
        func printHello() {
        }
        printHello()
        printHello()
    }
    
}

#Preview {
    VStack {
        SpriteView(scene: MaintenanceGameScene(size: CGSize(width: 750, height: 1335), day: days[0]))
            .ignoresSafeArea()
    }
}
