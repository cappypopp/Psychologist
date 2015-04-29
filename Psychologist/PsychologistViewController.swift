//
//  ViewController.swift
//  Psychologist
//
//  Created by Cappy Popp on 4/11/15.
//  Copyright (c) 2015 Cappy Popp. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let hvc = segue.destinationViewController as? HappinessViewController {
            if let id = segue.identifier {
                switch id {
                    case "showHappyDiagnosis":
                        hvc.happiness = 100
                    case "showMehDiagnosis":
                        hvc.happiness = 50
                    case "showSadDiagnosis":
                        hvc.happiness = 0
                default: break
                }
            }
        }
    }

}

