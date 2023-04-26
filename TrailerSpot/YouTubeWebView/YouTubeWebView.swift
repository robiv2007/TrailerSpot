//
//  YouTubeWebView.swift
//  TrailerSpot
//
//  Created by vatran robert on 2023-04-25.
//

import Foundation
import WebKit
import SwiftUI

struct YouTubeWebView: UIViewRepresentable {
    let url : String
    
    func makeUIView(context: Context) -> some WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let youtubeURL = URL(string: url)  else {return}
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }
}
