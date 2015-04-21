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
        view.hidden = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func screen() -> CGRect {
        return UIScreen.mainScreen().bounds
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func show() {
        view.hidden = false
    }
    
    func hide() {
        view.hidden = true
    }
    
    func backButton(source:AnyObject, action:Selector, fcolor: UIColor = UIColor.whiteColor()) -> UIButton {
        return self.button("Back", source: source, action: action, frame:CGRectMake(10, 10, 100, 40), fsize: 12, fcolor: fcolor, halign: .Left)
    }
    
    func cancelButton(source:AnyObject, action:Selector, fcolor: UIColor = UIColor.whiteColor()) -> UIButton {
        return self.button("Cancel", source: source, action: action, frame:CGRectMake(10, 10, 100, 40), fsize: 12, fcolor: fcolor, halign: .Left)
    }
    
    func button(title:String, source:AnyObject, action:Selector, frame:CGRect, fsize:CGFloat = 14, fcolor: UIColor = UIColor.whiteColor(), bcolor: UIColor = UIColor.clearColor(), halign: UIControlContentHorizontalAlignment = .Center) -> UIButton {
        var button:UIButton = UIButton()
        button.backgroundColor = bcolor
        button.frame = frame
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(fcolor, forState: .Normal)
        button.addTarget(source, action: action, forControlEvents: .TouchUpInside)
        button.titleLabel?.font = UIFont(name: "Helvetica Neue", size: fsize)
        button.contentHorizontalAlignment = halign
        return button
    }
}