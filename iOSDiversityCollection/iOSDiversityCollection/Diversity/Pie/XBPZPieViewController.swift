//
//  XBPZPieViewController.swift
//  iOSDiversityCollection
//
//  Created by YamonMac2 on 17/3/15.
//  Copyright © 2017年 xiaobengpeizhang. All rights reserved.
//

import UIKit
import Charts

class XBPZPieViewController: UIViewController, ChartViewDelegate {
    var pieChart: PieChartView!
    var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "饼状图"
        self.view.backgroundColor = AARON_SWARTZ
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 配置一个饼状图
        self.setBasePieChart()
        // 配置一个调节控件
        self.setSlider()
        
        //测试算法
        //let origin = [10, 30, 40, 20]
        //self.test(origin: origin, currentChangeIndex: 0, currentChangeValue: 41, lockIndex: [1, 3])
        //[20, 30, 40, 10]
    }

    func setBasePieChart() {
        self.pieChart = PieChartView.init(frame: CGRect.init(x: 0, y: 100, width: Double(self.view.bounds.width), height: 300))
        self.view.addSubview(pieChart)
        self.pieChart.backgroundColor = UIColor.white
        
        self.pieChart.drawSlicesUnderHoleEnabled = false
        self.pieChart.chartDescription?.enabled = false
        self.pieChart.drawHoleEnabled = true
        self.pieChart.rotationEnabled = true
        self.pieChart.highlightPerTapEnabled = true
        self.pieChart.drawEntryLabelsEnabled = false
        self.pieChart.delegate = self
        self.pieChart.setExtraOffsets(left: 0, top: 0, right: 0, bottom: 0)
        
        var lists: [PieChartDataEntry] = []
        for index in 0..<5 {
            let pieChartDataEntry = PieChartDataEntry.init(value: Double(index + 1), label: "testEntry\(index)")
            lists.append(pieChartDataEntry)
        }
        let pieChartDataSet = PieChartDataSet.init(values: lists, label: "testSet")
        let CHARTS_COLORS = [UIColor.colorBy16(rgbValue: 0x2db200), UIColor.colorBy16(rgbValue: 0xffa64d), UIColor.colorBy16(rgbValue: 0xdc73ff), UIColor.colorBy16(rgbValue: 0x7fb6ec), UIColor.colorBy16(rgbValue: 0x2693ff), UIColor.colorBy16(rgbValue: 0xff9999)];
        pieChartDataSet.colors = CHARTS_COLORS
        let data = PieChartData.init(dataSets: [pieChartDataSet])
        data.setValueTextColor(UIColor.white)
        data.setValueFont(UIFont.systemFont(ofSize: 11.0))
        self.pieChart.data = data
    }
    
    func setSlider() {
        self.slider = UISlider.init(frame: CGRect.init(x: 0, y: 450, width: self.view.bounds.width, height: 20))
        self.view.addSubview(self.slider)
        self.slider.addTarget(self, action: #selector(changeEntryValue), for: .valueChanged)
    }
    
    func changeEntryValue(slider: UISlider) {
        print("slider.value: \(slider.value)")
        print("slider.width: \(slider.bounds)")
        var waitTransfer: Double = Double(slider.value)
        let afterTransfer = waitTransfer.roundTo(place: 2)
        print("afterTransfer: \(afterTransfer)")
    }
    
    // MARK:- 设计一个算法。变化一个值，锁定若干值，均等变化若干
    func test(origin: [Int], currentChangeIndex: Int, currentChangeValue: Int, lockIndex: [Int]) -> [Int] {
        var origin = origin
        var currentChangeValue = currentChangeValue
        // 锁定的和
        var lockSum = 0
        for eachLockIndex in lockIndex {
            lockSum += origin[eachLockIndex]
        }
        print("锁定的和: \(lockSum)")
        // 剩余平均分配的数量
        let lastCount = origin.count - 1 - lockIndex.count
        let currentMax = (100 - lockSum - (lastCount) * 10)
        print("可调节的最大值为: \(currentMax)")
        if currentChangeValue > currentMax {
            print("最大值为: \(currentMax)")
            currentChangeValue = currentMax
        }
        // 剩余平均分配的值
        let lastEachValue = (100 - currentChangeValue - lockSum) / (lastCount)
        // 有可能有除不尽的情况
        let mayNotFit = (100 - currentChangeValue - lockSum) % (lastCount)
        print("平均分配的值: \(lastEachValue)")
        print("有可能除不尽的余数: \(mayNotFit)")
        var newArray = [Int]()
        for (value) in origin {
            newArray.append(lastEachValue)
        }
        newArray[currentChangeIndex] = currentChangeValue
        for eachLockIndex in lockIndex {
            newArray[eachLockIndex] = origin[eachLockIndex]
        }
        // 找出未锁定的Index的剩余值的最后一个
        var unlockLast: Int = -1
        for (index, value) in origin.enumerated() {
            if currentChangeIndex != index && !lockIndex.contains(index) {
                unlockLast = index
            }
        }
        if unlockLast > -1 {
            newArray[unlockLast] += mayNotFit
        }
        print("newArray: \(newArray)")
        return newArray
    }

}