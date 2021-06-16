//
//  AdcbWebBaseHandler.swift
//  AdcbWeb
//
//  Created by Abhinav Mallick on 28/05/21.
//

import Foundation
import UIKit

public class AdcbWebBaseHandler {
    
    enum AdcbWebDeeplink: String {
        case webView
    }
    
    let bundleIdentifierName: String = "com.AdcbWeb"
    let storyBoardIdentifier: String = "AdcbStoryboard"

    
    struct Static
    {
        static var instance : AdcbWebBaseHandler?
    }
    
    public class var manager: AdcbWebBaseHandler
    {
        if Static.instance == nil
        {
            Static.instance = AdcbWebBaseHandler()
        }
        return Static.instance!
    }
    
    class func dispose()
    {
        AdcbWebBaseHandler.Static.instance = nil
        
    }
    
    
    public func present() {
        var controller: UIViewController
        controller = UIStoryboard(name: self.storyBoardIdentifier, bundle: Bundle(identifier: bundleIdentifierName)).instantiateViewController(withIdentifier: "AdcbWebViewController")
        let navigationController = UIViewController.topMost?.navigationController
        
        if let navController = navigationController {
            navController.pushViewController(controller, animated: true)
        } else {
            let rootNavigationController = UINavigationController(rootViewController: controller)
            rootNavigationController.modalPresentationStyle = controller.modalPresentationStyle
            rootNavigationController.modalTransitionStyle = controller.modalTransitionStyle
            // self.navigationController.present(rootNavigationController, animated: true, completion: nil)
           
            
            controller.presentationStyle = ViewPresentationStyle.Present
            rootNavigationController.presentationStyle = ViewPresentationStyle.Present
            UIViewController.topMost?.nucleiModulePresent(rootNavigationController, animated: true)
        }
        
    }
    
    public func close() {
        let controller = UIViewController.topMost
        
        if let activeController = controller {
            activeController.dismiss(animated: true, completion: nil)
        } else {
            exit(0)
        }
    }
    
}
