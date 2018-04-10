//
//  ComposingViewController.swift
//  TwitSplit
//
//  Created by LinhLe on 4/9/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import UIKit

class ComposingViewController: BaseViewController {
    let viewModel = ComposingViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setObserver()
    }
    func setObserver() {
        viewModel.failureSubject.subscribe(onNext: { [weak self] (failure) in
            guard let weakSelf = self else { return }
            weakSelf.showAlert(title: "Fail!", message: failure.message)
        }).disposed(by: viewModel.disposeBag)
    }
}
