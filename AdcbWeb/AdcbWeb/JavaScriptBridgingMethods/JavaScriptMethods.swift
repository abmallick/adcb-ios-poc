//
//  JavaScriptMethods.swift
//  AdcbWeb
//
//  Created by Abhinav Mallick on 01/06/21.
//

import Foundation

class JavaScriptMethods: NSObject {
    
    var userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection
    {
        if #available(iOS 9.0, *) {
            return UIView.userInterfaceLayoutDirection(for: UIView.appearance().semanticContentAttribute)
        } else {
            return UIApplication.shared.userInterfaceLayoutDirection
        }
    }
    
    @objc func onSdkExit(_ arg: String) {
        AdcbWebBaseHandler.manager.close()
    }
    
    @objc func isRTL(_ arg: String) -> Bool {
        var isRtl: Bool = false
        if userInterfaceLayoutDirection == .rightToLeft {
            isRtl = true
        }
        return isRtl
    }
    
    @objc func hideLoader(_ arg: String) {
        print("Native hide loader")
    }
    
}
