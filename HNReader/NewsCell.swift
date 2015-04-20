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
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)  {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        var title:UILabel = makeLabel("some news")
        self.addSubview(title)
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
    
    func makeLabel(title:String) -> UILabel {
        var label:UILabel = UILabel()
        label.text = title
        label.frame = CGRectMake(10, 10, 100, 40)
        label.backgroundColor = UIColor.whiteColor()
        label.font = UIFont(name: "Helvetica Neue", size: 12)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.blackColor()
        return label
    }
}