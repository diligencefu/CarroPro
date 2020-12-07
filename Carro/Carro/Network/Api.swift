//
//  Api.swift
//  Carro
//
//  Created by MAC on 2020/12/7.
//


import UIKit

class Routing:NSObject {
    
    static var kApi_Base_Url:String {
        get {
            if AppConfig.isTest {
                return "https://gist.githubusercontent.com/"
            } else {
                return "https://gist.githubusercontent.com/"
            }
        }
    }
}

