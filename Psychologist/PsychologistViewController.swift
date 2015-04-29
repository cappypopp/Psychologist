//
//  ViewController.swift
//  Psychologist
//
//  Created by Cappy Popp on 4/11/15.
//  Copyright (c) 2015 Cappy Popp. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {
    
    
    @IBAction func nothing(sender: UIButton) {
        performSegueWithIdentifier("showNothingDiagnosis", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let navcon = destination as? UINavigationController {
            destination = navcon.visibleViewController
        }
        if let hvc = destination as? HappinessViewController {
            if let id = segue.identifier {
                switch id {
                    case "showHappyDiagnosis":
                        hvc.happiness = 100
                    case "showSadDiagnosis":
                        hvc.happiness = 0
                    case "showNothingDiagnosis":
                        hvc.happiness = 20
                case "showMehDiagnosis": fallthrough
                default:
                    hvc.happiness = 50
                }
            }
        }
    }

}

