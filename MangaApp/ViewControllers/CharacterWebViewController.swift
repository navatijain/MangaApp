//
//  CharacterWebViewController.swift
//  MangaApp
//
//  Created by Navati Jain on 2021-02-13.
//

import UIKit
import WebKit

class CharacterWebViewController: BaseViewController {
    
    var webview: WKWebView!
    let urlString: String
    
    override func loadView() {
        webview = WKWebView()
        view = webview
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let url = URL(string: urlString) {
            webview.load(URLRequest(url: url))
            webview.allowsBackForwardNavigationGestures = true
        }
    }
    
    init(title: String, urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
