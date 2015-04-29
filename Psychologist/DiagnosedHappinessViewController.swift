//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by Cappy Popp on 4/29/15.
//  Copyright (c) 2015 Cappy Popp. All rights reserved.
//

import UIKit

class DiagnosedHappinessViewController: HappinessViewController {
    
    override var happiness: Int {
        didSet {
            diagnosisHistory += [happiness]
        }
    }
    
    private struct Constants {
        static let SegueID = "showDiagnosticHistory"
        static let UserDefaultsKey = "asdfasdf"
    }
    
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var diagnosisHistory: [Int] {
        get { return userDefaults.objectForKey(Constants.UserDefaultsKey) as? [Int] ?? []}
        set { userDefaults.setObject(newValue, forKey: Constants.UserDefaultsKey)}
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let identifier = segue.identifier {
            switch identifier {
            case Constants.SegueID:
                if let hvc = segue.destinationViewController as? HistoryViewController {
                    hvc.text = "\(diagnosisHistory)"
                }
            default: break
            }
        }
        
    }
    
}
