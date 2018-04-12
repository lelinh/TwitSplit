//
//  HomeViewController.swift
//  TwitSplit
//
//  Created by LinhLe on 4/11/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import RxCocoa

class HomeViewController: BaseViewController {
    let viewModel = HomeViewModel()
    let tweetTableView:UITableView = {
        let table = UITableView()
        table.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.nameOfClasse)
//        table.rowHeight = UITableViewAutomaticDimension
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setupTweetTableView()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadTweets()
    }
    
    func layout() {
        view.addSubview(tweetTableView)
        tweetTableView.snp.makeConstraints { (mk) in
            mk.top.bottom.left.right.equalTo(view)
        }
    }
    
    func setupView() {
        title = "TwitSplit"
        setLeftButton(image: #imageLiteral(resourceName: "reload_twitter"))
        setRightButton(image: #imageLiteral(resourceName: "post_twitter"))
    }
    
    override func rightButtonHandle() {
        let composingVC = ComposingViewController()
        self.present(composingVC, animated: true, completion: nil)
    }
    
    override func leftButtonHandle() {
        viewModel.resetTweets()
    }
}

extension HomeViewController {
    func setupTweetTableView() {
        viewModel.tweets.asDriver()
        .drive(tweetTableView.rx.items(cellIdentifier: TweetTableViewCell.nameOfClasse, cellType: TweetTableViewCell.self))
        {(row, item: Tweet, cell: TweetTableViewCell) in
            cell.setup(tweet: item)
        }.disposed(by: viewModel.disposeBag)
        tweetTableView.rx.itemSelected
            .subscribe(onNext: {[weak self] (indexPath) in
                self?.tweetTableView.deselectRow(at: indexPath, animated: true)
            }).disposed(by: viewModel.disposeBag)
    }
}
