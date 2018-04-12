//
//  HomeViewModel.swift
//  TwitSplit
//
//  Created by LinhLe on 4/11/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import RxSwift

class HomeViewModel: BaseViewModel {
    let tweets:Variable<[Tweet]> = Variable([])
    
    func loadTweets() {
        tweets.value = TweetsArchiveUtil.loadTweets() ?? []
    }
    
    func resetTweets() {
        TweetsArchiveUtil.saveTweets(tweets: [])
        loadTweets()
    }
}
