//
//  ViewController.swift
//  iOSToJS
//
//  Created by developer1 Jeyabalaji on 15/5/19.
//  Copyright © 2019 Ant and Buffalo. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKScriptMessageHandler {
    
    var webView: WKWebView!;
    @IBAction func sendToJS(_ sender: UIButton) {
        print("woo lah native")
        self.invokeJSFunction()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("Native: I recieved a message \(message)");
        
        print("name -- \(message.name) --- body -- \(message.body)" )
    }
    
    
    func createWebView(config: WKWebViewConfiguration) -> WKWebView {
        let frameRect = CGRect(x: 0, y:300, width: 500, height: 500)
        let webView = WKWebView(frame: frameRect, configuration: config)
        
        //webView.frame = CGRect(x: webView.frame.origin.x, y: webView.frame.origin.y + 500, width: webView.frame.size.width, height: webView.frame.size.height)
        view.addSubview(webView)
        
        let layoutGuide = view.safeAreaLayoutGuide
        
//        webView.translatesAutoresizingMaskIntoConstraints = false
//        webView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
//        webView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
//        webView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
//        webView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        webView.uiDelegate = self;
        
        return webView
    }
    
    func getConfig() -> WKWebViewConfiguration {
        let userContentController = WKUserContentController()
        
        let config = WKWebViewConfiguration()
        config.userContentController = userContentController;
        
        userContentController.add(self, name: "test")
        
        return config;
    }
    
    func loadWebContent() {
        
        webView = self.createWebView(config: self.getConfig());
        
        if let url = Bundle.main.url(forResource: "home", withExtension: "html") {
            //webView.load(URLRequest(url: url))
            webView.loadFileURL(url, allowingReadAccessTo: url)
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    
    
    func invokeJSFunction() {
        let jsCallBack: String = String.init("showAlert()");
        webView.evaluateJavaScript("showAlert()", completionHandler: nil);
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadWebContent();
        
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        print("i should display alert in native ");
        completionHandler();
    }


}

