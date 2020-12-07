//
//  LNCarInfoCell.swift
//  Carro
//
//  Created by MAC on 2020/12/7.
//

import UIKit

class LNCarInfoCell: LNCarCell {
    let cHeight:CGFloat = 100

    //head label
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.init()
        descLabel.text = "View all information about your subscription and get any help you require"
        descLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)
        descLabel.font = UIFont.init(name: "Futura", size: 16)
        descLabel.textColor = UIColor.textColor
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    //Pictures of cars
    lazy var carImage: UIImageView = {
        let carImage = UIImageView.init()
        carImage.image = UIImage.init(named: "carImage")
        carImage.contentMode = .scaleAspectFit
        return carImage
    }()
    
    lazy var carName: UILabel = {
        
        let carName = UILabel.init()
        //carName.text = resource.model
        carName.textColor = UIColor.textColor
        carName.font = UIFont.init(name: "Kohinoor Bangla Semibold", size: 25)
        carName.textAlignment = .center
        return carName
    }()
    
    lazy var carplate_number: UILabel = {
        
        let carplate_number = UILabel.init()
        //carplate_number.text = resource.carplate_number
        carplate_number.font = UIFont.init(name: "Kohinoor Devanagari", size: 16)
        carplate_number.textColor = UIColor.black1
        carplate_number.textAlignment = .center
        return carplate_number
    }()
    
    //left days
    lazy var leftTime: UILabel = {
        
        let leftTime = UILabel.init()
        leftTime.font = UIFont.init(name: "Futura", size: 15)
        leftTime.textColor = UIColor.textColor
        leftTime.textAlignment = .right
        return leftTime
    }()
    
    //left progress
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView.init()
        progressView.progressTintColor = UIColor.mainColor
        progressView.tintColor = UIColor.lightColor2
        
        return progressView
    }()
    
    //Driven this month
    lazy var cLeftView: LNCenterView = {
        let cLeftView = LNCenterView.init(frame: CGRect.init(x:0, y: 0, width: leftTime.ln_width/2, height: cHeight), isDistance: true)
        return cLeftView
    }()
    
    //usage due
    lazy var cRighttView: LNCenterView = {
        let cRighttView = LNCenterView.init(frame: CGRect.init(x: 0, y: 0, width: leftTime.ln_width/2, height: cHeight), isDistance: false)
        return cRighttView
    }()

    //Last updated
    lazy var lastUpdated: UILabel = {
        let lastUpdated = UILabel.init()
        lastUpdated.font = UIFont.init(name: "Kohinoor Devanagari", size: 14)
        lastUpdated.textColor = UIColor.lightColor
        lastUpdated.textAlignment = .center
        return lastUpdated
    }()
    
    lazy var centerLine: UIView = {
        let centerLine = UIView.init()
        centerLine.backgroundColor = UIColor.init(gary: 236)
        return centerLine
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSubviews() {
                
        contentView.addSubview(descLabel)
        contentView.addSubview(carImage)
        contentView.addSubview(carName)
        contentView.addSubview(carplate_number)
        contentView.addSubview(leftTime)
        contentView.addSubview(progressView)
        contentView.addSubview(cLeftView)
        contentView.addSubview(cRighttView)
        contentView.addSubview(centerLine)
        contentView.addSubview(lastUpdated)
    }
    
    //set values
    public override var resource: LNCarInfoModel? {
        
        didSet {
            guard let resource = resource else {return}
            
            //This variable(kTop) is used to record the position y of the current view
            let kLeftSpace:CGFloat = 20
            //The distance between the two views above and below
            let kTopSpace:CGFloat = 12
            var kTop:CGFloat = kTopSpace
            let kNormalWidth = UIScreen.width-kLeftSpace*2
            
            self.descLabel.frame = CGRect.init(x: kLeftSpace, y: kTop, width: kNormalWidth, height: 0)
            self.descLabel.ln_height = AppTools.calculateRowHeight(descLabel)
            
            kTop = self.descLabel.ln_bottom+kTopSpace
            self.carImage.frame = CGRect.init(x: kLeftSpace, y: kTop, width: kNormalWidth, height: 120)
            
            //Pictures of cars
            kTop = carImage.ln_bottom
            self.carName.frame = CGRect.init(x: kLeftSpace, y: kTop, width: kNormalWidth, height: 20)
            self.carName.text = resource.model
            
            kTop = self.carName.ln_bottom+kTopSpace
            self.carplate_number.frame = CGRect.init(x: kLeftSpace, y: kTop, width: kNormalWidth, height: 15)
            self.carplate_number.text = resource.carplate_number

            //left days
            kTop = carplate_number.ln_bottom+kTopSpace
            self.leftTime.frame = CGRect.init(x: kLeftSpace*2, y: kTop, width: kNormalWidth-kLeftSpace*2, height: 15)
            self.leftTime.text = (resource.days_left.count == 0 ? "0":resource.days_left) + " days left"
            
            //left progress
            kTop = leftTime.ln_bottom+8
            self.progressView.frame = CGRect.init(x: leftTime.ln_x, y: kTop, width: leftTime.ln_width, height: 20)
            let kTotal:Float = 30//Let's say the total value is 30
            if let leftDay = Float(resource.days_left) {
                self.progressView.progress = leftDay/kTotal
            }else{
                self.progressView.progress = 0
            }
            
            //Driven this month & usage due
            kTop = progressView.ln_bottom
            self.cLeftView.frame = CGRect.init(x: progressView.ln_x, y: kTop, width: leftTime.ln_width/2, height: cHeight)
            self.cLeftView.setValue("\(resource.driven_this_month)")

            self.cRighttView.frame =  CGRect.init(x: leftTime.ln_right - leftTime.ln_width/2, y: kTop, width: leftTime.ln_width/2, height: cHeight)
            self.cRighttView.setValue("\(resource.usage_due_this_month)")

            self.centerLine.frame = CGRect.init(x: cLeftView.ln_right, y: cLeftView.ln_y+16, width: 1, height: cHeight-16*2)
            
            //Last updated
            kTop = cLeftView.ln_bottom
            self.lastUpdated.frame = CGRect.init(x: kLeftSpace, y: kTop, width: kNormalWidth, height: 15)
            self.lastUpdated.text = "last updated: " + Date.init(timeIntervalSince1970: resource.updated_at).toString()
            kTop = lastUpdated.ln_bottom + kTopSpace
            
            resource.carInfoHeight = kTop
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
