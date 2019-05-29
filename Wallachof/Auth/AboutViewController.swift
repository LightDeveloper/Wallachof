//
//  AboutViewController.swift
//  Wallachof
//
//  Created by Dev2 on 28/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {

    @IBOutlet weak var webAbout: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        webAbout.navigationDelegate = self

        if let filePath = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: "webChof") {
            let urlFile = URL(fileURLWithPath: filePath)
            let fileRequest = URLRequest(url: urlFile)
            webAbout.load(fileRequest)
        } else {
            let url = URL(string: "https://elpais.com")
            let webRequest = URLRequest(url: url!)
            webAbout.load(webRequest)
        }
    }
    
    func grabarDatos() {
        // Primero recojo los datos de la web
        webAbout.evaluateJavaScript("devolverDatos()") { (result, error) in
            
            if let error = error {
                debugPrint("Error \(error.localizedDescription)")
                return
            }
            
            if let resultString = result as? String,
                let resultData = resultString.data(using: .utf8),
                let datos = try? JSONSerialization.jsonObject(with: resultData, options: []) {
                debugPrint("Cojo estos datos \(datos)")
            }
        }
    }
}

extension AboutViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        debugPrint("decidePolicyFor \(navigationAction.request.url)")
        
        if let destURL = navigationAction.request.url,
            let scheme = destURL.scheme,
            let command = destURL.host,
            scheme == "wallachof" {
            
            debugPrint("Ejecuto \(command)")
            if command == "grabarDatos" {
                grabarDatos()
            }
            
            decisionHandler(WKNavigationActionPolicy.cancel)
        } else {
            decisionHandler(WKNavigationActionPolicy.allow)
        }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        debugPrint("didCommit \(webView.url?.absoluteString)")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        debugPrint("didFinish \(webView.url?.absoluteString)")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        debugPrint("Did start \(webView.url?.absoluteString)")
    }
    
    
}
