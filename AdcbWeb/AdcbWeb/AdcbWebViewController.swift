//
//  AdcbWebViewController.swift
//  AdcbWeb
//
//  Created by Abhinav Mallick on 28/05/21.
//

import UIKit
import WebKit

let retrySeconds = 8

class AdcbWebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var webView: DWKWebView!
    var timer = Timer()
    var count: Int = retrySeconds //wait for 15secs to reload
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.webView = DWKWebView(frame: self.view.bounds)
        webView.setDebugMode(true)
        loadNuclei()
        self.webView.navigationDelegate = self
        view.insertSubview(webView, belowSubview: self.activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        startTimer()
    }
    
    @objc func update() {
        self.count -= 1
        if JSStateManagement.manager.hideLoader {
            hideLoader()
        } else if self.count < 0 {
            startTimer()
        }
    }
    
    func startTimer() {
        loadNuclei()
        self.count = retrySeconds //renew timer count
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.update)), userInfo: nil, repeats: true)
    }
    
    func hideLoader() {
        if (self.webView.estimatedProgress >= 1.0 && JSStateManagement.manager.hideLoader) {
            print("Webview fully loaded!")
            self.activityIndicator.stopAnimating()
            self.timer.invalidate()
        } else {
            print("Webview not fully loaded")
        }
    }
    
    private func loadNuclei() {
        DispatchQueue.main.async {
            let webUrl = "https://flutter-web-ios.web.app/#/"
            if let urlString = URL(string: webUrl) {
                let request = URLRequest(url: urlString)
                self.webView?.addJavascriptObject(JavaScriptMethods(), namespace: nil)
                self.webView?.load(request)
            }
        }
        
        hideLoader()
    }
    
}
