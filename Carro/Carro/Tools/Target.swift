//
//  Target.swift
//  Carro
//
//  Created by MAC on 2020/12/3.
//

import UIKit

@objc public class Target: NSObject {
    @objc weak var target : NSObject?
    @objc var selector : Selector?
    
    @objc func perform(object: Any!) {
        target?.perform(selector, with: object)
    }
        
    @objc func perform(object1: Any!, object2: Any!) {
        target?.perform(selector, with: object1, with: object2)
    }
    
    @objc init(target:NSObject?, selector:Selector?) {
        super.init()
        self.selector = selector
        self.target = target
    }
    
}
