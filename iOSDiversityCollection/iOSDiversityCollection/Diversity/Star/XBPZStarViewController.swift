//
//  XBPZStarViewController.swift
//  iOSDiversityCollection
//
//  Created by YamonMac2 on 17/4/18.
//  Copyright © 2017年 xiaobengpeizhang. All rights reserved.
//

import UIKit

class XBPZStarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "星星评分"
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(_ animated: Bool)
    {
        let rate = TQStarRatingView.init(frame: CGRect.init(x: 20, y: 100, width: 100, height: 20))
        self.view.addSubview(rate)
        rate.setScore(0.6, withAnimation: false)
    }

}
