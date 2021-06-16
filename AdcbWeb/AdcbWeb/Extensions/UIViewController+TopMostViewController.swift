//
//  UIViewController+TopMostViewController.swift
//  Core
//
//  Created by Prasanna Aithal on 10/12/18.
//  Copyright © 2018 Prasanna Aithal. All rights reserved.
//
//


import Foundation
import UIKit

public enum ViewPresentationStyle {
    case Push
    case Present
}

extension UIViewController {
    
    struct ViewPresentationStyleAssociatedKeys {
        static var controllerStateKey: UInt8 = 0
        
    }
    
    public var presentationStyle: ViewPresentationStyle! {
        get {
            return objc_getAssociatedObject(self, &ViewPresentationStyleAssociatedKeys.controllerStateKey) as? ViewPresentationStyle
        }
        set(newValue) {
            objc_setAssociatedObject(self, &ViewPresentationStyleAssociatedKeys.controllerStateKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private class var sharedApplication: UIApplication? {
        let selector = NSSelectorFromString("sharedApplication")
        return UIApplication.perform(selector)?.takeUnretainedValue() as? UIApplication
    }
    
    /// Returns the current application's top most view controller.
    open class var topMost: UIViewController? {
        guard let currentWindows = self.sharedApplication?.keyWindow else { return nil }

        return self.topMost(of: currentWindows.rootViewController)
        
    }
    
    
    /// Returns the top most view controller from given view controller's stack.
    open class func topMost(of viewController: UIViewController?) -> UIViewController? {
        // presented view controller
        if let presentedViewController = viewController?.presentedViewController {
            return self.topMost(of: presentedViewController)
        }
        
        // UITabBarController
        if let tabBarController = viewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return self.topMost(of: selectedViewController)
        }
        
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return self.topMost(of: visibleViewController)
        }
        
        // UIPageController
        if let pageViewController = viewController as? UIPageViewController,
            pageViewController.viewControllers?.count == 1 {
            return self.topMost(of: pageViewController.viewControllers?.first)
        }
        
        // child view controller
        for subview in viewController?.view?.subviews ?? [] {
            if let childViewController = subview.next as? UIViewController {
                return self.topMost(of: childViewController)
            }
        }
        return viewController
    }
    
    
}

extension UIViewController {
    
    public func nucleiModulePresent(_ viewControllerToPresent: UIViewController,
                                 animated flag: Bool,
                                 completion: (() -> Void)? = nil) {
        
        
        if #available(iOS 13.0, *) {
            if viewControllerToPresent.modalPresentationStyle == .automatic || viewControllerToPresent.modalPresentationStyle == .pageSheet {
            viewControllerToPresent.modalPresentationStyle = .fullScreen
          }
        }
    
        present(viewControllerToPresent, animated: flag, completion: completion)
    }
}

