//
//  NewsCell.swift
//  HNReader
//
//  Created by Nick on 4/20/15.
//  Copyright (c) 2015 Nick. All rights reserved.
//

import Foundation
import UIKit

class NewsCell: UITableViewCell {
    let data:NSDictionary
    let parent:NewsViewController
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!, data:NSDictionary, parent:NewsViewController) {
        self.data = data
        self.parent = parent
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if let title = data["title"] as? String {
            var titleLabel:UILabel = makeLabel(title, frame: CGRectMake(5, 2, screen().width - 50, 24), size: 12, color: UIColor.lightGrayColor())
            self.addSubview(titleLabel)
        }
        
        if var url = data["url"] as? String {
            url = url.stringByReplacingOccurrencesOfString("https://", withString: "")
            url = url.stringByReplacingOccurrencesOfString("http://", withString: "")
            url = url.stringByReplacingOccurrencesOfString("www.", withString: "")
            
            if (url.rangeOfString("/") != nil) {
                url = url.substringToIndex(url.rangeOfString("/")!.startIndex)
            }
            
            var urlLabel:UILabel = makeLabel(url, frame: CGRectMake(5, 15, screen().width - 50, 20), size: 10, color: UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1))
            self.addSubview(urlLabel)
        }
        
        if let score = data["score"] as? Double {
            if let comments = data["descendants"] as? Int {
                if let epoch = data["time"] as? Double {
                    if let storyId = data["id"] as? Int {
                        let date = NSDate(timeIntervalSince1970: epoch)
                        let formatter = NSDateFormatter()
                        formatter.dateStyle = .MediumStyle
                        formatter.timeStyle = .ShortStyle
                        let dateTime = formatter.stringFromDate(date)

                        var scoreLabel:UILabel = makeLabel("\(score) points and \(comments) comments | \(dateTime)", frame: CGRectMake(5, 30, screen().width - 50, 10), size: 8, color: UIColor.grayColor())
                        self.addSubview(scoreLabel)
                        
                        var button:UIButton = makeButton("\(comments)", source: parent, action: "goToComments:", frame: CGRectMake(screen().width - 35, 14, 20, 20), fcolor: UIColor.grayColor())
                        button.layer.cornerRadius = 10
                        button.layer.borderWidth = 1
                        button.layer.borderColor = UIColor.darkGrayColor().CGColor
                        button.tag = storyId
                        button.backgroundColor = UIColor.clearColor()
                        self.addSubview(button)
                    }
                }
            }
        }
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func goToComments() {
        if let storyId = data["id"] as? Int {
        }
    }
    
    func makeButton(title:String, source:AnyObject, action:Selector, frame:CGRect, fsize:CGFloat = 10, fcolor: UIColor = UIColor.whiteColor(), bcolor: UIColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1), halign: UIControlContentHorizontalAlignment = .Center) -> UIButton {
 
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
    
    func makeText(title:String) -> UITextView {
        var text:UITextView = UITextView()
        text.text = title
        text.backgroundColor = UIColor.whiteColor()
        text.font = UIFont(name: "Helvetica Neue", size: 30)
        text.textAlignment = NSTextAlignment.Center
        text.autocorrectionType = UITextAutocorrectionType.No
        text.textColor = UIColor.blackColor()
        text.keyboardAppearance = UIKeyboardAppearance.Dark
        return text
    }
    
    func makeLabel(title:String, frame:CGRect, size:CGFloat = 12, color:UIColor = UIColor.blackColor()) -> UILabel {
        var label:UILabel = UILabel()
        label.text = title
        label.frame = frame
        label.backgroundColor = UIColor.clearColor()
        label.font = UIFont(name: "Helvetica Neue", size: size)
        label.textAlignment = NSTextAlignment.Left
        label.textColor = color
        return label
    }
    
    func screen() -> CGRect {
        return UIScreen.mainScreen().bounds
    }
}