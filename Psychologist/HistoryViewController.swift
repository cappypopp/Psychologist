//
//  HistoryViewController.swift
//  Psychologist
//
//  Created by Cappy Popp on 4/29/15.
//  Copyright (c) 2015 Cappy Popp. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var history: UITextView! {
        didSet {
            // no need for optional chaining becuase
            // we know system is setting it
            history.text = text
        }
    }
    
    var text: String = "" {
        didSet {
            history?.text = text
        }
    }
    
    override var preferredContentSize: CGSize {
        get {
            if history != nil && presentingViewController != nil {
                return history.sizeThatFits(presentingViewController!.view.bounds.size)
            } else {
                return super.preferredContentSize
            }
        }
        set { super.preferredContentSize = newValue }
    }
}
