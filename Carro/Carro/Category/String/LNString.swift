//
//  LNString.swift
//  Carro
//
//  Created by MAC on 2020/12/7.
//

import UIKit

extension String {
    
    var url: URL? {
        get {
            if  count > 0,
                let urlString = addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                if urlString.hasPrefix("http") {
                    return URL(string: urlString)
                }else {
                    return URL(string: Routing.kApi_Base_Url + urlString)
                }
            }
            return nil
        }
    }
}
