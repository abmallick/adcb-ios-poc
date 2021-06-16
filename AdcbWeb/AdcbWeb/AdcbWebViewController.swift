//
//  AdcbWebViewController.swift
//  AdcbWeb
//
//  Created by Abhinav Mallick on 28/05/21.
//

import UIKit
import WebKit

class AdcbWebViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var webView: DWKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.webView = DWKWebView(frame: self.view.bounds)
        loadNuclei()
        self.webView.navigationDelegate = self
        view.insertSubview(webView, belowSubview: self.activityIndicator)
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
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
    }
    
}

extension AdcbWebViewController: WKNavigationDelegate {


    func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(show: false)
    }

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator(show: true)
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(show: false)
    }
}
