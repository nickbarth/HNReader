//
//  NewsViewController.swift
//  HNReader
//
//  Created by Nick on 4/19/15.
//  Copyright (c) 2015 Nick. All rights reserved.
//

import Foundation
import UIKit

class NewsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    var newsTable:UITableView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTable = makeTable() as UITableView
        newsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "NewsCell")
        
        self.view.addSubview(newsTable)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("NewsCell") as? UITableViewCell
        
        if (cell != nil) {
            cell = NewsCell(style: UITableViewCellStyle.Default, reuseIdentifier: "NewsCell")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.selectedBackgroundView = UIView()
        }

        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        newsTable.reloadData()
    }
    
    func makeTable() -> UITableView {
        let table = UITableView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), style: UITableViewStyle.Plain)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor.whiteColor()
        table.backgroundView = nil
        table.separatorStyle = UITableViewCellSeparatorStyle.None
        table.bounces = true
        table.showsHorizontalScrollIndicator = false
        table.showsVerticalScrollIndicator = false
        table.keyboardDismissMode = .OnDrag
        return table
    }
    
}
