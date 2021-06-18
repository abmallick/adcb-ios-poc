//
//  AppDelegate.swift
//  AdcbPoc
//
//  Created by Abhinav Mallick on 28/05/21.
//

import UIKit
import AdcbWeb

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NucleiWebCallbackConfig.callbackSetup(with: self)
        return true
    }

}

extension AppDelegate: NucleiCallbackProtocol {
    
    func onSdkExit() {
        print("SDK exit called from nuclei web")
    }
    
}

