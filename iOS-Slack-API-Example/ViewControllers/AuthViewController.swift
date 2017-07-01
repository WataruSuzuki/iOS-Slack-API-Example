//
//  AuthViewController.swift
//  iOS-Slack-API-Example
//
//  Created by WataruSuzuki on 2017/06/26.
//  Copyright © 2017年 WataruSuzuki. All rights reserved.
//

import UIKit
import WebKit

class AuthViewController: UIViewController,
    WKNavigationDelegate
{
    
    let slackApiRequestAuth = "https://slack.com/oauth/authorize?&client_id="
    let extraScope = "&scope=incoming-webhook,emoji:read,users.profile:read,users.profile:write"
    var myAuthWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func loadView() {
        super.loadView()
        setupWebView()
    }
    
    func setupWebView() {
        myAuthWebView = WKWebView(frame: self.view.frame, configuration: WKWebViewConfiguration())
        myAuthWebView.navigationDelegate = self
        myAuthWebView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(myAuthWebView)
        
        setupWebViewConstraint()
        
        if let mySlackClientID = PropertyListKeyManager().getValue(key: "SlackClientID") as? String {
            if let url = URL(string: slackApiRequestAuth + "&client_id=" + mySlackClientID + extraScope) {
                myAuthWebView.load(URLRequest(url: url))
            }
        }
    }
    
    func setupWebViewConstraint() {
        let top = NSLayoutConstraint(item: self.view, attribute: .top, relatedBy: .equal, toItem: myAuthWebView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: myAuthWebView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leading = NSLayoutConstraint(item: self.view, attribute: .leading, relatedBy: .equal, toItem: myAuthWebView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailing = NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: myAuthWebView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([top, bottom, leading, trailing])
    }
}
