
//
//  WebViewController.swift
//  seSACLecutreNetworkBasic
//
//  Created by 이도헌 on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    // 08.11
//    static var resueIdentifier: String = String(describing: WebViewController.self)
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    var destinationURL: String = "https://www.apple.co.kr"
    // App transport Scurity Settings
    // http X
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openWebPage(url: destinationURL)
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
    }
    
    func openWebPage(url: String) {
        //유효한 url 구조가 맞는지 체크, 오타, 없는 사이트 등
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
        
    }
}

// 서치바도 액션이 없다.
extension WebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        openWebPage(url: searchBar.text!)
    }
}
