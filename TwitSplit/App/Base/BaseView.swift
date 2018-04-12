//
//  BaseView.swift
//  TwitSplit
//
//  Created by LinhLe on 4/11/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        finishInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        finishInit()
    }
    
    func finishInit() {
        //
    }

}
