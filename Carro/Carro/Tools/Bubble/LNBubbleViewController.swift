//
//  LNBubbleViewController.swift
//  JiGouBao
//
//  Created by MAC on 2020/9/14.
//  Copyright © 2020 jzt. All rights reserved.
//

import UIKit
import LNTools_fyh

@objc public enum KLNBubbleStyle : Int {
    case dark = 0
    case light
}

//定义images的类型，只能这个三种
protocol GetImage {}
extension URL: GetImage {}
extension String: GetImage {}
extension UIImage: GetImage {}

class LNBubbleViewController: UIViewController {
    
    @objc public var target : Target?
    
    //每行的高度
    fileprivate var lineHeight:CGFloat = 44
    //title
    fileprivate var titles:[String] = []
    //图片image
    fileprivate var images:[GetImage]?
    //点击到的view
    fileprivate var pointView:UIView!
    
    //展示整个气泡的父容器
    fileprivate var bubbleView : UIView!
    //字体大小
    var font = UIFont.systemFont(ofSize: 16)
    //三角的高度
    fileprivate var angleHeight:CGFloat = 12
    
    //文字颜色
    private var kTextColor = UIColor.black.withAlphaComponent(0.95)
    //背景颜色
    private var kBackColor = UIColor.white.withAlphaComponent(0.95)
    //颜色风格
    fileprivate var bubbleStyle = KLNBubbleStyle.dark

    ///lineHeight : 每一行的高度， titles:标题，image：图片，要与titles数量相等，target：响应事件，需要创建一个Target类型，bubbleStyle：0dark，黑暗色，1light，明亮色
    init(lineHeight: CGFloat = 44, titles: [String], images:[GetImage]? = nil, target: Target?=nil, sender: NSObject) {
        
        self.lineHeight = lineHeight
        self.titles = titles
//        self.bubbleStyle = bubbleStyle
        if let images = images, images.count > 0 {
            self.images = images
            if titles.count != images.count {
                _="图片和文字的数量必须要相等！"
                abort()
            }
        }
        if let target = target {
            self.target = target
        }
        if let view = sender as? UIView {
            self.pointView = view
        }else if let view = sender.value(forKey: "view") as? UIView {
            self.pointView = view
        }
        
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSubViews()
    }
    
    
    fileprivate func configSubViews() {
        
        let alpha:CGFloat = 0.98
        if bubbleStyle == .dark {
            kTextColor = UIColor.init(hex: "#F7F9Fb").withAlphaComponent(alpha)
            kBackColor = UIColor.init(hex: "#1F1F1F").withAlphaComponent(alpha)
        }else{
            kTextColor = UIColor.init(hex: "#1F1F1F").withAlphaComponent(alpha)
            kBackColor = UIColor.init(hex: "#F7F9Fb").withAlphaComponent(alpha)
        }
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.11)
        
        var maxWidth:CGFloat = 0
        for text in titles {
            let width = KGetLabWidth(labelStr: text, font: font, height: lineHeight)
            maxWidth = maxWidth > width ? maxWidth:width
        }
        
        maxWidth = maxWidth + 16 + (images == nil ? 0:24)
        
        var kBottomSapce:CGFloat = 0
        
        var frame = CGRect.zero
        if let window = UIApplication.shared.windows.first {
            frame = pointView.convert(pointView.bounds, to: window)
            kBottomSapce = window.frame.size.height - frame.origin.y
        }
        
        bubbleView = UIView.init(frame: CGRect.init(x: 0, y: frame.origin.y + frame.size.height, width: maxWidth, height: CGFloat(titles.count) * lineHeight + angleHeight))
        self.view.addSubview(bubbleView)
        
        //左右间隙不能太小
        let centerX = frame.midX
        bubbleView.center.x = centerX
        if centerX + maxWidth/2  > UIScreen.width {
            bubbleView.ln_right = UIScreen.width - 5
        }
        if centerX - maxWidth/2  < 0 {
            bubbleView.ln_x = 5
        }
        
        let angleView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: bubbleView.ln_width, height: angleHeight))
        bubbleView.addSubview(angleView)
        
        let showView = UIView.init(frame: CGRect.init(x: 0, y: angleHeight, width: bubbleView.ln_width, height: bubbleView.ln_height - angleHeight))
        showView.ln_cornerRadius = 4
        showView.backgroundColor = kBackColor
        bubbleView.addSubview(showView)
        
        //以视图的中心点为原点找位置
        func getX(_ value: CGFloat) -> CGFloat {
            
            var x = centerX  - bubbleView.ln_x
            x = x > bubbleView.ln_width - 14 ? bubbleView.ln_width - 14:x
            x = x < 14 ? 14:x
            
            return x  + value
        }
        
        let bezir = UIBezierPath.init()
        //点击的视图下方间距是否足够气泡
        let isBottomSpaceEnough = kBottomSapce >= bubbleView.ln_height
        if !isBottomSpaceEnough {
            bubbleView.ln_y = frame.origin.y - bubbleView.ln_height
            angleView.ln_y = bubbleView.ln_height - angleHeight
            showView.ln_y = 0
            //箭头向下
            bezir.move(to: CGPoint.init(x: getX(-10), y: 0))
            bezir.addLine(to: CGPoint.init(x: getX(0), y: 7.5))
            bezir.addLine(to: CGPoint.init(x: getX(10), y: 0))
            bezir.addLine(to: CGPoint.init(x: getX(-10), y: 0))
        }else{
            //箭头向上
            bezir.move(to: CGPoint.init(x: getX(-10), y: angleHeight))
            bezir.addLine(to: CGPoint.init(x: getX(0), y: 3.5))
            bezir.addLine(to: CGPoint.init(x: getX(10), y: angleHeight))
            bezir.addLine(to: CGPoint.init(x: getX(-10), y: angleHeight))
        }
        
        let shape = CAShapeLayer.init()
        shape.lineWidth = 1
        shape.fillColor = kBackColor.cgColor
        shape.cornerRadius = 3
        shape.path = bezir.cgPath
        angleView.layer.addSublayer(shape)
        
        for index in 0..<titles.count {
            let buttonItem = UIButton.init(frame: CGRect.init(x: 0, y: CGFloat(index)*lineHeight, width: maxWidth, height: lineHeight))
            buttonItem.setTitle(titles[index], for: .normal)
            
            if let images = images {
                if let string = images[index] as? String {
                    if string.hasPrefix("http") {
                        //buttonItem.kf.setImage(with: URL.init(string: string), for: .normal, placeholder: UIImage.init(named: "placeholder_1"))
                    }else{
                        buttonItem.setImage(UIImage.init(named: string), for: .normal)
                    }
                }else if let image = images[index] as? UIImage {
                    buttonItem.setImage(image, for: .normal)
                }
            }
            buttonItem.titleLabel?.font = font
            buttonItem.setTitleColor(kTextColor, for: .normal)
            buttonItem.addTarget(self, action: #selector(chooseTarget(sender:)), for: .touchUpInside)
            buttonItem.tag = 100+index
            showView.addSubview(buttonItem)
            
            if index == titles.count - 1 {
                break
            }
            let bottomLine = UIView.init(frame: CGRect.init(x: 4, y: buttonItem.ln_height-1, width: buttonItem.ln_width - 8, height: 0.5))
            bottomLine.backgroundColor = kTextColor
            buttonItem.addSubview(bottomLine)
        }
    }
    
    
    @objc func chooseTarget(sender: UIButton) {
        
        let index = sender.tag-100
        
        target?.perform(object1: titles[index], object2: "\(index)")
        UIView.animate(withDuration: 0.15) {
            self.bubbleView.alpha = 0
        }
        self.dismiss(animated: false, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.15) {
            self.bubbleView.alpha = 0
        }
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @discardableResult
    public func show() -> Bool {
        if let vc = self.pointView.ln_viewContainingController() {
            vc.present(self, animated: false, completion: nil)
            return true
        }else{
            return false
        }
    }
    
    //MARK:获取字符串的宽度的封装
    func KGetLabWidth(labelStr:String,font:UIFont,height:CGFloat) -> CGFloat {
        
        let statusLabelText: NSString = labelStr as NSString
        let size = CGSize(width: 900, height: height)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context:nil).size
        return strSize.width + 10
        
    }
}



