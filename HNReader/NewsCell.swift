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
        
        if var let title = data["title"] as? NSString {
            var header:UILabel = makeLabel(title, frame: CGRectMake(0, 0, 200, 14))
            self.addSubview(header)
        }
        
        if var let url = data["url"] as? NSString {
            var website:UILabel = makeLabel(url, frame: CGRectMake(0, 14, 200, 20), size: 10, color: UIColor.grayColor())
            self.addSubview(website)
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
}