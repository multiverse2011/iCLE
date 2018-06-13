//
//  ViewController.swift
//  cle
//
//  Created by iris on 2018/05/30.
//  Copyright © 2018年 multiverse2011. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let uid:String = ""
        let password:String = ""
        
        let executeJs:String = "javascript:document.querySelector('#userId').value='" + uid + "';document.querySelector('#password').value='" + password + "';document.querySelector('#loginButton').click();"
        let userScript = WKUserScript(source: executeJs, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let controller = WKUserContentController()
        controller.addUserScript(userScript)

        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController = controller
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://cleweb.tsc.u-tokai.ac.jp")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
