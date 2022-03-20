//
//  DroarHelper.swift
//  Droar
//
//  Created by Nathan Jangula on 10/25/17.
//

import Foundation
import UIKit
import SwiftUI
import TweakPane

final class DebugPaneWindow: UIWindow {
    
    let defaultContainerAlpha: CGFloat = 0.5
    
    func setActivationPercent(_ percent: CGFloat) {
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: defaultContainerAlpha * percent)
    }
    
}

extension DebugPane {
    
    static func initializeWindow(@BladesBuilder _ content: @escaping () -> [Blade]) {
        
        //Window - we must add Droar to a high level window to keep it always on top
        window = DebugPaneWindow.init(frame: UIScreen.main.bounds)
        window.backgroundColor = .clear
        window.windowLevel = .init(.greatestFiniteMagnitude) //Topmost
        window.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //VC - this is the main screen for Droar
        viewController = UIHostingController(rootView: ContentView(content))
        viewController.title = "Debug Pane"
        
        //Nav - this is the nav stack for Droar
        navController = UINavigationController(rootViewController: viewController!)
        navController.view.frame = CGRect(x: window.frame.width, y: 0, width: drawerWidth, height: window.frame.height)
        navController.view.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        
        //This observer watches for when new windows become available; we need to move gesture recognizer to the new window when this happens
        NotificationCenter.default.addObserver(self, selector: #selector(handleReceivedWindowDidBecomeKeyNotification), name: UIWindow.didBecomeKeyNotification, object: nil)
    }
    
    //Handlers
    @objc private static func handleReceivedWindowDidBecomeKeyNotification(notification: NSNotification) {
        if let window = notification.object as? UIWindow {
            window.addGestureRecognizer(openRecognizer)
        } else {
            loadKeyWindow()?.addGestureRecognizer(openRecognizer)
        }
    }
    
}

struct ContentView: View {
    @BladesBuilder private var content: () -> [Blade]
    
    init(@BladesBuilder _ content: @escaping () -> [Blade]) {
        self.content = content
    }
    
    var body: some View {
        ScrollView {
            Pane(content)
                .padding()
        }
    }
}
