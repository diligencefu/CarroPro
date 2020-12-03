//
//  LNCarDetailViewController.swift
//  Carro
//
//  Created by MAC on 2020/12/2.
//

import UIKit
import LNTools_fyh

class LNCarDetailViewController: LNBaseViewController {
    
    fileprivate var isSingapore = false
    
    lazy var resource: LResponseModel = {
        let datas = AppTools.jsonDataFromResource()
        return LResponseModel.deserialize(from: datas) ?? LResponseModel()
    }()
    
    //Based on the container
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: self.contentView.bounds)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize.init(width: UIScreen.width, height: self.contentView.ln_height)
        scrollView.delegate = self
        return scrollView
    }()
    
    //Determine the type when initializing
    public init(isSingapore:Bool = false) {
        super.init(nibName: nil, bundle: nil)
        
        self.isSingapore = isSingapore
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configSubViews() {
        
        self.contentView.addSubview(self.scrollView)
        
        //This variable(kTop) is used to record the position y of the current view
        var kTop:CGFloat = 16
        let kLeftSpace:CGFloat = 20
        //The distance between the two views above and below
        let kTopSpace:CGFloat = 12
        let kNormalWidth = UIScreen.width-kLeftSpace*2
        
        //head label
        let descLabel = UILabel.init(frame: CGRect.init(x: kLeftSpace, y: kTop, width: kNormalWidth, height: 0))
        descLabel.text = "View all information about your subscription and get any help you require"
        descLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)
        descLabel.font = UIFont.init(name: "Futura", size: 15)
        descLabel.textColor = UIColor.textColor
        descLabel.numberOfLines = 0
        self.scrollView.addSubview(descLabel)
        //Since its contents can be larger than a row, first lay it out, then confirm the height, and then reassign the height
        descLabel.ln_height = AppTools.calculateRowHeight(descLabel)
        
        kTop = descLabel.ln_bottom+kTopSpace
        let carImage = UIImageView.init(frame: CGRect.init(x: kLeftSpace, y: kTop, width: kNormalWidth, height: 120))
        carImage.image = UIImage.init(named: "carImage")
        carImage.contentMode = .scaleAspectFit
        self.scrollView.addSubview(carImage)
        
        //Pictures of cars
        kTop = carImage.ln_bottom
        let carName = UILabel.init(frame: CGRect.init(x: kLeftSpace, y: kTop, width: kNormalWidth, height: 20))
        carName.text = resource.data.model
        carName.textColor = UIColor.textColor
        carName.font = UIFont.init(name: "Futura", size: 18)
        carName.textAlignment = .center
        self.scrollView.addSubview(carName)

        kTop = carName.ln_bottom+kTopSpace/2
        let carplate_number = UILabel.init(frame: CGRect.init(x: kLeftSpace, y: kTop, width: kNormalWidth, height: 15))
        carplate_number.text = resource.data.carplate_number
        carplate_number.font = UIFont.init(name: "Kohinoor Devanagari", size: 16)
        carplate_number.textColor = UIColor.black1
        carplate_number.textAlignment = .center
        self.scrollView.addSubview(carplate_number)

        //left days
        kTop = carplate_number.ln_bottom+kTopSpace
        let leftTime = UILabel.init(frame: CGRect.init(x: kLeftSpace*2, y: kTop, width: kNormalWidth-kLeftSpace*2, height: 15))
        leftTime.text = (resource.data.days_left.count == 0 ? "0":resource.data.days_left) + " days left"
        leftTime.font = UIFont.systemFont(ofSize: 15)
        leftTime.textColor = UIColor.textColor
        leftTime.textAlignment = .right
        self.scrollView.addSubview(leftTime)
        
        //left progress
        kTop = leftTime.ln_bottom+8
        let progressView = UIProgressView.init(frame: CGRect.init(x: leftTime.ln_x, y: kTop, width: leftTime.ln_width, height: 20))
        progressView.progressTintColor = UIColor.mainColor
        progressView.tintColor = UIColor.lightColor2
        
        let kTotal = 30//Let's say the total value is 30
        if let leftDay = Int(resource.data.days_left) {
            progressView.progress = Float(leftDay/kTotal)
        }else{
            progressView.progress = 0
        }
        self.scrollView.addSubview(progressView)
        
        kTop = progressView.ln_bottom+8
        
        
        self.scrollView.contentSize.height = kTop + 30
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//Click on the event
extension LNCarDetailViewController {
    
    
}


extension LNCarDetailViewController:UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

    }
    
}
