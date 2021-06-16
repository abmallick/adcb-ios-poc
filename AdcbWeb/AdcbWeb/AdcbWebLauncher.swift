//
//  AdcbWebLauncher.swift
//  AdcbWeb
//
//  Created by Abhinav Mallick on 28/05/21.
//

import Foundation
import UIKit

let adcbWeb = "webView"


@objc public final class AdcbWebLauncher: NSObject {
    
    @objc public class func openAdcbWeb() throws {
        try openAdcbWebDeeplink()
    }
    
    class func openAdcbWebDeeplink() throws {
        
        DispatchQueue.main.async {
            AdcbWebBaseHandler.manager.present()
        }
        
    }
}
