//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Cappy Popp on 4/22/15.
//  Copyright (c) 2015 Cappy Popp. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, HappinessViewDataSource {

    
    @IBOutlet weak var happinessView: HappinessView! {
        didSet {
            happinessView.dataSource = self
            happinessView.addGestureRecognizer(UIPinchGestureRecognizer(target: happinessView, action: "faceScale:"))
        }
    }
    
    // different than smiliness in View, that controls arc of smile,
    // not concept of smiliness - it's the Controller's responsibility
    // to interpret the model for the view. Here is model, controller
    // will xlate happiness in terms that View understands
    var happiness: Int = 10 { // 0 = very sad, 100 = very happy
        didSet {
            happiness = min(max(happiness, 0), 100)
            println("happiness = \(happiness)")
            updateUI()
        }
    }
    
    private struct Constants {
        // for every point here we need to move that many points in the pan to change our happiness
        static let HappinessPanGestureScale: CGFloat = 3
    }
    
    private func updateUI() {
        happinessView.setNeedsDisplay()
    }
    
    @IBAction func changeHappiness(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Ended: fallthrough
        case .Changed:
            let xlationInMyCoords = sender.translationInView(happinessView)
            // let happinessChange = -xlationInMyCoords.y  // NO: too big of a change when small pans
            let happinessChange = -Int(xlationInMyCoords.y / Constants.HappinessPanGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                sender.setTranslation(CGPointZero, inView: happinessView)
            }
        default: break
        }
    }
    
    func smilinessForHappinessView(sender: HappinessView) -> Double? {
        let howhappy = Double(happiness - 50) / 50
        return howhappy
    }

}
