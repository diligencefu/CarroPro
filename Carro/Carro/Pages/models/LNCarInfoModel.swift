//
//  LNListResponseModel.swift
//  Carro
//
//  Created by MAC on 2020/12/2.
//

import UIKit

class LNCarInfoModel: LNBaseModel {
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
    var total_outstanding_fine_count = Int()
    var total_outstanding_fine_amount = Float()
    var earliest_payment_due_date = String()
    var total_per_km_rate = Float()
    var days_left = String()
    var driven_this_month = Int()
    var usage_due_this_month = Int()
    var base_price = Float()
    var road_tax = Float()
    var insurance_excess = 0
    var has_subscribed_insurance = Bool()
    var updated_at = TimeInterval()
    
    var records = [Record]()
    var help = [Help]()
    var drivers = [Driver]()
    
    var isSingapore = false
    
    //ROWHEIGHT
    var carInfoHeight:CGFloat = 0
    var carFormHeight:CGFloat = 0
    var managerHeight:CGFloat = 0
    var EnhanceHeight:CGFloat = 0
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
