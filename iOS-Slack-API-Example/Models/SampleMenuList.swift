//
//  SampleMenuList.swift
//  iOS-Slack-API-Example
//
//  Created by WataruSuzuki on 2017/06/30.
//  Copyright © 2017年 WataruSuzuki. All rights reserved.
//

import Foundation

public enum SampleMenuList: Int {
    case auth = 0,
    emoji_read,
    users_profile_read,
    users_profile_write,
    max
    
    func toString() -> String {
        return String(describing: self)
    }
}
