//
//  LNCarManagerCell.swift
//  Carro
//
//  Created by MAC on 2020/12/7.
//

import UIKit
import LNTools_fyh

class LNCarManagerCell: LNCarCell {

    lazy var buttonsView: LNButtonsView = {
        let buttons = LNButtonsView.init(frame: CGRect.init(), target: Target.init(target: self, selector: #selector(didChooseOption(index:))))
        return buttons
    }()
    
    
    override func layoutSubviews() {
        contentView.addSubview(buttonsView)
    }
    
    
    //set values
    public override var resource: LNCarInfoModel? {
        
        didSet {
            guard let resource = resource else {return}

            //Manager your subscription,  options
            var titles = ["Get Help".local, "View Docs".local, "Payments".local, "Cancel Sub".local]
            if !resource.isSingapore {
                titles.remove(at: 1)
            }
            
            let kLeftSpace:CGFloat = 20
            //The distance between the two views above and below
            let kTopSpace:CGFloat = 12
            var kTop:CGFloat = kTopSpace
            let kNormalWidth = UIScreen.width - kLeftSpace*2
            
            buttonsView.frame = CGRect.init(x: kLeftSpace*1.5, y: kTop, width: kNormalWidth - kLeftSpace, height: 80)
            buttonsView.datas = titles
            kTop = buttonsView.ln_bottom+kTopSpace
            
            resource.managerHeight = kTop
        }
    }
    
}

//Click on the event
extension LNCarManagerCell {

    @objc func didChooseOption(index: String) {
        
        guard let resource = resource else {return}
        var titles = ["Get Help".local, "View Docs".local, "Payments".local, "Cancel Sub".local]
        if !resource.isSingapore {
            titles.remove(at: 1)
        }
        if let index = Int(index) {
            WWZLDebugPrint(item: titles[index - 100])
        }
    }
}
