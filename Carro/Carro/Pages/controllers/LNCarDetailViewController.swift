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
        descLabel.font = UIFont.init(name: "Futura", size: 16)
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
        carName.font = UIFont.init(name: "Kohinoor Bangla Semibold", size: 25)
        carName.textAlignment = .center
        self.scrollView.addSubview(carName)

        kTop = carName.ln_bottom+kTopSpace
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
        leftTime.font = UIFont.init(name: "Futura", size: 15)
        leftTime.textColor = UIColor.textColor
        leftTime.textAlignment = .right
        self.scrollView.addSubview(leftTime)
        
        //left progress
        kTop = leftTime.ln_bottom+8
        let progressView = UIProgressView.init(frame: CGRect.init(x: leftTime.ln_x, y: kTop, width: leftTime.ln_width, height: 20))
        progressView.progressTintColor = UIColor.mainColor
        progressView.tintColor = UIColor.lightColor2
        
        let kTotal:Float = 30//Let's say the total value is 30
        if let leftDay = Float(resource.data.days_left) {
            progressView.progress = leftDay/kTotal
        }else{
            progressView.progress = 0
        }
        self.scrollView.addSubview(progressView)
        
        //Separate the slightly more complex and reusable content into a single class, even if the interface layout changes later on, will not affect this.
        
        //Driven this month & usage due
        kTop = progressView.ln_bottom
        let cHeight:CGFloat = 100
        let cLeftView = LNCenterView.init(frame: CGRect.init(x: progressView.ln_x, y: kTop, width: leftTime.ln_width/2, height: cHeight), isDistance: true, value: "\(resource.data.driven_this_month)")
        self.scrollView.addSubview(cLeftView)
        
        let cRighttView = LNCenterView.init(frame: CGRect.init(x: progressView.ln_x, y: kTop, width: leftTime.ln_width/2, height: cHeight), isDistance: false, value: "\(resource.data.usage_due_this_month)")
        cRighttView.ln_x = leftTime.ln_right - leftTime.ln_width/2
        self.scrollView.addSubview(cRighttView)
        
        let centerLine = UIView.init(frame: CGRect.init(x: cLeftView.ln_right, y: cLeftView.ln_y+16, width: 1, height: cHeight-16*2))
        centerLine.backgroundColor = UIColor.init(gary: 236)
        self.scrollView.addSubview(centerLine)
        
        //Last updated
        kTop = cLeftView.ln_bottom
        let lastUpdated = UILabel.init(frame: CGRect.init(x: kLeftSpace, y: kTop, width: kNormalWidth, height: 15))
        lastUpdated.text = "last updated: " + Date.init(timeIntervalSince1970: resource.data.updated_at).toString()
        lastUpdated.font = UIFont.init(name: "Kohinoor Devanagari", size: 14)
        lastUpdated.textColor = UIColor.lightColor
        lastUpdated.textAlignment = .center
        self.scrollView.addSubview(lastUpdated)
        
        kTop = lastUpdated.ln_bottom + kTopSpace
        let model = resource.data
        
        //The display of the value needs to be processed first
        let base_price = AppTools.conversionOfDigital(number: "\(model.base_price)")+" /month"
        let road_tax = AppTools.conversionOfDigital(number:"\(model.road_tax)")
        let total_per_km_rate = AppTools.conversionOfDigital(number: "\(model.total_per_km_rate)")+" /km"
        let drivers = model.drivers
        let insurance_excess = AppTools.conversionOfDigital(number:"\(model.insurance_excess)")
        
        var formData = [["title":"Base Price", "value":base_price],
                        ["title":"Road Tax", "value":road_tax],
                        ["title":"Usage Based Insurance", "value":total_per_km_rate],
                        ["title":"Named Drivers", "value":drivers],
                        ["title":"Insurance Excess", "value":insurance_excess]]
        //The distinction between the two types
        if !isSingapore {
            formData.remove(at: 3)
            formData.remove(at: 2)
            let total_outstanding_fine_count = AppTools.conversionOfDigital(number:"\(model.total_outstanding_fine_count)")
            let total_outstanding_fine_amount = AppTools.conversionOfDigital(number:"\(model.total_outstanding_fine_amount)")
            formData.append(["title":"Total Fines", "value":total_outstanding_fine_count])
            formData.append(["title":"Total Fines Amount", "value":total_outstanding_fine_amount])
        }
        let formView = LNFormView.init(frame: CGRect.init(x: kLeftSpace, y: kTop, width: kNormalWidth, height: 10), datas: formData)
        self.scrollView.addSubview(formView)
        
        kTop = formView.ln_bottom + kTopSpace
        if isSingapore {
            let customizeButton = UIButton.init(frame: CGRect.init(x: UIScreen.width/5, y: kTop, width: UIScreen.width/5*3, height: 46))
            customizeButton.setTitle("Customize your insurance", for: .normal)
            customizeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            customizeButton.setTitleColor(.white, for: .normal)
            customizeButton.ln_cornerRadius = 8
            customizeButton.backgroundColor = UIColor.mainColor
            customizeButton.addTarget(self, action: #selector(didClickCustomize(sender:)), for: .touchUpInside)
            self.scrollView.addSubview(customizeButton)

            kTop = customizeButton.ln_bottom + kTopSpace
        }
        
        let label1 = createSectionLabel(text: "Manager your subscription", rect: CGRect.init(x: kLeftSpace, y: kTop+kTopSpace, width: kNormalWidth, height: 40))
        kTop = label1.ln_bottom + kTopSpace
        
        //Manager your subscription,  options
        var titles = ["Get Help", "View Docs", "Payments", "Cancel Sub"]
        if !isSingapore {
            titles.remove(at: 1)
        }
        let buttons = LNButtonsView.init(frame: CGRect.init(x: kLeftSpace*1.5, y: kTop, width: kNormalWidth-kLeftSpace, height: 80), datas: titles, target: Target.init(target: self, selector: #selector(didChooseOption(index:))))
        self.scrollView.addSubview(buttons)
        
        kTop = buttons.ln_bottom + kTopSpace
        let label2 = createSectionLabel(text: "Enhance your subscription", rect: CGRect.init(x: kLeftSpace, y: kTop+kTopSpace, width: kNormalWidth, height: 40))
        //Enhance your subscription, content
        kTop = label2.ln_bottom + kTopSpace
        let enhanceImage = UIImageView.init(frame: CGRect.init(x: kLeftSpace, y: kTop, width: 80, height: 80))
        enhanceImage.image = UIImage.init(named: "car_enhance")
        enhanceImage.contentMode = .scaleAspectFill
        enhanceImage.ln_cornerRadius = 10
        self.scrollView.addSubview(enhanceImage)
        
        let enhanceTitle = UILabel.init(frame: CGRect.init(x: enhanceImage.ln_right+12, y: kTop, width: kNormalWidth-enhanceImage.ln_right-kLeftSpace, height: enhanceImage.ln_height/4))
        enhanceTitle.text = "Concierge Service"
        enhanceTitle.font = UIFont.init(name: "Kohinoor Bangla Semibold", size: 17)
        enhanceTitle.textColor = UIColor.black
        self.scrollView.addSubview(enhanceTitle)
        
        let enhanceDesc = UILabel.init(frame: CGRect.init(x: enhanceTitle.ln_x, y: enhanceTitle.ln_bottom+3, width: kNormalWidth-enhanceImage.ln_right-kLeftSpace, height: enhanceImage.ln_height/4*3-3))
        let labelText = "Take away the hassle of car ownership and enjoy full comfort and convenience with our concierge service."
        enhanceDesc.font = UIFont.systemFont(ofSize: 13)
        enhanceDesc.textColor = UIColor.init(gary: 78)
        enhanceDesc.numberOfLines = 0
        let attributeString = NSMutableAttributedString.init(string: labelText)
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = 3
        attributeString.addAttributes([NSAttributedString.Key.paragraphStyle:paragraphStyle], range: NSRange.init(location: 0, length: labelText.count))
        enhanceDesc.attributedText = attributeString
        self.scrollView.addSubview(enhanceDesc)

        self.scrollView.contentSize.height = enhanceImage.ln_bottom + 30
    }
    
    
    @discardableResult
    func createSectionLabel(text: String, rect:CGRect) -> UILabel {

        let sectionLabel = UILabel.init(frame: rect)
        sectionLabel.text = text
        sectionLabel.font = UIFont.boldSystemFont(ofSize: 25)
        sectionLabel.font = UIFont.init(name: "Verdana Bold", size: 20)
        sectionLabel.textColor = UIColor.black
        sectionLabel.textAlignment = .center
        self.scrollView.addSubview(sectionLabel)
        return sectionLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//Click on the event
extension LNCarDetailViewController {
    
    @objc func didClickCustomize(sender: UIButton) {
        WWZLDebugPrint(item: "Customize your insurance")
    }
    
    @objc func didChooseOption(index: String) {
        var titles = ["Get Help", "View Docs", "Payments", "Cancel Sub"]
        if !isSingapore {
            titles.remove(at: 1)
        }
        if let index = Int(index) {
            WWZLDebugPrint(item: titles[index-100])
        }
    }
}


extension LNCarDetailViewController:UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

    }
    
}
