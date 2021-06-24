//
//  AdcbWebViewController.swift
//  AdcbWeb
//
//  Created by Abhinav Mallick on 28/05/21.
//

import UIKit
import WebKit
import JavaScriptCore

let retrySeconds = 5 //wait for 3secs to reload

class AdcbWebViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "logHandler" {
                print("LOG: \(message.body)")
            }
    }
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var webView: DWKWebView!
    var timer: Timer?
    var count: Int = retrySeconds
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove all cache
        URLCache.shared.removeAllCachedResponses()

        // Delete any associated cookies
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
        
        if #available(iOS 14.0, *) {
            let configuration = WKWebViewConfiguration()
            configuration.limitsNavigationsToAppBoundDomains = true
            self.webView = DWKWebView(frame: self.view.bounds, configuration: configuration)
        } else {
            self.webView = DWKWebView(frame: self.view.bounds)
        }
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Script to Add web logging script
//        let source = "function captureLog(msg) { window.webkit.messageHandlers.logHandler.postMessage(msg); } window.console.log = captureLog;"
//        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
//        webView.configuration.userContentController.addUserScript(script)
        
        webView.configuration.userContentController.add(self, name: "logHandler")
        
        loadNuclei()
        self.webView.navigationDelegate = self
        view.insertSubview(webView, belowSubview: self.activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
//        startTimer()
        loadNuclei()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.webView.removeJavascriptObject("nuclei")
    }
    
    func waitUntilFullyLoaded(_ completionHandler: @escaping () -> Void) {
        if (self.webView.estimatedProgress >= 1.0 && JSStateManagement.manager.hideLoader){
            print("Webview fully loaded!")
            completionHandler()
        } else {
            print("Webview not fully loaded yet....")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                [weak self] in
                self?.waitUntilFullyLoaded(completionHandler)
            })
        }
    }
    
    
    func hideLoader() {
        if (self.webView.estimatedProgress >= 1.0 && JSStateManagement.manager.hideLoader) {
            print("Webview fully loaded!")
            self.activityIndicator.stopAnimating()
            timer?.invalidate()
            timer = nil
        } else {
            print("Webview not fully loaded")
        }
    }
    
    private func loadNuclei() {
        DispatchQueue.main.async {
            let webUrl = "https://flutter-web-ios.web.app/#/"
            if let urlString = URL(string: webUrl) {
                let request = URLRequest(url: urlString)
                self.webView?.addJavascriptObject(JavaScriptMethods(), namespace: "nuclei")
                self.webView?.load(request)
            }
        }
        
        waitUntilFullyLoaded { [weak self] in
            self?.hideLoader()
        }
    }
    
}
