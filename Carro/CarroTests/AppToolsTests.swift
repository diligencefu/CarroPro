//
//  AppToolsTests.swift
//  CarroTests
//
//  Created by MAC on 2020/12/4.
//

import XCTest
@testable import Carro

class AppToolsTests: XCTestCase {

    func testNumber() {
        
        let str1 = "1000"
        XCTAssertEqual(AppTools.conversionOfDigital(str1), "1,000")
        
        let str2 = "1000.00"
        XCTAssertEqual(AppTools.conversionOfDigital(str2), "1,000.00")
        
        let str3 = "13516543.01"
        XCTAssertEqual(AppTools.conversionOfDigital(str3), "13,516,543.01")
        
        let str4 = "123456"
        XCTAssertEqual(AppTools.conversionOfDigital(str4), "123,456")
        
        let str5 = "1234567"
        XCTAssertEqual(AppTools.conversionOfDigital(str5), "1,234,567")
    }
    
}

