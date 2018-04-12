//
//  ComposeView.swift
//  TwitSplit
//
//  Created by LinhLe on 4/11/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import SnapKit
import RxSwift

class ComposeView: BaseView {
    
    let avatarView = AvatarView()
    let inputTextView = UITextView()
    let counterLabel = UILabel()
    var isEditted:Variable<Bool> = Variable(false)
    
    override func finishInit() {
        super.finishInit()
        layout()
        setup()
    }
    
    func setup() {
        inputTextView.font = UIFont(name: "ArialHebrew-Light", size: 16)!
        counterLabel.font = UIFont(name: "ArialHebrew-Bold", size: 16)!
        counterLabel.textColor = UIColor.gray
        setPlaceHolder()
        inputTextView.delegate = self
    }
    
    func layout() {
        self.addSubview(avatarView)
        self.addSubview(inputTextView)
        self.addSubview(counterLabel)
        avatarView.snp.makeConstraints { (mk) in
            mk.top.left.equalTo(self).offset(16)
            mk.height.equalTo(avatarView.snp.width)
            mk.width.equalTo(50)
        }
        inputTextView.snp.makeConstraints { (mk) in
            mk.top.equalTo(self).offset(16)
            mk.left.equalTo(avatarView.snp.right).offset(8)
            mk.right.equalTo(self).offset(-16)
        }
        counterLabel.snp.makeConstraints { (mk) in
            mk.top.equalTo(inputTextView.snp.bottom).offset(4)
            mk.right.equalTo(inputTextView)
            mk.bottom.equalTo(self).offset(-16)
        }
    }
    
    func setPlaceHolder() {
        isEditted.value = false
        inputTextView.attributedText = NSAttributedString(text: "What's going on?", .gray, font: UIFont(name: "ArialHebrew-Light", size: 16)!)
        updateCounter(0)
    }
    
    func updateCounter(_ value: Int) {
        counterLabel.text = "\(value)"
    }
}

extension ComposeView: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.textColor == .gray{
            let newPosition = textView.beginningOfDocument
            textView.selectedTextRange = textView.textRange(from: newPosition, to: newPosition)
        }
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if textView.textColor == .gray{
            let newPosition = textView.beginningOfDocument
            textView.selectedTextRange = textView.textRange(from: newPosition, to: newPosition)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let oldText = textView.text as NSString
        let newText = oldText.replacingCharacters(in: range, with: text)
        if newText == "" {
            setPlaceHolder()
            return false
        } else if textView.textColor == .gray {
            if text == "" { return false }
            textView.textColor = .black
            textView.text = " "
            textView.text = text
            updateCounter(text.count)
            isEditted.value = true
            return false
        }
        updateCounter(newText.count)
        isEditted.value = true
        return true
    }
}
