//
//  AuthViewController.swift
//  iOS-Slack-API-Example
//
//  Created by WataruSuzuki on 2017/06/26.
//  Copyright © 2017年 WataruSuzuki. All rights reserved.
//

import UIKit
import WebKit
import SlackKit

class AuthViewController: UIViewController,
    WKNavigationDelegate
{
    
    let slackApiRequestAuth = "https://slack.com/oauth/authorize?&client_id="
    let extraScope = "&scope=incoming-webhook,emoji:read,users.profile:read,users.profile:write"
    let mySlackClientID = PropertyListKeyManager().getStringValue(key: "SlackClientID")
    let mySlackClientSecret = PropertyListKeyManager().getStringValue(key: "SlackClientSecret")

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
        
        if let url = URL(string: slackApiRequestAuth + "&client_id=" + mySlackClientID + extraScope) {
            myAuthWebView.load(URLRequest(url: url))
        }
    }
    
    func setupWebViewConstraint() {
        let top = NSLayoutConstraint(item: self.view, attribute: .top, relatedBy: .equal, toItem: myAuthWebView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: myAuthWebView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leading = NSLayoutConstraint(item: self.view, attribute: .leading, relatedBy: .equal, toItem: myAuthWebView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailing = NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: myAuthWebView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([top, bottom, leading, trailing])
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let url = webView.url {
            let urlStr = url.absoluteString
            
            if let codeRange = urlStr.range(of: "?code=") {
                let redirectUrlStr = urlStr.substring(to: codeRange.lowerBound)
                var code = urlStr.substring(from: codeRange.upperBound)
                if let stateRange = code.range(of: "&") {
                    code = code.substring(to: stateRange.lowerBound)
                }
                WebAPI.oauthAccess(clientID: mySlackClientID, clientSecret: mySlackClientSecret, code: code, redirectURI: redirectUrlStr, success: { (resultDictionary) in
                    print(resultDictionary.description)
                    if let accessToken = resultDictionary["access_token"] as? String {
                        SlackKitHelpers.instance.accessToken = accessToken
                        self.dismiss(animated: true, completion: nil)
                    }
                }, failure: { (slackError) in
                    print(slackError)
                })
                
            }
        }
    }
}
