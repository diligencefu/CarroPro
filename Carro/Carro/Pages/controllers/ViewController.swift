//
//  ViewController.swift
//  Carro
//
//  Created by MAC on 2020/12/3.
//

import UIKit
import LNTools_fyh
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configSubViews()
    }
    
     func configSubViews() {
        
        self.navigationItem.title = "Main"
        self.view.backgroundColor = UIColor.backGroudColor
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Detail", style: .plain, target: self, action: #selector(goToDetailPage(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.init(gary: 36)
    }
    
    
    @objc func goToDetailPage(sender: NSObject) {
        
        LNBubbleViewController.init(lineHeight: 44,
                                    titles: ["Singapore", "Thailand"],
                                    target: Target.init(target: self,
                                                        selector: #selector(bubbleAction(title:index:))),
                                    sender: sender)
                              .show()
    }
    
    
    @objc func bubbleAction(title:String, index:String) {
        
        let detailVc = LNCarDetailViewController.init(isSingapore: index == "0")
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
}

