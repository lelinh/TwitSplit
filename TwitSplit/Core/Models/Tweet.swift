//
//  Tweet.swift
//  TwitSplit
//
//  Created by LinhLe on 4/12/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import Foundation

class Tweet: NSObject, NSCoding {
    var userName:String
    var tweetMessage:String
    var time:Date
    var avatarURL:String
    
    required init(userName: String, tweetMessage: String, time: Date, avatarURL: String) {
        self.userName = userName
        self.tweetMessage = tweetMessage
        self.time = time
        self.avatarURL = avatarURL
    }
    
    
    required init(coder aDecoder: NSCoder) {
        userName = (aDecoder.decodeObject(forKey: "userName") as? String) ?? ""
        tweetMessage = (aDecoder.decodeObject(forKey: "tweetMessage") as? String) ?? ""
        time = (aDecoder.decodeObject(forKey: "time") as? Date) ?? Date(timeIntervalSinceNow: 0)
        avatarURL = (aDecoder.decodeObject(forKey: "avatarURL") as? String) ?? ""
    }
    
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(userName, forKey: "userName")
        aCoder.encode(tweetMessage, forKey: "tweetMessage")
        aCoder.encode(time, forKey: "time")
        aCoder.encode(avatarURL, forKey: "avatarURL")
    }
}
