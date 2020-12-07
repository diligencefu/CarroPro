//
//  LNCarEnhanceCell.swift
//  Carro
//
//  Created by MAC on 2020/12/7.
//

import UIKit

class LNCarEnhanceCell: LNCarCell {

    lazy var enhanceImage: UIImageView = {
        let enhanceImage = UIImageView.init()
        enhanceImage.image = UIImage.init(named: "car_enhance")
        enhanceImage.contentMode = .scaleAspectFill
        enhanceImage.ln_cornerRadius = 10
        return enhanceImage
    }()
    
    lazy var enhanceTitle: UILabel = {
        let enhanceTitle = UILabel.init()
        enhanceTitle.font = UIFont.init(name: "Kohinoor Bangla Semibold", size: 17)
        enhanceTitle.textColor = UIColor.black
        return enhanceTitle
    }()
    
    lazy var enhanceDesc: UILabel = {
        let enhanceDesc = UILabel.init()
        enhanceDesc.font = UIFont.systemFont(ofSize: 13)
        enhanceDesc.textColor = UIColor.init(gary: 78)
        enhanceDesc.numberOfLines = 0
        
        return enhanceDesc
    }()
    
    override func layoutSubviews() {
        contentView.addSubview(enhanceImage)
        contentView.addSubview(enhanceTitle)
        contentView.addSubview(enhanceDesc)
    }
    
    //set values
    public override var resource: LNCarInfoModel? {
        
        didSet {
            guard let resource = resource else {return}
            
            let kLeftSpace:CGFloat = 20
            //The distance between the two views above and below
            let kTopSpace:CGFloat = 12
            var kTop:CGFloat = kTopSpace
            let kNormalWidth = UIScreen.width-kLeftSpace*2
            enhanceImage.frame = CGRect.init(x: kLeftSpace, y: kTop, width: 80, height: 80)
            
            enhanceTitle.frame = CGRect.init(x: enhanceImage.ln_right+12, y: kTop, width: kNormalWidth-enhanceImage.ln_right-kLeftSpace, height: enhanceImage.ln_height/4)
            enhanceTitle.text = "Concierge Service"
            
            enhanceDesc.frame = CGRect.init(x: enhanceTitle.ln_x, y: enhanceTitle.ln_bottom+3, width: kNormalWidth-enhanceImage.ln_right-kLeftSpace, height: enhanceImage.ln_height/4*3-3)
            let labelText = "Take away the hassle of car ownership and enjoy full comfort and convenience with our concierge service."
            let attributeString = NSMutableAttributedString.init(string: labelText)
            let paragraphStyle = NSMutableParagraphStyle.init()
            paragraphStyle.lineSpacing = 3
            attributeString.addAttributes([NSAttributedString.Key.paragraphStyle:paragraphStyle], range: NSRange.init(location: 0, length: labelText.count))
            enhanceDesc.attributedText = attributeString
            
            kTop = enhanceImage.ln_bottom + kTopSpace
            resource.EnhanceHeight = kTop
        }
    }

}
