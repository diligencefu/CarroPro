//
//  LNComponentViews.swift
//  Carro
//
//  Created by MAC on 2020/12/2.
//

import UIKit
import SnapKit

class LNCenterView: UIView {
    
    private var isDistance = false
    private var value = String()

    private let number = UILabel.init()
    
    init(frame:CGRect, isDistance:Bool, value:String? = nil) {
        super.init(frame: frame)
        
        self.isDistance = isDistance
        
        if let value = value {
            self.value = value
        }
        
        configSubviews()
    }
    
    private func configSubviews() {
        
        let topView = UIView.init()
        self.addSubview(topView)
        
        number.textAlignment = .center
        number.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        number.text = AppTools.conversionOfDigital(value)
        number.textColor = UIColor.mainColor
        topView.addSubview(number)
        
        let unit = UILabel.init()
        unit.textAlignment = .center
        unit.font = UIFont.systemFont(ofSize: 16)
        unit.text = isDistance ? "km":"$"
        unit.textColor = UIColor.mainColor
        topView.addSubview(unit)
        
        topView.snp.makeConstraints { (ls) in
            ls.centerX.equalToSuperview()
            ls.centerY.equalToSuperview().offset(-10)
        }

        number.snp.makeConstraints { (ls) in
            ls.bottom.top.equalToSuperview()
            if !isDistance {
                ls.right.equalToSuperview()
            }else{
                ls.left.equalToSuperview()
            }
            ls.width.greaterThanOrEqualTo(0)
        }

        unit.snp.makeConstraints { (ls) in
            if isDistance {
                ls.right.equalToSuperview()
                ls.left.equalTo(number.snp.right).offset(2)
            }else{
                ls.left.equalToSuperview()
                ls.right.equalTo(number.snp.left).offset(-2)
            }
            ls.bottom.equalTo(number.snp.bottom).offset(-3)
        }
        
        let descLabel = UILabel.init()
        descLabel.textAlignment = .center
        descLabel.font = UIFont.boldSystemFont(ofSize: 14)
        descLabel.text = isDistance ? "Driven this month".local:"Usage due this month".local
        topView.addSubview(descLabel)
        
        descLabel.snp.makeConstraints { (ls) in
            ls.centerY.equalTo(topView).offset(36)
            ls.centerX.equalToSuperview()
        }
    }
    
    public func setValue(_ value:String) {
        number.text = value
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
