//
//  LNCarFormCell.swift
//  Carro
//
//  Created by MAC on 2020/12/7.
//

import UIKit
import LNTools_fyh

class LNCarFormCell: LNCarCell {

    lazy var formView: LNFormView = {
        let formView = LNFormView.init(frame: CGRect.zero)
        return formView
    }()
    
    lazy var customizeButton: UIButton = {
        let customizeButton = UIButton.init()
        customizeButton.setTitle("Customize your insurance", for: .normal)
        customizeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        customizeButton.setTitleColor(.white, for: .normal)
        customizeButton.ln_cornerRadius = 8
        customizeButton.backgroundColor = UIColor.mainColor
        customizeButton.addTarget(self, action: #selector(didClickCustomize(sender:)), for: .touchUpInside)
        return customizeButton
    }()
    
    override func layoutSubviews() {
        contentView.addSubview(formView)
        contentView.addSubview(customizeButton)
    }
    
    //set values
    public override var resource: LNCarInfoModel? {
        
        didSet {
            guard let resource = resource else {return}
            
            //The display of the value needs to be processed first
            let base_price = AppTools.conversionOfDigital("\(resource.base_price)") + " /month"
            let road_tax = AppTools.conversionOfDigital("\(resource.road_tax)")
            let total_per_km_rate = AppTools.conversionOfDigital("\(resource.total_per_km_rate)") + " /km"
            let drivers = resource.drivers
            let insurance_excess = AppTools.conversionOfDigital("\(resource.insurance_excess)")
            
            var formData = [["title":"Base Price".local, "value":base_price],
                            ["title":"Road Tax".local, "value":road_tax],
                            ["title":"Usage Based Insurance".local, "value":total_per_km_rate],
                            ["title":"Named Drivers".local, "value":drivers],
                            ["title":"Insurance Excess".local, "value":insurance_excess]]
            //The distinction between the two types
            if !resource.isSingapore {
                formData.remove(at: 3)
                formData.remove(at: 2)
                let total_outstanding_fine_count = AppTools.conversionOfDigital("\(resource.total_outstanding_fine_count)")
                let total_outstanding_fine_amount = AppTools.conversionOfDigital("\(resource.total_outstanding_fine_amount)")
                formData.append(["title":"Total Fines".local, "value":total_outstanding_fine_count])
                formData.append(["title":"Total Fines Amount".local, "value":total_outstanding_fine_amount])
            }
            
            //This variable(kTop) is used to record the position y of the current view
            let kLeftSpace:CGFloat = 20
            //The distance between the two views above and below
            let kTopSpace:CGFloat = 12
            var kTop:CGFloat = kTopSpace
            let kNormalWidth = UIScreen.width - kLeftSpace*2
            formView.frame = CGRect.init(x: kLeftSpace, y: kTop, width: kNormalWidth, height: 10)
            formView.datas = formData
            
            kTop = formView.ln_bottom + kTopSpace
            if resource.isSingapore {
                let width = UIScreen.width/5*3
                self.customizeButton.frame = CGRect.init(x: UIScreen.width/5, y: kTop, width: width, height: 46)
                kTop = customizeButton.ln_bottom + kTopSpace
            }
            resource.carFormHeight = kTop
        }
    }
}

//actions
extension LNCarFormCell {
    
    @objc func didClickCustomize(sender: UIButton) {
        WWZLDebugPrint(item: "Customize your insurance".local)
    }
}
