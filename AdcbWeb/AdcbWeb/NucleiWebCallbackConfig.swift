//
//  NucleiWebConfig.swift
//  AdcbWeb
//
//  Created by Abhinav Mallick on 18/06/21.
//

import Foundation

public class NucleiConfig {
    public static var onSdkExit: (() -> Void)?
}

@objc public protocol NucleiCallbackProtocol: class {
    @objc func onSdkExit()
}

@objc public final class NucleiWebCallbackConfig: NSObject {
    @objc public static func callbackSetup(with config: NucleiCallbackProtocol) {
        NucleiConfig.onSdkExit = {
            config.onSdkExit()
        }
    }
}
