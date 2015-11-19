//
//  HRHTMLParser.swift
//  HackerReader
//
//  Created by Zhang Yan on 15/11/19.
//  Copyright © 2015年 Yeah. All rights reserved.
//

import UIKit
import Fuzi

class HRHTMLParser: NSObject {
    func parseHackerNewsForFeeds(html: String) -> NSArray {
        let array = NSMutableArray()
        do {
            let doc = try HTMLDocument(string: html)
            
            for item in doc.css("tr.athing td.title > a") {
                let feed = HRFeedModel()
                feed.title = item.stringValue
                feed.urlString = item["href"]
                array.addObject(feed)
            }
        
        } catch let error {
            print(error)
        }
        
        return array.copy() as! NSArray
    }
    
    func parseRubyChinaForFeeds(html: String) -> NSArray {
        let array = NSMutableArray()
        do {
            let doc = try HTMLDocument(string: html)
            
            for item in doc.css("div.topic") {
                let info = item.css(".infos .title > a").first
                let avatar = item.css(".avatar img").first
                let feed = HRFeedModel()
                feed.title = info!.stringValue
                feed.urlString = "https://ruby-china.org" + info!["href"]!
                feed.imageURLString = avatar!["src"]!
                array.addObject(feed)
            }
            
        } catch let error {
            print(error)
        }
        
        return array.copy() as! NSArray
    }
}
