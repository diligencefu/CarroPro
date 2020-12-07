//
//  LNRequestManager.swift
//  Carro
//
//  Created by MAC on 2020/12/7.
//

import UIKit
import AFNetworking

class LNRequestManager: NSObject {
    
    static var shared : AFHTTPSessionManager {
        
        let manager = AFHTTPSessionManager.init(baseURL: Routing.kApi_Base_Url.url)
        manager.requestSerializer = AFHTTPRequestSerializer.init()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.responseSerializer.acceptableContentTypes = NSSet.init(objects: "application/json","charset=utf-8","text/plain","text/html","text/json", "text/javascript") as? Set<String>
        return manager
    }
}
