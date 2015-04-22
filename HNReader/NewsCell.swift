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
    init(style: UITableViewCellStyle, reuseIdentifier: String!, data:NSDictionary) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if let title = data["title"] as? NSString {
            var titleLabel:UILabel = makeLabel(title, frame: CGRectMake(5, 2, screen().width, 14))
            self.addSubview(titleLabel)
        }
        
        if var url = data["url"] as? String {
            url = url.stringByReplacingOccurrencesOfString("https://", withString: "")
            url = url.stringByReplacingOccurrencesOfString("http://", withString: "")
            url = url.stringByReplacingOccurrencesOfString("www.", withString: "")
            
            if (url.rangeOfString("/") != nil) {
                url = url.substringToIndex(url.rangeOfString("/")!.startIndex)
            }
            
            var urlLabel:UILabel = makeLabel(url, frame: CGRectMake(5, 11, screen().width, 20), size: 10, color: UIColor.grayColor())
            self.addSubview(urlLabel)
        }
        
        if let score = data["score"] as? Double {
            if let comments = data["descendants"] as? Int {
                if let epoch = data["time"] as? Double {
                    let date = NSDate(timeIntervalSince1970: epoch)
                    let formatter = NSDateFormatter()
                    formatter.dateStyle = .MediumStyle
                    formatter.timeStyle = .ShortStyle
                    let dateTime = formatter.stringFromDate(date)

                    var scoreLabel:UILabel = makeLabel("\(score) points and \(comments) comments | \(dateTime)", frame: CGRectMake(5, 26, screen().width, 10), size: 8, color: UIColor.grayColor())
                    self.addSubview(scoreLabel)
                }
            }
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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