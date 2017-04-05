//
//  ScrollPageViewController.swift
//  iOSDiversityCollection
//
//  Created by YamonMac2 on 17/4/5.
//  Copyright © 2017年 xiaobengpeizhang. All rights reserved.
//

import UIKit

class ScrollPageViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Scroll嵌套Scroll"
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = []
        self.layout()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    func layout()
    {
        let allScroll = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        allScroll.contentSize = CGSize.init(width: self.view.bounds.width, height: self.view.bounds.height * 2)
        allScroll.isPagingEnabled = true
        allScroll.backgroundColor = UIColor.green
        self.view.addSubview(allScroll)

        let scroll1 = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        scroll1.backgroundColor = UIColor.red
        scroll1.isPagingEnabled = false
        scroll1.contentSize = CGSize.init(width: self.view.bounds.width, height: self.view.bounds.height * 3)
        allScroll.addSubview(scroll1)

        
        let scroll2 = UIScrollView.init(frame: CGRect.init(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: self.view.bounds.height))
        scroll2.backgroundColor = UIColor.blue
        scroll2.isPagingEnabled = false
        scroll2.contentSize = CGSize.init(width: self.view.bounds.width, height: self.view.bounds.height * 2)
        allScroll.addSubview(scroll2)
    }
    
}
