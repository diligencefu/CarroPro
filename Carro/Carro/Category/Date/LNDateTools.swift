//
//  LNDateTools.swift
//  Carro
//
//  Created by MAC on 2020/12/3.
//

import UIKit

//DateFormatter的创建会比较消耗性能，将默认的dateFormat写成单例减少不必要开支
fileprivate class LNStaticDateFormatter {
    static var `default` : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = .init(identifier: "Singapore")
        return formatter
    }()
}

extension Date {
        
    public func toString(dateFormat:String?=nil) -> String {
        
        let formatter : DateFormatter
        if let df = dateFormat, df.count > 0 {
            formatter = DateFormatter.init()
            formatter.dateFormat = df
            formatter.locale = .init(identifier: "Singapore")
            formatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        }else{
            formatter = LNStaticDateFormatter.default
        }
        return formatter.string(from: self)
    }
}
