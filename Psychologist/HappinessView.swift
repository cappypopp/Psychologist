//
//  HappinessView.swift
//  Happiness
//
//  Created by Cappy Popp on 4/22/15.
//  Copyright (c) 2015 Cappy Popp. All rights reserved.
//

import UIKit


protocol HappinessViewDataSource: class {
    func smilinessForHappinessView(sender: HappinessView) -> Double?
}

@IBDesignable
class HappinessView: UIView {
    
    private struct Scaling {
        // eyes
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
        // mouth
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3
        static let FaceRadiusToMouthOffsetRatio: CGFloat = 3
    }
    
    private enum Eye { case Left, Right }
    
    private func bezierPathForEye(whichEye: Eye) -> UIBezierPath {
        
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        
        switch whichEye {
        case .Left: eyeCenter.x -= eyeSeparation / 2
        case .Right: eyeCenter.x += eyeSeparation / 2
        }
        
        let path = UIBezierPath()
        path.addArcWithCenter(eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        
        path.lineWidth = strokeWidth
        return path
    }
    
    private func bezierPathForMouth(fractionOfMaxSmile:Double) -> UIBezierPath {
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
        let mouthOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio
        
        let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1), -1)) * mouthHeight

        // start of the mouth
        let mouthStart = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthOffset)
        let mouthEnd = CGPoint(x: mouthStart.x + mouthWidth, y: mouthStart.y)
        let anchorPt1 = CGPoint(x: mouthStart.x + mouthWidth / 3, y: mouthStart.y + smileHeight)
        let anchorPt2 = CGPoint(x: mouthEnd.x - mouthWidth / 3, y: anchorPt1.y)
        
        let path = UIBezierPath()
        path.moveToPoint(mouthStart)
        path.addCurveToPoint(mouthEnd, controlPoint1: anchorPt1, controlPoint2: anchorPt2)
        path.lineWidth = strokeWidth
        
        return path
    }
    
    func faceScale(recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == .Changed {
            scale *= recognizer.scale
            recognizer.scale = 1 // reset scale so we always start from last
        }
    }
    
    // delegate - make sure weak since controller already has a view reference
    // have to make sure that protocol is a class-only type so we can use weak here
    weak var dataSource: HappinessViewDataSource?
    
    var faceCenter: CGPoint {
        return CGPoint(x: frame.size.width/2, y: frame.size.height/2)
    }
    var faceRadius: CGFloat {
            return min(frame.size.width, frame.size.height)/2 * scale
    }
    
    @IBInspectable
    var scale: CGFloat = 0.9 { didSet { setNeedsDisplay() }}
    @IBInspectable
    var strokeColor: UIColor = UIColor.blueColor() { didSet { setNeedsDisplay() }}
    @IBInspectable
    var strokeWidth: CGFloat = 3.0 { didSet { setNeedsDisplay() }}
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath()
        path.addArcWithCenter(faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        path.lineWidth = strokeWidth
        strokeColor.set()
        path.stroke()
        bezierPathForEye(Eye.Left).stroke()
        bezierPathForEye(Eye.Right).stroke()
        
        let smiliness = dataSource?.smilinessForHappinessView(self) ?? 0.0
        let smilePath = bezierPathForMouth(smiliness)
        smilePath.stroke()
    }

}
