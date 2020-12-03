//
//  LNListResponseModel.swift
//  Carro
//
//  Created by MAC on 2020/12/2.
//

import UIKit

class LResponseModel: LNBaseModel {
    
    var data = Data()
    var success = Success()
}

class Data: LNBaseModel {
    var id = 0
    var type = String()
    var make = String()
    var model = String()
    var carplate_number = String()
    var price = String()
    var start_time = TimeInterval()
    var end_time = TimeInterval()
    var next_billing_date = String()
    var mileage = String()
    var total_outstanding_fine_count = 0
    var total_outstanding_fine_amount = 0
    var earliest_payment_due_date = String()
    var total_per_km_rate = 0
    var days_left = String()
    var driven_this_month = 0
    var usage_due_this_month = 0
    var base_price = 0
    var road_tax = 0
    var insurance_excess = 0
    var has_subscribed_insurance = Bool()
    var updated_at = TimeInterval()
    
    var records = [Record]()
    var help = [Help]()
    var drivers = [Driver]()
}

class Record: LNBaseModel {
    var key = String()
    var label = String()
}

class Help: LNBaseModel {
    var key = String()
    var label = String()
    var value = String()
}

class Driver: LNBaseModel {
    var name = String()
}

class Success: LNBaseModel {
    var message = String()

}
