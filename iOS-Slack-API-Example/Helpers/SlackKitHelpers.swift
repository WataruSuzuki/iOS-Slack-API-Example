//
//  SlackKitHelpers.swift
//  iOS-Slack-API-Example
//
//  Created by WataruSuzuki on 2017/07/01.
//  Copyright © 2017年 WataruSuzuki. All rights reserved.
//

import UIKit

class SlackKitHelpers: NSObject {
    static var instance: SlackKitHelpers = SlackKitHelpers()
    private override init() {
    }
    
    var accessToken = ""
    
}
