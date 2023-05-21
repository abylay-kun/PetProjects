//
//  WebView.swift
//  BookmarkUIKIT
//
//  Created by Abylay Duzel on 08.05.2023.
//

import UIKit
import WebKit

class WebView: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
   
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    
}
