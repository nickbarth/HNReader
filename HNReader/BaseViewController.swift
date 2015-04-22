//
//  BaseViewController.swift
//  HNReader
//
//  Created by Nick on 4/19/15.
//  Copyright (c) 2015 Nick. All rights reserved.
//

import UIKit
import Foundation

class BaseViewController : UIViewController {
    override init() {
        super.init(nibName: nil, bundle: nil)
        view.frame = UIScreen.mainScreen().bounds
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bounds() -> CGRect {
        return UIScreen.mainScreen().bounds
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}