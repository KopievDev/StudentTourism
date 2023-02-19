//
//  WebView.swift
//  StudentTourism
//
//  Created by Ivan Kopiev on 19.02.2023.
//

import UIKit
import WebKit

class WebView: BaseView {
    
    @IBOutlet var webView: WKWebView!
    
    override func render() {
        guard let url = state[s:.url].asUrl else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension String {
    static let url = "url"
    
    var asUrl: URL? { URL(string: self) }
}
