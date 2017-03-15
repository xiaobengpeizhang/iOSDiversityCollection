//
//  Extension.swift
//  iOSDiversityCollection
//
//  Created by YamonMac2 on 17/3/7.
//  Copyright © 2017年 xiaobengpeizhang. All rights reserved.
//

import Foundation
import UIKit

// MARK:- UIColor
extension UIColor
{
    //传入16进制
    class func colorBy16(rgbValue: Int) -> UIColor
    {
        return UIColor.init(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0, alpha: 1.0)
    }
    
    //传入16进制和Alpha
    class func colorBy16WithAlpha(rgbValue: Int, alpha: Int) -> UIColor
    {
        return UIColor.init(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0, alpha: ((CGFloat)(alpha & 0xFF)) / 255.0)
    }
    // 传入RGB
    class func colorByRGB(r: Int, g: Int, b: Int) -> UIColor
    {
        return UIColor.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
}

extension Double {
    // 按照需要保留的小数位数四舍五入，最低也会保留一位小数，如果自己1位小数 想保留两位小数并不会添加0
    func roundTo(place: Int) -> Double {
        // 1 要保留几位
        let discover: Double = pow(10.0, Double(place))
        // 2 乘以要保留的位数再四舍五入
        let result: Double = (self * discover).rounded() / discover
        
        return result
    }
}
