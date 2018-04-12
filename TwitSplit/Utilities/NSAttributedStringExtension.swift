//
//  NSAttributedStringExtension.swift
//  TwitSplit
//
//  Created by LinhLe on 4/11/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import UIKit
extension NSAttributedString{
    static func + (string1: NSAttributedString, string2: NSAttributedString) -> NSAttributedString{
        let temp = NSMutableAttributedString()
        temp.append(string1)
        temp.append(string2)
        let result: NSAttributedString = temp
        return result
    }
    convenience public init(text:String, _ color:UIColor, font: UIFont) {
        let attributes:[NSAttributedStringKey : Any] = [NSAttributedStringKey.foregroundColor:color,NSAttributedStringKey.font : font ]
        self.init(string: text, attributes: attributes)
    }
    convenience public init(text: String,font: UIFont) {
        let attributes:[NSAttributedStringKey : Any] = [NSAttributedStringKey.foregroundColor:UIColor.black, NSAttributedStringKey.font : font ]
        self.init(string: text, attributes: attributes)
    }
}
