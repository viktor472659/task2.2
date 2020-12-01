//
//  CircleProgressBar.swift
//  task1
//
//  Created by Viktor on 27.11.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit

class CircleProgressBar: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
    private var backgroundLayout = CAShapeLayer()
    private var foregroundLayout = CAShapeLayer()
    private var textLayout = CATextLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircle()

    }
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder : aCoder)
        createCircle()
    }
    
    var progressLvl: Int = 0 {
        didSet {
            foregroundLayout.strokeEnd = CGFloat(progressLvl) / 100
            textLayout.string = "\(progressLvl)%"
            switch progressLvl {
                   case 0...33:
                       foregroundLayout.strokeColor = UIColor.red.cgColor
                   case 33...66:
                       foregroundLayout.strokeColor = UIColor.yellow.cgColor
                   case 66...100:
                       foregroundLayout.strokeColor = UIColor.green.cgColor

                   default:
                       foregroundLayout.strokeColor = backgroundColor1.cgColor
                   }
        }
    }
    
    var backgroundColor1: UIColor = UIColor.gray

    
    var animation: Bool  = false{
          didSet {
            #warning("You should reuse initially created layers, instead of creating new ones")
            //i don`t know how do this task for now
              createCircle()

          }
    }
    
    public func createCircle () {
        #warning("To much hard coded values")
        let circle = UIBezierPath(arcCenter: CGPoint(x: 50, y: 50), radius: 50, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        
        backgroundLayout.path = circle.cgPath
        
        backgroundLayout.fillColor = UIColor.clear.cgColor
        backgroundLayout.strokeColor = backgroundColor1.cgColor
        backgroundLayout.lineWidth = 15
        backgroundLayout.strokeEnd = 1
        
        layer.addSublayer(backgroundLayout)
        
        
        foregroundLayout.path = circle.cgPath
        
        foregroundLayout.fillColor = UIColor.clear.cgColor
        foregroundLayout.lineWidth = 15
        
        layer.addSublayer(foregroundLayout)
        
        textLayout.backgroundColor = UIColor.black.cgColor
        textLayout.foregroundColor = UIColor.white.cgColor
        textLayout.frame = CGRect(x: 50-20, y: 50-10, width: 40, height: 20)
        textLayout.alignmentMode = .center
        textLayout.fontSize = 18.0
        
        layer.addSublayer(textLayout)
        
        if(animation){
            animate(toValue:CGFloat(progressLvl)/100)
        }
        
    }
        
    func animate(toValue: CGFloat) {
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 0.0
        strokeAnimation.toValue = toValue
        strokeAnimation.duration = 5
        strokeAnimation.timingFunction=CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        foregroundLayout.add(strokeAnimation, forKey: #keyPath(CALayer.position))
    }
    
}
