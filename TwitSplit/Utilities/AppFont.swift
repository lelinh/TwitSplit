//
//  AppFont.swift
//  TwitSplit
//
//  Created by LinhLe on 4/11/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import UIKit

enum AppFont {
    case ArialHebrewLight(size: CGFloat)
    case ArialHebrewBold(size: CGFloat)
}

extension AppFont {
    public var value: UIFont {
        switch self {
        case .ArialHebrewLight(let size):
            return UIFont(name: "ArialHebrew-Light", size: size)!
        case .ArialHebrewBold(let size):
            return UIFont(name: "ArialHebrew-Bold", size: size)!
        default:
            return UIFont(name: "ArialHebrew-Light", size: 16)!
        }
    }
}

