//
//  SlackKitHelpers.swift
//  iOS-Slack-API-Example
//
//  Created by WataruSuzuki on 2017/07/01.
//  Copyright © 2017年 WataruSuzuki. All rights reserved.
//

import UIKit
import SlackKit

class SlackKitHelpers: NSObject {
    static var instance: SlackKitHelpers = SlackKitHelpers()
    private override init() {
    }
    
    var accessToken = ""
    var slack: SlackKit!
    var api: WebAPI!
    
    var emojiResponse: [String: Any]!
    
    func isSlackReady() -> Bool {
        return slack != nil && api != nil
    }
    
    func initSlackKit() {
        slack = SlackKit()
        slack.addWebAPIAccessWithToken(accessToken)
        api = slack.webAPI
    }
}
