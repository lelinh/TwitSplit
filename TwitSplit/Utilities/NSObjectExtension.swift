//
//  NSObjectExtension.swift
//  TwitSplit
//
//  Created by LinhLe on 4/11/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import Foundation

extension NSObject {
    static var nameOfClasse:String = {
        return String(describing: self)
    }()
}
