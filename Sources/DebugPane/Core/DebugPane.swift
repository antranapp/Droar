//
//  Droar.swift
//  Pods
//
//  Created by Nathan Jangula on 6/5/17.
//
//

import UIKit
import SwiftUI

public final class DebugPane {

    public enum GestureType: UInt {
        case tripleTap, panFromRight
    }

    static var window: DroarWindow!
    
    static var navController: UINavigationController!
    static var viewController: UIViewController!
    static let drawerWidth: CGFloat = 300
    private static let startOnce = DispatchOnce()
    
    public static func start(with gesture: GestureType = .panFromRight) {
        startOnce.perform {
            initializeWindow()
            setGestureType(gesture)
        }
    }
    
    public static func setGestureType(_ type: GestureType, _ threshold: CGFloat = 50.0) {
        configureRecognizerForType(type, threshold)
    }
    
    //Navigation
    public static func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navController.pushViewController(viewController, animated: animated)
    }
    
    public static func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        navController.present(viewController, animated: animated, completion: completion)
    }
    
    //Internal Accessors
    static func loadKeyWindow() -> UIWindow? {
        var window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        if window == nil {
            window = UIApplication.shared.keyWindow
        }
        
        return window
    }
    
    static func loadActiveResponder() -> UIViewController? {
        return loadKeyWindow()?.rootViewController
    }
    
}

//Visibility
extension DebugPane {
    
    //Technically this could be wrong depending on the tx value, but it is close enough.
    public static var isVisible: Bool { return !(navController.view.transform == CGAffineTransform.identity) }
    
    public static func openDroar(completion: (()->Void)? = nil) {
        window.isHidden = false
        
        UIView.animate(withDuration: 0.25, animations: {
            navController.view.transform = CGAffineTransform(translationX: -navController.view.frame.size.width, y: 0)
            window.setActivationPercent(1)
        }) { (completed) in
            //Swap gestures
            openRecognizer.view?.removeGestureRecognizer(openRecognizer)
            window.addGestureRecognizer(dismissalRecognizer)
            
            completion?()
        }
    }
    
    public static func closeDroar(completion: (()->Void)? = nil) {
        UIView.animate(withDuration: 0.25, animations: {
            navController.view.transform = CGAffineTransform.identity
            window.setActivationPercent(0)
        }) { (completed) in
            window.isHidden = true
            
            //Swap gestures
            dismissalRecognizer.view?.removeGestureRecognizer(dismissalRecognizer)
            replaceGestureRecognizer(with: openRecognizer)
            
            completion?()
        }
    }
    
    static func toggleVisibility(completion: (()->Void)? = nil) {
        if isVisible {
            closeDroar(completion: completion)
        } else {
            openDroar(completion: completion)
        }
    }
    
}

//Backwards compatibility
extension DebugPane {
    
    public static func dismissWindow() {
        closeDroar(completion: nil)
    }
    
}
