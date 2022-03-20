//
// Copyright © 2022 An Tran. All rights reserved.
//

import DebugPane
import SwiftUI
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    @ObservedObject private var appService = AppService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ViewController(appService: appService)
        self.window?.makeKeyAndVisible()
    
        DebugPane.start {
            InputBlade(name: "Dark Mode", binding: InputBinding(self.$appService.darkModeEnabled))
        }
        
        return true
    }
}

class AppService: ObservableObject {
    @Published var darkModeEnabled: Bool = true
}
