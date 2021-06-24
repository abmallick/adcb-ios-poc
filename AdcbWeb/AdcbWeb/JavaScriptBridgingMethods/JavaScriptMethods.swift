//
//  JavaScriptMethods.swift
//  AdcbWeb
//
//  Created by Abhinav Mallick on 01/06/21.
//

import Foundation

class JSStateManagement {
    struct Static {
        static var instance : JSStateManagement?
    }
    
    class var manager: JSStateManagement {
        if Static.instance == nil {
            Static.instance = JSStateManagement()
        }
        return Static.instance!
    }
    
    var hideLoader: Bool = false
}

class JavaScriptMethods: NSObject {
    
    @objc func onSdkExit(_ arg: String) {
        AdcbWebBaseHandler.manager.close()
        NucleiConfig.onSdkExit!()
    }
    
    @objc func isRTL(_ arg: String) -> String {
        var isRtl: String = "false"
        let language = Bundle.main.preferredLocalizations.first
        if (language == "ar") {
            isRtl = "true"
        }
        return isRtl
    }
    
    @objc func hideLoader(_ arg: String) {
        JSStateManagement.manager.hideLoader = true
    }
    
}
