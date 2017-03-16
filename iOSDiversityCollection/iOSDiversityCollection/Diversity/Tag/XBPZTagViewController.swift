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
        taglist.backgroundColor = UIColor.white
        let names = ["经典咖啡豆11134", "经典咖啡豆2", "经典咖啡豆3", "经典咖啡豆431313131", "黄金曼特宁", "哥伦比亚Supremo慧兰", "危地马拉·安提瓜·茵赫特庄园", "肯尼亚·涅里·圆豆", "危地马拉 薇薇特 南果", "巴西 圣多斯", "经典咖啡豆3", "经典咖啡豆431313131"]
        
        for name in names {
            let newTag = taglist.addTag(name)
            newTag?.tagColor = UIColor.clear
            newTag?.textColor = UIColor.black
            newTag?.innerTagColor = UIColor.white
            newTag?.labelText.layer.borderColor = UIColor.black.cgColor
            newTag?.labelText.layer.borderWidth = 1.0
        }
        
    }
    
    func tapTag(_ tag: AMTagView!) {
        taglist.removeTag(tag)
    }

}
