//
//  RequestAgent.swift
//  artwork-viewer
//
//  Created by konojunya on 2017/06/21.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import Foundation

class RequestAgent {
    
    var url:String = ""
    var method:String = ""
    var path:String = ""
    var data:[String:String] = [:]
    
    
    init(url: String, method: String, path: String, data: [String:String]){
        self.url = url
        self.method = method
        self.path = path
        self.data = data
    }
    
    private func convertToParam(_ dict: [String:String]) -> String {
        let parameterArray = dict.map { (key, value) -> String in
            let percentEscapedKey = self.stringByAddingPercentEncodingForURLQueryValue(key)!
            let percentEscapedValue = self.stringByAddingPercentEncodingForURLQueryValue(value)!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return  "?" + parameterArray.joined(separator: "&")
    }
    
    private func stringByAddingPercentEncodingForURLQueryValue(_ arg: String) -> String? {
        let characterSet = NSMutableCharacterSet.alphanumeric()
        characterSet.addCharacters(in: "-._~/%")
        
        return arg.addingPercentEncoding(withAllowedCharacters: characterSet as CharacterSet)
    }
    
    func run(success: @escaping (_ json: [String:AnyObject]) -> Void, fail: @escaping (_ error: Error) -> Void) {
        
        let reqUrl = URL(string: self.url + self.path + self.convertToParam(self.data))
        var request = URLRequest(url: reqUrl!)
        request.httpMethod = self.method
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty!")
                return
            }
            
            do {
                let json = try! JSONSerialization.jsonObject(with: data) as! [String:AnyObject]
                success(json)
            }catch let error {
                fail(error)
            }
            
        }
        
        task.resume()
    }
    
}
