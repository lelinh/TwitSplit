//
//  AvatarView.swift
//  TwitSplit
//
//  Created by LinhLe on 4/11/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import UIKit

class AvatarView: BaseView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func finishInit() {
        super.finishInit()
        self.backgroundColor = .clear
    }
    override func draw(_ rect: CGRect) {
//        self.isOpaque = false
        let width = rect.width
        let height = rect.height
        let circleWidth = rect.width/6
        let center:CGPoint = CGPoint(x: rect.origin.x + width/2.0, y: rect.origin.y + height/2.0)
        let radius = rect.width/2.0 - circleWidth/2.0
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(-Double.pi/2), endAngle: CGFloat(Double.pi), clockwise: true)
        UIColor.green.setStroke()
        circlePath.lineWidth = circleWidth
        circlePath.stroke()
        
        let upperBoundRadius = rect.width/2.0
        let lowerBoundRadius = rect.width/2.0 - circleWidth
        let startColor: UIColor = UIColor(hex: "2AA3EF")!
        let endColor: UIColor = UIColor(hex: "A1D9F0")!
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        context.drawRadialGradient(gradient, startCenter: center, startRadius: upperBoundRadius, endCenter: center, endRadius: lowerBoundRadius, options: [])
    }
}
