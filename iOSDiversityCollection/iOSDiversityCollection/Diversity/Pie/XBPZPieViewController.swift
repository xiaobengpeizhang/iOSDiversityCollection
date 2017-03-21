//
//  XBPZPieViewController.swift
//  iOSDiversityCollection
//
//  Created by YamonMac2 on 17/3/15.
//  Copyright © 2017年 xiaobengpeizhang. All rights reserved.
//

import UIKit
import Charts

let AMOUNT = 100    // amount is 100
let MINNT = 10  //  single min count is 10

class XBPZPieViewController: UIViewController, ChartViewDelegate {
    var pieChart: PieChartView!
    var slider: UISlider!
    var lists: [PieChartDataEntry] = [PieChartDataEntry]()
    var currentResult: [Int] = []
    var currentSelectedIndex = 0
    var lockArray: [Int] = [] // to save what is lock
    let beanNames = ["黄金曼特宁", "哥伦比亚 Supremo 慧兰", "危地马拉·安提瓜·茵赫特庄园", "肯尼亚·涅里·圆豆", "危地马拉 薇薇特 南果", "巴西 圣多斯"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "饼状图"
        self.view.backgroundColor = AARON_SWARTZ
        self.arrangeBeanRatio(num: 6)
    }
    
    func arrangeBeanRatio(num: Int)
    {
        let mean = AMOUNT / num
        let reminder = AMOUNT % num
        for index in 0 ..< num {
            if (index == num - 1) {
                self.currentResult.append(mean + reminder)
            }
            else {
                self.currentResult.append(mean)
            }
        }
        print("current ratio - \(self.currentResult)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 配置一个饼状图
        self.setBasePieChart(list: self.currentResult)
        // 配置一个调节控件
        self.setSlider()
        // 配置6个豆子的按钮
        self.setupBeanButton()
    }
    
    func setupBeanButton() {
        let scroll = UIScrollView.init(frame: CGRect.init(x: 0, y: 420 + 10, width: self.view.bounds.width, height: self.view.bounds.height - 440))
        for (index, name) in self.beanNames.enumerated() {
            let button = UIButton.init(type: .custom)
            button.setTitle(name, for: .normal)
            button.defaultStyle()
            button.addAwesomeIcon(FAIconUnlock, beforeTitle: false)
            button.addTarget(self, action: #selector(lock), for: .touchUpInside)
            button.frame = CGRect.init(x: 20, y: index * 30 + 5 , width: 100, height: 30)
            scroll.addSubview(button)
            button.setup()
            button.tag = 10 + index
        }
        scroll.contentSize = CGSize.init(width: self.view.bounds.width, height: 30.0 * (CGFloat)(self.beanNames.count))
        self.view.addSubview(scroll)
    }
    
    func lock(sender: UIButton)
    {
        print("lock")
        self.buttonChangeLock(sender: sender)
    }
    
    func buttonChangeLock(sender: UIButton)
    {
        sender.isSelected = !sender.isSelected
        if (sender.isSelected) {
            sender.removeAwesomeIcon(FAIconUnlock, beforeTitle: false)
            sender.addAwesomeIcon(FAIconLock, beforeTitle: false)
        }
        else {
            sender.removeAwesomeIcon(FAIconLock, beforeTitle: false)
            sender.addAwesomeIcon(FAIconUnlock, beforeTitle: false)
        }
        self.lockManag(sender: sender)
        print("show lock array - \(lockArray)")
    }
    
    func lockManag(sender: UIButton)
    {
        let lockIndex = sender.tag - 10
        if sender.isSelected {
            // is lock
            if (!lockArray.contains(lockIndex)) {
                lockArray.append(lockIndex)
            }
        }
        else {
            if lockArray.contains(lockIndex) {
                if let index = lockArray.index(of: lockIndex) {
                    lockArray.remove(at: index)
                }
            }
        }
    }

    func setBasePieChart(list: [Int]) {
        // 清空self.lists 
        self.lists.removeAll()
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
        
        for (index,value) in list.enumerated() {
            let pieChartDataEntry = PieChartDataEntry.init(value: Double(value), label: self.beanNames[index])
            self.lists.append(pieChartDataEntry)
        }
        let pieChartDataSet = PieChartDataSet.init(values: lists, label: "生豆比率")
        let CHARTS_COLORS = [UIColor.colorBy16(rgbValue: 0x2db200), UIColor.colorBy16(rgbValue: 0xffa64d), UIColor.colorBy16(rgbValue: 0xdc73ff), UIColor.colorBy16(rgbValue: 0x7fb6ec), UIColor.colorBy16(rgbValue: 0x2693ff), UIColor.colorBy16(rgbValue: 0xff9999)];
        pieChartDataSet.colors = CHARTS_COLORS
        let data = PieChartData.init(dataSets: [pieChartDataSet])
        data.setValueTextColor(UIColor.white)
        data.setValueFont(UIFont.systemFont(ofSize: 11.0))
        self.pieChart.data = data
    }
    
    func setSlider() {
        self.slider = UISlider.init(frame: CGRect.init(x: 20, y: 410, width: self.view.bounds.width - 40, height: 20))
        self.view.addSubview(self.slider)
        self.slider.addTarget(self, action: #selector(changeEntryValue), for: .valueChanged)
        self.slider.minimumValue = 0.1
    }
    
    func changeEntryValue(slider: UISlider) {
        print("slider.value: \(slider.value)")
        print("slider.width: \(slider.bounds)")
        var waitTransfer: Double = Double(slider.value)
        let afterTransfer = waitTransfer.roundTo(place: 2)
        print("afterTransfer: \(afterTransfer)")
        let afterTransferInt = afterTransfer * 100
        print("afterTransferInt: \(afterTransferInt)")
        print("选择的当前Index: \(self.currentSelectedIndex)")
        let afterChangeList = self.test(origin: self.currentResult, currentChangeIndex: self.currentSelectedIndex, currentChangeValue: Int(afterTransferInt), lockIndex: self.lockArray)
        self.setBasePieChart(list: afterChangeList)
    }
    
    // MARK:- 设计一个算法。变化一个值，锁定若干值，均等变化若干
    func test(origin: [Int], currentChangeIndex: Int, currentChangeValue: Int, lockIndex: [Int]) -> [Int] {
        var origin = origin
        var currentChangeValue = currentChangeValue
        // 锁定的和
        var lockSum = 0
        for eachLockIndex in lockIndex {
            if eachLockIndex != currentChangeIndex {
                lockSum += origin[eachLockIndex]
            }
        }
        print("锁定的和: \(lockSum)")
        // 剩余平均分配的数量
        var currentIsLock = 0
        if !lockIndex.contains(currentChangeIndex) {
            currentIsLock = 1
        }
        let lastCount = origin.count - currentIsLock - lockIndex.count  // 可能为0
        if lastCount == 0 {
            // 无法调节。
            return origin
        }
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
        for eachLockIndex in lockIndex {
            newArray[eachLockIndex] = origin[eachLockIndex]
        }
        newArray[currentChangeIndex] = currentChangeValue
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
        self.currentResult = newArray
        return newArray
    }
    
    // MARK:- 饼状图代理
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let pieSelectedValue = entry as! PieChartDataEntry
        print("pieSelectedValue.label: \(pieSelectedValue.label)")
        let name = pieSelectedValue.label!
        let index = self.beanNames.index(of: name)
        print("当前选中的是: \(index)")
        self.currentSelectedIndex = index!
    }

}
