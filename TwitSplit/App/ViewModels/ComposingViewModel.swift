//
//  ComposingViewModel.swift
//  TwitSplit
//
//  Created by LinhLe on 4/9/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import RxSwift

class ComposingViewModel: BaseViewModel {
    let failureSubject = PublishSubject<Failure>()
    let successSubject = PublishSubject<Bool>()
    var tweets:[Tweet] = []
    var newTweets:[Tweet] = []
    let splitter = TwitterSplitMessage()
    
    func tweet(tweet: String) {
        tweets = TweetsArchiveUtil.loadTweets() ?? []
        var tweetMessages:[String] = []
        let splitResult = splitter.split(message: tweet, result: &tweetMessages)
        if ((splitResult == .Failure) || (splitResult == .Success)) {
            for tweetMessage in tweetMessages {
                newTweets.append(Tweet(userName: "Linh", tweetMessage: tweetMessage, time: Date(timeIntervalSinceNow: 0), avatarURL: ""))
            }
            tweets = newTweets + tweets
            TweetsArchiveUtil.saveTweets(tweets: tweets)
            successSubject.onNext(true)
        }else{
            failureSubject.onNext(Failure(message: splitResult.rawValue))
        }
    }
}
