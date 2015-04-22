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
    var webViewController:WebViewController! = nil
    var news:UITableView! = nil
    var refreshControl:UIRefreshControl! = nil
    var storyIds:[String] = []
    var stories:[NSDictionary] = []
    var selected:NSIndexPath! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webViewController = WebViewController()
        
        news = makeTable() as UITableView
        news.registerClass(UITableViewCell.self, forCellReuseIdentifier: "NewsCell")
        self.view.addSubview(news)

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "HNReader")

        news.addSubview(refreshControl)
        
        refresh()
    }
    
    func refresh() {
        (storyIds, stories) = ([], [])
        news.reloadData()
        fetchStories()
        refreshControl.endRefreshing()
    }
    
    func fetchStories() {
        let url = NSURL(string: "https://hacker-news.firebaseio.com/v0/topstories.json")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            var data:String = NSString(data: data, encoding: NSUTF8StringEncoding) as String
            data = data.substringWithRange(Range(start: advance(data.startIndex,1), end: advance(data.endIndex, -1)))
            self.storyIds = data.componentsSeparatedByString(",")
            self.updateStories()
        }
        
        task.resume()
    }
    
    func updateStories(start:Int = 0, end:Int = 30) {
        for index in start...end {
            self.fetchStory(index as Int, id: storyIds[index])
        }
    }
    
    func fetchStory(index:Int, id:String) {
        let url = NSURL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            if error == nil {
                var error:NSError? = nil
                var data:NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
                
                if data["type"] as? String == "story" {
                    self.stories.append(data)
                
                    dispatch_async(dispatch_get_main_queue()) {
                        self.news.reloadData()
                    }
                }
            }
        }
        
        task.resume()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("NewsCell") as? UITableViewCell
        
        if cell != nil {
            cell = NewsCell(style: UITableViewCellStyle.Default, reuseIdentifier: "NewsCell", data: stories[indexPath.row])
            cell!.backgroundColor = UIColor.clearColor()
            cell!.selectedBackgroundView = UIView()
        }

        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        webViewController.goToURL(NSURL(string: "about:blank")!)
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        cell.contentView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        selected = indexPath
        
        if let url = stories[indexPath.row]["url"] as? String {
            webViewController.goToURL(NSURL(string: url)!)
            navigationController?.pushViewController(webViewController, animated: true)
        }
        
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        
        if selected != nil {
            news.deselectRowAtIndexPath(selected, animated: false)
        }
    }
}
