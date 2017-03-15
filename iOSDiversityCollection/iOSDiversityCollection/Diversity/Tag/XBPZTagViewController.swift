//
//  XBPZTagViewController.swift
//  iOSDiversityCollection
//
//  Created by YamonMac2 on 17/3/13.
//  Copyright © 2017年 xiaobengpeizhang. All rights reserved.
//

import UIKit

class XBPZTagViewController: UIViewController, AMTagListDelegate {

    var taglist: AMTagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "标签列表"
        self.view.backgroundColor = AARON_SWARTZ
//        self.edgesForExtendedLayout = []
    }
    
    override func viewDidAppear(_ animated: Bool) {
        taglist = AMTagListView.init(frame: CGRect.init(x: 0, y: 100, width: 320, height: 200))
        self.view.addSubview(taglist)
        taglist.tagListDelegate = self
        taglist.backgroundColor = UIColor.gray
        let one = taglist.addTag("经典咖啡豆11134")
        let two = taglist.addTag("经典咖啡豆2")
        let three = taglist.addTag("经典咖啡豆3")
        let four = taglist.addTag("经典咖啡豆431313131")
        
        let five = taglist.addTag("黄金曼特宁")
        let six = taglist.addTag("哥伦比亚Supremo慧兰")
        let seven = taglist.addTag("危地马拉·安提瓜·茵赫特庄园")
        let eight = taglist.addTag("肯尼亚·涅里·圆豆")
        
        let nine = taglist.addTag("危地马拉 薇薇特 南果")
        let ten = taglist.addTag("巴西 圣多斯")
        let eleven = taglist.addTag("经典咖啡豆3")
        let twlve = taglist.addTag("经典咖啡豆431313131")
        
        one?.tagColor = UIColor.clear
        one?.textColor = UIColor.black
        one?.innerTagColor = UIColor.white
        
        two?.tagColor = UIColor.clear
        two?.textColor = UIColor.black
        two?.innerTagColor = UIColor.white
        
        three?.tagColor = UIColor.clear
        three?.textColor = UIColor.black
        three?.innerTagColor = UIColor.white
        
        four?.tagColor = UIColor.clear
        four?.textColor = UIColor.black
        four?.innerTagColor = UIColor.white
        
        five?.tagColor = UIColor.clear
        five?.textColor = UIColor.black
        five?.innerTagColor = UIColor.white
        
        six?.tagColor = UIColor.clear
        six?.textColor = UIColor.black
        six?.innerTagColor = UIColor.white
        
        seven?.tagColor = UIColor.clear
        seven?.textColor = UIColor.black
        seven?.innerTagColor = UIColor.white
        
        eight?.tagColor = UIColor.clear
        eight?.textColor = UIColor.black
        eight?.innerTagColor = UIColor.white
        
        nine?.tagColor = UIColor.clear
        nine?.textColor = UIColor.black
        nine?.innerTagColor = UIColor.white
        
        ten?.tagColor = UIColor.clear
        ten?.textColor = UIColor.black
        ten?.innerTagColor = UIColor.white
        
        eleven?.tagColor = UIColor.clear
        eleven?.textColor = UIColor.black
        eleven?.innerTagColor = UIColor.white
        
        twlve?.tagColor = UIColor.clear
        twlve?.textColor = UIColor.black
        twlve?.innerTagColor = UIColor.white
        
        
        
    }
    
    func tapTag(_ tag: AMTagView!) {
        taglist.removeTag(tag)
    }

}
