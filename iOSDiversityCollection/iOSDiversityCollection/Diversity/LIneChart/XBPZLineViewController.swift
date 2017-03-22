//
//  XBPZLineViewController.swift
//  iOSDiversityCollection
//
//  Created by YamonMac2 on 17/3/20.
//  Copyright © 2017年 xiaobengpeizhang. All rights reserved.
//





/*
 1. 需要知道点击的是哪条线
 2. 需要知道点击的是第几个点
 3. 需要确定这个点可以调节的最大值，最小值
 */

import UIKit
import Charts


/**
 * 图表调节常量
 */
let tempMin = 90    //温度最小值
let tempMax = 230   //温度最大值
let cfmMin = 3000     //风量最小值
let cfmMax = 10000    //风量最大值
let maxTime = 1080  //总时长
let timeOneMin = 180    //第一点时间最小值
let timeOneMax = 420    //第一点时间最大值
let timeOtherMin = 90   //其他时间最小值
let timeOtherMax = 200  //其他时间最大值
let timeEndMin = 20     //最后一点时间最小值
let timeEndMax = 120    //最后一点时间最大值
let canChange = false   //能否调节

let LINE_COLORS_LEFT_YAXIS = UIColor.colorBy16(rgbValue: 0x5b9bd5)   // 线形图 左边y轴颜色
let LINE_COLORS_RIGHT_YXAXIS = UIColor.colorBy16(rgbValue: 0xed7d32)   // 线形图 右边y轴颜色


enum Line {
    case TempLine
    case AirLine
    case None
}

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
    var currentEntry: ChartDataEntry!
    var slider: UISlider!
    var selectedLine: Line = Line.None  // 标记 当前点击的是哪条线
    var selectPoint: Int = -1
    
    var justForIndex: [Double] = [] // 专门用来返回当前是第几个Point的数组
    var airValue: [Int] = []    // 保存风量的值
    var tempValue: [Int] = []   // 保存温度的值
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = []
        self.slider = UISlider.init(frame: CGRect.init(x: 20, y: 300, width: self.view.bounds.width - 40, height: 20))
        self.view.addSubview(self.slider)
        self.slider.addTarget(self, action: #selector(changeValue), for: .valueChanged)
    }
    
    func changeValue(slider: UISlider)
    {
        let value = slider.value
        var result = value * (170 - 90) + 91
        if result >= 170 {
            result = 169
        }
        print("result: \(result)")
        let tempDataSet = lineChartView?.data?.dataSets[0] as! LineChartDataSet
        let oneDataEntry = tempDataSet.values[1]
        print("oneDataEntry: \(oneDataEntry)")
        let xPoint = oneDataEntry.x
        let newDataEntry = ChartDataEntry.init(x: xPoint, y: Double(result))
        print("newDataEntry: \(newDataEntry)")
        tempDataSet.values[1] = newDataEntry
        print("tempDataSetValues: \(tempDataSet.values)")
        lineChartView?.data?.dataSets[0].notifyDataSetChanged()
        lineChartView?.data?.notifyDataChanged()
        lineChartView?.notifyDataSetChanged()
    }
    
    func refreshData()
    {
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        
        super.viewDidAppear(animated)
        lineChartView = LineChartView.init(frame: CGRect.init(x: 20.0, y: 20.0, width: self.view.bounds.width - 40.0, height: 200))
        self.view.addSubview(lineChartView!)
        lineChartView?.chartDescription?.enabled = false
        lineChartView?.backgroundColor = UIColor.white
        lineChartView?.delegate = self
        lineChartView?.dragEnabled = false
        lineChartView?.setScaleEnabled(false)
        lineChartView?.pinchZoomEnabled = false
        lineChartView?.drawGridBackgroundEnabled = false
        lineChartView?.highlightPerTapEnabled = true
        let xAxis = lineChartView?.xAxis
        xAxis?.labelPosition = .bottom
        xAxis?.drawLabelsEnabled = true
        xAxis?.drawGridLinesEnabled = true
        xAxis?.drawAxisLineEnabled = true
        // x轴的字体
        xAxis?.labelFont = UIFont.italicSystemFont(ofSize: 11)
        xAxis?.labelTextColor = UIColor.colorBy16(rgbValue: 0x7a7a7a)
        xAxis?.yOffset = 13.0
        let formatter = IndexAxisValueFormatter.init(values: ["00:00", "03:12", "06:24", "09:36", "12:48", "16:00", "19:12"])
        xAxis?.valueFormatter = formatter
        xAxis?.granularity = 1
        // y轴是否显示
        let leftY = lineChartView?.leftAxis
        leftY?.drawAxisLineEnabled = true
        let rightY = lineChartView?.rightAxis
        rightY?.drawAxisLineEnabled = true
        
        // y轴是否显示labels
        leftY?.drawLabelsEnabled = true
        rightY?.drawLabelsEnabled = true
        
        // y轴的字体离线的位置
        leftY?.xOffset = 8
        rightY?.xOffset = 20
        
        // y轴的范围
        leftY?.axisMaximum = 10000
        leftY?.axisMinimum = 0
        rightY?.axisMinimum = 0
        rightY?.axisMaximum = 250
        
        // y轴的字体
        leftY?.labelFont = UIFont.systemFont(ofSize: 10.0)
        leftY?.labelTextColor = UIColor.colorBy16(rgbValue: 0x5b9bd5)
        rightY?.labelFont = UIFont.systemFont(ofSize: 10.0)
        rightY?.labelTextColor = UIColor.colorBy16(rgbValue: 0xed7d32)
        
        // y轴是否有网格线
        leftY?.drawGridLinesEnabled = false
        rightY?.drawGridLinesEnabled = false
        
        // y轴是否划0线
        leftY?.drawZeroLineEnabled = true
        rightY?.drawZeroLineEnabled = true
        
        // y轴两个同坐标的点是否做区别
        leftY?.granularityEnabled = true
        rightY?.granularityEnabled = true
        let curves = [["Temp": 150, "AirFlow": 3500, "Time": 330], ["Temp": 170, "AirFlow": 4500, "Time": 120], ["Temp": 190, "AirFlow": 5000, "Time": 120], ["Temp": 210, "AirFlow": 5500, "Time": 120], ["Temp": 222, "AirFlow": 6000, "Time": 120]]
        var airFlowEntries = [ChartDataEntry]()
        var tempEntries = [ChartDataEntry]()
        var initialTime = 0
        for curve in curves {
            let temp = curve["Temp"]
            let airFlow = curve["AirFlow"]
            self.airValue.append(airFlow!)
            self.tempValue.append(temp!)
            
            initialTime += (curve["Time"])!
            let xPoint = (Double)(initialTime) / 192.0
            
            self.justForIndex.append(xPoint)
            
            let tempEntry = ChartDataEntry.init(x: xPoint, y: Double(temp!), data: Line.TempLine  as AnyObject?)
            let airFlowEntry = ChartDataEntry.init(x: xPoint, y: Double(airFlow!), data: Line.AirLine as AnyObject?)
            airFlowEntries.append(airFlowEntry)
            tempEntries.append(tempEntry)
        }
        
        airFlowEntries.insert(ChartDataEntry.init(x: 0, y: 0, data: Line.AirLine as AnyObject?), at: 0)
        tempEntries.insert(ChartDataEntry.init(x: 0, y: 90, data: Line.TempLine as AnyObject?), at: 0)
        self.justForIndex.insert(0, at: 0)
        self.airValue.insert(0, at: 0)
        self.tempValue.insert(90, at: 0)
        print("justForIndex: \(self.justForIndex)")
        
        let airFlowDataSet = LineChartDataSet.init(values: airFlowEntries, label: "风量")
        let tempDataSet = LineChartDataSet.init(values: tempEntries, label: "温度")
        airFlowDataSet.axisDependency = .left
        tempDataSet.axisDependency = .right
        airFlowDataSet.valueFont = UIFont.systemFont(ofSize: 11.0)
        tempDataSet.valueFont = UIFont.systemFont(ofSize: 11.0)
        airFlowDataSet.valueTextColor = LINE_COLORS_LEFT_YAXIS
        tempDataSet.valueTextColor = LINE_COLORS_RIGHT_YXAXIS
        airFlowDataSet.setColor(LINE_COLORS_LEFT_YAXIS)
        tempDataSet.setColor(LINE_COLORS_RIGHT_YXAXIS)
        airFlowDataSet.circleRadius = 2.0
        tempDataSet.circleRadius = 2.0
        airFlowDataSet.setCircleColor(LINE_COLORS_LEFT_YAXIS)
        airFlowDataSet.circleHoleColor = LINE_COLORS_LEFT_YAXIS
        tempDataSet.setCircleColor(LINE_COLORS_RIGHT_YXAXIS)
        tempDataSet.circleHoleColor = LINE_COLORS_RIGHT_YXAXIS
        let data = LineChartData.init(dataSets: [tempDataSet, airFlowDataSet])
        lineChartView?.data = data
    }

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight)
    {
        let line = entry.data as! Line
        self.selectedLine = line
        print("selectedLine: \(self.selectedLine)")
        print("entry.x: \(entry.x)")
        
        self.getPointIndex(xPoint: entry.x)
        self.getMaxMin()
    }
    
    //告诉我当前点击的是第几个点
    func getPointIndex(xPoint: Double) -> Int {
        let index = self.justForIndex.index(of: xPoint)
        self.selectPoint = index!
        print("index: \(index)")
        return index!
    }
    
    //返回这个点的调节值的纵坐标范围 元祖0为最小值  元祖1为最大值
    //原则是第0个点不可调，最后一个点和倒数第二个点可以相等。
    //
    func getMaxMin() {
        var min = 0
        var max = 0
        switch self.selectedLine {
        case .AirLine:
                // 1第几个点。
            if self.selectPoint == 0 {
                
            }
            else if self.selectPoint == 1 {
                // 第1个点
                min = cfmMin
                max = self.airValue[self.selectPoint + 1] - 100
            }
            else if self.selectPoint == 5 {
                max = cfmMax
                min = self.airValue[self.selectPoint - 1] + 100
            }
            else {
                // 中间的点
                min = self.airValue[self.selectPoint - 1] + 100
                max = self.airValue[self.selectPoint + 1] - 100
            }
            
        case .TempLine:
                // 1第几个点。 第1个点最小值90 第5个点最大值230
            if self.selectPoint == 0 {
                // 第0个点
            }
            else if self.selectPoint == 1 {
                // 第1个点
                min = tempMin
                max = self.tempValue[self.selectPoint + 1] - 1
                
            }
            else if self.selectPoint == 5 {
                // 最后一个点
                max = tempMax
                min = self.tempValue[self.selectPoint - 1]
            }
            else {
                // 中间的点
                min = self.tempValue[self.selectPoint - 1] + 1
                if self.selectPoint == 4 {
                    max = self.tempValue[self.selectPoint + 1]
                }
                else {
                    max = self.tempValue[self.selectPoint + 1] - 1
                }
            }
        default:
            break
        }
        print("max: \(max) min: \(min)")
    }
}
