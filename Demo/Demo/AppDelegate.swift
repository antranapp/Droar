import UIKit
import DebugPane
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    @ObservedObject private var appService = AppService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ViewController(appService: appService)
        self.window?.makeKeyAndVisible()
    
        DebugPane.start {
            InputBlade(name: "Boolean Value", binding: InputBinding(self.$appService.boolVar))
        }
        
        return true
    }
}

class AppService: ObservableObject {
    @Published var boolVar: Bool = false
}
