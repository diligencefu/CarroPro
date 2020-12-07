//
//  LNFormView.swift
//  Carro
//
//  Created by MAC on 2020/12/3.
//

import UIKit

class LNFormView: UIView {
    
    public var datas = [[String:Any]]() {
        didSet {
            configSubviews()
        }
    }
    
    init(frame:CGRect, datas:[[String:Any]]? = nil) {
        super.init(frame: frame)
        if let datas = datas {
            self.datas = datas
        }
    }
    
    
    private func configSubviews() {
        
        _ = self.subviews.map { (view) in
            view.removeFromSuperview()
        }
        
        let kHeight:CGFloat = 20
        let kSpace:CGFloat = 16
        let kLineH:CGFloat = 1
        let kLeft:CGFloat = 16
        var kTop:CGFloat = kSpace
        let kWidth:CGFloat = self.ln_width
        
        for index in 0..<datas.count {
            
            //I'm going to figure out where the content is, because it's height not going to be fixed
            let valueView = UIView.init(frame: CGRect.init(x: kWidth/5*3, y: kTop, width: kWidth/5*2-kLeft, height: kHeight))
            self.addSubview(valueView)
            
            //Get label
            func addLabel(rect:CGRect) -> UILabel {
                let value = UILabel.init(frame: rect)
                value.font = UIFont.systemFont(ofSize: 16)
                value.textColor = UIColor.mainColor
                value.adjustsFontSizeToFitWidth = true
                value.minimumScaleFactor = 0.8
                valueView.addSubview(value)
                return value
            }
            
            //Drivers or not, we need more height
            if let drivers = datas[index]["value"] as? [Driver] {
                
                for idx in 0..<drivers.count {
                    let driver = addLabel(rect: CGRect.init(x: 0, y: CGFloat(idx)*kHeight, width: valueView.ln_width, height: kHeight))
                    driver.text = drivers[idx].name
                }
                valueView.ln_height = kHeight*CGFloat(drivers.count)
            }else{
                let value = addLabel(rect: CGRect.init(x: 0, y: 0, width: valueView.ln_width, height: kHeight))
                if let valueText = datas[index]["value"] as? String {
                    value.text = "$ "+valueText
                }
                valueView.ln_height = kHeight
            }
            
            //The reserved clearance
            kTop = valueView.ln_bottom + kSpace

            let title = UILabel.init(frame: CGRect.init(x: kLeft, y: valueView.ln_y, width: kWidth/5*3-kLeft, height: valueView.ln_height))
            title.font = UIFont.systemFont(ofSize: 16)
            if let titleText = datas[index]["title"] as? String {
                title.text = titleText
            }
            title.textColor = UIColor.black
            self.addSubview(title)
                        
            if index == self.datas.count-1 {
                break
            }
            let line = UIView.init(frame: CGRect.init(x: 0, y: kTop, width: self.ln_width, height: kLineH))
            line.backgroundColor = UIColor.init(gary: 236)
            self.addSubview(line)
            
            //For next
            kTop = line.ln_bottom + kSpace
        }
        
        //Recalculation of height
        self.ln_height = kTop
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
