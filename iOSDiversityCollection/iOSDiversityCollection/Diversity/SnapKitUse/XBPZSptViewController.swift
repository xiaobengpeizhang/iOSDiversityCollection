//
//  XBPZSptViewController.swift
//  iOSDiversityCollection
//
//  Created by YamonMac2 on 17/3/17.
//  Copyright © 2017年 xiaobengpeizhang. All rights reserved.
//

import UIKit
import SnapKit

class XBPZSptViewController: UIViewController {
    var box = UIView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "SnapKit Constraints"
        self.view.backgroundColor = AARON_SWARTZ
        self.edgesForExtendedLayout = []
        // box view padding each 20
        self.view.addSubview(box)
        /*
        box.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
         */
        /*
        box.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(20, 20, 520, 520))
        }
         */
        box.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.lessThanOrEqualTo(400)
            make.width.greaterThanOrEqualTo(100)
            make.height.lessThanOrEqualTo(200)
            make.height.greaterThanOrEqualTo(50)
        }
        box.backgroundColor = UIColor.orange
        
        let box2 = UIView()
        self.view.addSubview(box2)
        // box2 inset box
        box2.snp.makeConstraints { (make) in
            make.edges.equalTo(box).inset(UIEdgeInsetsMake(20, 20, -20, -20))
        }
        box2.backgroundColor = UIColor.clear
        // box3 offset box1
        let box3 = UIView()
        self.view.addSubview(box3)
        box3.snp.makeConstraints { (make) in
            make.edges.equalTo(box).inset(UIEdgeInsetsMake(50, 100, -50, -100))
        }
        box3.backgroundColor = UIColor.red
        // box4 size  box (-10, +30)
        let box4 = UIView()
        self.view.addSubview(box4)
        box4.backgroundColor = UIColor.blue
        box4.snp.makeConstraints { (make) in
            make.center.equalTo(box)
            make.width.equalTo(box).offset(-10)
            make.height.equalTo(box).offset(30)
        }
        // box5 center offset box4
        let box5 = UIView()
        self.view.addSubview(box5)
        box5.snp.makeConstraints { (make) in
            make.size.equalTo(box4)
//            make.center.equalTo(box4).offset(50)    // offset (50, 50)
            make.centerX.equalTo(box4).offset(5)
            make.centerY.equalTo(box4).offset(10)
        }
        box5.backgroundColor = UIColor.brown
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("box - \(box.frame)")
    }


}
