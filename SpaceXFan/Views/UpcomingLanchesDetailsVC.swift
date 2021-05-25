//
//  UpcomingLanchesDetailsVC.swift
//  SpaceXFan
//
//  Created by ggajulapati on 23/05/21.
//

import UIKit
import WebKit
class UpcomingLanchesDetailsVC: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    let upcomingLanchesDetailsViewModel = UpcomingLanchesDetailsViewModel()
    
    
    lazy var loader : LoaderView = {
        let viewModel = LoaderView()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    private func setUI() {
        self.title = upcomingLanchesDetailsViewModel.getName()
        if let webURL = upcomingLanchesDetailsViewModel.getArticalUrl() {
            if let url = URL(string: webURL) {
                loader.show(in: self.view)
                let request = URLRequest(url: url)
                webView.navigationDelegate = self
                webView.load(request)
                print("URL:::",url)
            }
        }
    }
}

// MARK: - WKNavigationDelegate methods

extension UpcomingLanchesDetailsVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.loader.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail",error.localizedDescription)
        self.loader.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.loader.dismiss()
        print("didFailProvisionalNavigation",error.localizedDescription)
        
    }
}



