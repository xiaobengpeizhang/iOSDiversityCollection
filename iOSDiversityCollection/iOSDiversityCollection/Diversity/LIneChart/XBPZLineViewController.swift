//
//  XBPZLineViewController.swift
//  iOSDiversityCollection
//
//  Created by YamonMac2 on 17/3/20.
//  Copyright © 2017年 xiaobengpeizhang. All rights reserved.
//

import UIKit
import Charts

// MARK:- 检查设备类型的类

enum DeviceType
{
    case iphone5
    case iphone6
    case iphone6p
    case none
}

class DeviceCheck
{
    static func check() -> DeviceType
    {
        let size = UIScreen.main.bounds.size
        switch size
        {
        case CGSize.init(width: 320, height: 568):
            return .iphone5
        case CGSize.init(width: 375, height: 667):
            return .iphone6
        case CGSize.init(width: 414, height: 736):
            return .iphone6p
        default:
            return .none
        }
    }
}

class XBPZLineViewController: UIViewController, ChartViewDelegate
{
    
    var lineChartView: LineChartView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = []
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        lineChartView = LineChartView.init(frame: CGRect.init(x: 20.0, y: 20.0, width: self.view.bounds.width - 40.0, height: 200))
        self.view.addSubview(lineChartView!)
        lineChartView?.backgroundColor = UIColor.brown
        let curves = [["Temp": 150, "AirFlow": 3500, "Time": 330], ["Temp": 170, "AirFlow": 4500, "Time": 120], ["Temp": 190, "AirFlow": 5000, "Time": 120], ["Temp": 210, "AirFlow": 5500, "Time": 120], ["Temp": 222, "AirFlow": 6000, "Time": 120]]
    }
}
