//
//  LNButtonsView.swift
//  Carro
//
//  Created by MAC on 2020/12/3.
//

import UIKit

class LNButtonsView: UIView {

    private var datas = [String]()
    private var target:Target?
    init(frame:CGRect, datas:[String], target:Target) {
        super.init(frame: frame)
        
        self.datas = datas
        self.target = target
        configSubviews()
    }
    
    private func configSubviews() {
        
        let kWdith:CGFloat = self.ln_height
        let kSpace = (self.ln_width-kWdith*CGFloat(self.datas.count))/CGFloat(self.datas.count-1)
        
        for index in 0..<self.datas.count {
            let button = UIButton.init(frame: CGRect.init(x: (kWdith+kSpace)*CGFloat(index), y: 0, width: kWdith, height: self.ln_height))
            button.setTitle(self.datas[index], for: .normal)
            button.setImage(UIImage.init(named: self.datas[index]), for: .normal)
            button.titleLabel?.font = UIFont.init(name: "Futura", size: 13)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.minimumScaleFactor = 0.8
            button.setTitleColor(.white, for: .normal)
            button.layout(style: .top, space: 8)
            button.backgroundColor = color(self.datas[index])
            button.ln_cornerRadius = 10
            button.addTarget(self, action: #selector(didSelectOption(sender:)), for: .touchUpInside)
            button.tag = 100+index
            self.addSubview(button)
        }
    }
    
    @objc func didSelectOption(sender:UIButton) {
        target?.perform(object: "\(sender.tag)")
    }
    
    private func color(_ name:String) -> UIColor {
        switch name {
        case "Get Help":
            return UIColor.mainColor
        case "Cancel Sub":
            return UIColor.init(red: 207, green: 96, blue: 94)
        default:
            return UIColor.init(red: 97, green: 126, blue: 194)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}