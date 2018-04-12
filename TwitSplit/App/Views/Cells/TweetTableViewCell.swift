//
//  TweetTableViewCell.swift
//  TwitSplit
//
//  Created by LinhLe on 4/11/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import SnapKit

class TweetTableViewCell: UITableViewCell {
    let avatar = AvatarView()
    let userNameLabel = UILabel()
    let timestamp = UILabel()
    let tweetTextView:UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        finishInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func finishInit() {
        tweetTextView.clipsToBounds = true
        tweetTextView.layer.cornerRadius = 5
        tweetTextView.backgroundColor = UIColor(hex: "e8f4f9")
        layout()
    }
    
    func setup(tweet: Tweet) {
        userNameLabel.attributedText = NSAttributedString(text: "@" + tweet.userName, font: AppFont.ArialHebrewBold(size: 16).value)
        timestamp.attributedText = NSAttributedString(text: tweet.time.timeAgo(), .gray, font: AppFont.ArialHebrewBold(size: 12).value)
        tweetTextView.attributedText = NSAttributedString(text: tweet.tweetMessage, font: AppFont.ArialHebrewLight(size: 16).value)
        updateLayout()
    }
    
    func layout() {
        contentView.addSubview(avatar)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(timestamp)
        contentView.addSubview(tweetTextView)
        avatar.snp.makeConstraints { (mk) in
            mk.top.left.equalTo(contentView).offset(16)
            mk.height.equalTo(avatar.snp.width)
            mk.width.equalTo(50)
            mk.bottom.lessThanOrEqualTo(contentView).offset(-16)
        }
        userNameLabel.snp.makeConstraints { (mk) in
            mk.top.equalTo(avatar.snp.top)
            mk.height.equalTo(21)
            mk.left.equalTo(avatar.snp.right).offset(16)
        }
        timestamp.snp.makeConstraints { (mk) in
            mk.top.equalTo(userNameLabel)
            mk.left.equalTo(userNameLabel.snp.right).offset(8)
            mk.height.equalTo(21)
        }
        tweetTextView.snp.makeConstraints { (mk) in
            mk.top.equalTo(userNameLabel.snp.bottom).offset(4)
            mk.left.equalTo(userNameLabel)
            mk.right.equalTo(-16)
            mk.height.equalTo(30)
            mk.bottom.equalTo(contentView).offset(-16)
        }
    }
    
    func updateLayout() {
        let textViewSize = tweetTextView.sizeThatFits(CGSize(width: SCREEN_WIDTH - 16 - 50 - 16 - 16*2, height: 1000))
        tweetTextView.snp.updateConstraints { (mk) in
            mk.height.equalTo(textViewSize.height)
        }
    }
}
