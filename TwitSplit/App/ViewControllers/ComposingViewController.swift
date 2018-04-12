//
//  ComposingViewController.swift
//  TwitSplit
//
//  Created by LinhLe on 4/9/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import SnapKit

class ComposingViewController: BaseViewController {
    let viewModel = ComposingViewModel()
    let contentScrollView = UIScrollView()
    let composeView = ComposeView()
    
    let backButton:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "remove_twitter"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    let tweetButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "50B4F2")
        button.setAttributedTitle(NSAttributedString(text: "Tweet", .white, font: UIFont(name: "HelveticaNeue-Bold", size: 16)!) , for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()

    let inputText:UITextView = {
       let textView = UITextView()
        return textView
    }()
    
    var keyboardHeight:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setObserver()
        setupView()
        layout()
        backButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        tweetButton.addTarget(self, action: #selector(tweetTapped), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func setObserver() {
        viewModel.failureSubject.subscribe(onNext: { [weak self] (failure) in
            guard let weakSelf = self else { return }
            weakSelf.showAlert(title: "Fail!", message: failure.message)
        }).disposed(by: viewModel.disposeBag)
        viewModel.successSubject.subscribe(onNext: {[weak self] (_) in
            self?.dismiss(animated: true)
        }).disposed(by: viewModel.disposeBag)
        composeView.isEditted.asObservable()
            .bind {[weak self] (isEditted) in
                self?.tweetButton.isEnabled = isEditted
                self?.tweetButton.backgroundColor = isEditted ? UIColor(hex: "50B4F2") : UIColor(hex: "e8f4f9")
        }.disposed(by: viewModel.disposeBag)
    }
    
    func setupView() {
        tweetButton.clipsToBounds = true
        tweetButton.layer.cornerRadius = 18
    }
    
    func layout() {
        view.addSubview(composeView)
        view.addSubview(backButton)
        view.addSubview(tweetButton)
        composeView.snp.makeConstraints { (mk) in
            mk.bottom.left.right.equalTo(view)
            mk.top.equalTo(backButton.snp.bottom).offset(16)
        }
        backButton.snp.makeConstraints { (mk) in
            mk.top.equalTo(view).offset(24)
            mk.left.equalTo(view).offset(16)
            mk.height.equalTo(50)
            mk.height.equalTo(backButton.snp.width)
        }
        tweetButton.snp.makeConstraints { (mk) in
            mk.centerY.equalTo(backButton.snp.centerY)
            mk.right.equalTo(view).offset(-16)
            mk.height.equalTo(36)
            mk.width.equalTo(tweetButton.snp.height).multipliedBy(1.8)
        }
        contentScrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: contentScrollView.frame.height)
    }
    
    func updateLayout(with animationTime: Double) {
        composeView.snp.updateConstraints { (mk) in
            mk.bottom.equalTo(view).offset(-keyboardHeight)
        }
        UIView.animate(withDuration: TimeInterval(animationTime), animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue{
            var animationTime:Double = 0
            if let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double {                animationTime = duration
            }
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
            updateLayout(with: animationTime)
        }
    }

    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            var animationTime:Double = 0
            if let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double {                animationTime = duration
            }
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
            updateLayout(with: animationTime)
        }
    }

    @objc func closeTapped() {
        composeView.inputTextView.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func tweetTapped() {
        composeView.inputTextView.resignFirstResponder()
        viewModel.tweet(tweet: composeView.inputTextView.text ?? "")
    }
}
