//
//  AppToos.swift
//  Carro
//
//  Created by MAC on 2020/12/2.
//

import UIKit

class AppTools: NSObject {
    
    static func jsonDataFromResource(_ suffix:String = "") -> [String:Any] {
        
        guard let path = Bundle.main.path(forResource: "resourceData"+suffix, ofType: "json"),
              let jsonString = try? String.init(contentsOfFile: path, encoding: .utf8) else {
            return [:]
        }
        
        if let data = jsonString.data(using: .utf8),
           let dict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]  {
            return dict
        }
        
        return [:]
    }
    
    
    static func calculateRowHeight(_ label:UILabel) -> CGFloat {
        label.sizeThatFits(CGSize.init(width: label.ln_width, height: 200)).height
    }

    
    static func conversionOfDigital(_ number: String) -> String {
                
        let strings = number.components(separatedBy: ".")
        
        var value = strings.first ?? ""
        var float = ""
        if strings.count > 1 {
            float = strings.last ?? ""
        }
        
        if value.count <= 3 {
            return number
        }

        let count = value.count/3
        let left = value.count%3
        
        for index in 0..<count {
            if index == 0 && left != 0 {
                let index = value.index(value.startIndex, offsetBy: left)
                value.insert(",", at: index)
            }else{
                let idx = left == 0 ? (index == 0 ? 1:index+1):index
                let index = value.index(value.startIndex, offsetBy: (idx)*3+index+left)
                value.insert(",", at: index)
            }
        }
        if value.hasSuffix(",") {
            value.remove(at: value.index(value.endIndex, offsetBy: -1))
        }
        
        if float.count > 0 {
            return value + "." + float
        }else{
            return value
        }
    }

}
