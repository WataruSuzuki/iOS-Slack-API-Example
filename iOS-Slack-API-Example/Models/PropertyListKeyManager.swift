//
//  PropertyListKeyManager.swift
//  iOS-Slack-API-Example
//
//  Created by WataruSuzuki on 2017/06/30.
//  Copyright © 2017年 WataruSuzuki. All rights reserved.
//

import Foundation

struct PropertyListKeyManager {
    
    func getKeys() -> [String: AnyObject]? {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            return dict
        }
        return nil
    }
    
    func getValue(key: String) -> AnyObject? {
        guard let legacykeys = getKeys() else {
            return nil
        }
        let keys = legacykeys as Dictionary
        return keys[key]
    }
    
}
