//
//  UserDefaultsUlities.swift
//  TwitSplit
//
//  Created by LinhLe on 4/12/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import Foundation

class TweetsArchiveUtil {
    
    private static let key = "SplitedTweetMessage"

    private static func archiveTweets(tweets : [Tweet]) -> NSData {
        
        return NSKeyedArchiver.archivedData(withRootObject: tweets as NSArray) as NSData
    }
    
    static func loadTweets() -> [Tweet]? {
        if let unarchivedObject = UserDefaults.standard.object(forKey: key) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [Tweet]
        }
        return nil
    }
    
    static func saveTweets(tweets : [Tweet]) {
        let archivedObject = archiveTweets(tweets: tweets)
        UserDefaults.standard.set(archivedObject, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
}
