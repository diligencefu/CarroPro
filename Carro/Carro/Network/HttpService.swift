//
//  HttpService.swift
//  Carro
//
//  Created by MAC on 2020/12/7.
//


import AFNetworking
import HandyJSON
import LNTools_fyh


class HttpService<T> {
        
    ///get
    class func get(route: LNUrl, params:[String:Any]? = nil, result: @escaping (HttpResult<T>)->()) {
        
        LNRequestManager.shared.get(route.rawValue, parameters: params, headers: nil, progress: nil) { (task, responseObject) in
            WWZLDebugPrint(item: task.currentRequest?.url?.absoluteString ?? "")
            onResponse(responseObject, result)
        } failure: { (task, error) in
            WWZLDebugPrint(item: error)
            result(HttpResult.fail())
        }
    }
    
    ///post
    class func post(route: LNUrl, params:[String:Any]? = nil, result: @escaping (HttpResult<T>)->()) {
        
        LNRequestManager.shared.post(route.rawValue, parameters: params, headers: nil, progress: nil) { (task, responseObject) in
            WWZLDebugPrint(item: task.currentRequest?.url?.absoluteString ?? "")
            onResponse(responseObject!, result)
        } failure: { (task, error) in
            WWZLDebugPrint(item: error)
            result(HttpResult.fail())
        }
    }
    
    ///The json data
    class func body(route: LNUrl, params:[String:Any]? = nil, result: @escaping (HttpResult<T>)->()) {
        let manager = LNRequestManager.shared
        manager.requestSerializer = AFJSONRequestSerializer.init()
        manager.post(route.rawValue, parameters: params, headers: nil, progress: nil) { (task, responseObject) in
            WWZLDebugPrint(item: task.currentRequest?.url?.absoluteString ?? "")
            onResponse(responseObject!, result)
        } failure: { (task, error) in
            WWZLDebugPrint(item: error)
            result(HttpResult.fail())
        }
    }
    
    //Request result processing
    private class func onResponse(_ response:Any?, _ resultClosure: (HttpResult<T>)->()) {
        
        WWZLDebugPrint(item: "Result：")
        WWZLDebugPrint(item: response ?? "")
        if let resultDic = response as? [String : Any],
           
            let dataModel = HttpResult<T>.deserialize(from: resultDic) {
            dataModel.rawData = response
            resultClosure(dataModel)
        } else {
            resultClosure(HttpResult.fail())
        }
    }
}



class HttpResult<T>: HandyJSON {
    
    var data:T?
    var success:HttpMessage?
    var fail:HttpMessage?
    var rawData:Any?

    var isSucceess : Bool {
//        code == http_ok
        if let success = self.success, let _ = success.message {
            return true
        }else{
            return false
        }
    }
    
    class func fail(code:String = "-1", message:String = "Network request failed") -> HttpResult {
        let result = HttpResult()
        
        let httpMsg = HttpMessage()
        httpMsg.message = message
        result.fail = httpMsg
        
        return result
    }
    
    required init() {}
}

class HttpMessage: LNBaseModel {
    var message : String?
}
