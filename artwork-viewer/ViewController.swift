//
//  ViewController.swift
//  artwork-viewer
//
//  Created by konojunya on 2017/06/21.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.post()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func post(){
        let params = [
            "term": "AAA",
            "media": "music",
            "entity": "musicTrack",
            "country": "jp",
            "lang": "ja_JP"
        ]
        
        let url = URL(string: "https://itunes.apple.com/search?term=AAA&media=music&entity=musicTrack&lang=ja_JP&country=jp")
        if url == nil {
            print("error")
            return
        }else{
            let req = NSMutableURLRequest(url: url! as URL)
            req.httpMethod = "GET"
//            req.httpBody = self.stringFromHttpParameters(params).data(using: String.Encoding.utf8)
            let conf = URLSessionConfiguration.default
            let urlSession = URLSession(configuration: conf)
            
            urlSession.dataTask(with: req as URLRequest) { data, responce,error in
                if error == nil {
                    if let str = String(data: data!,encoding: String.Encoding.utf8) {
                        print(str)
                    }
                }
            }.resume()
        }
    }
    
    private func stringByAddingPercentEncodingForURLQueryValue(_ arg: String) -> String? {
        let characterSet = NSMutableCharacterSet.alphanumeric()
        characterSet.addCharacters(in: "-._~/%")
        
        return arg.addingPercentEncoding(withAllowedCharacters: characterSet as CharacterSet)
    }
    private func stringFromHttpParameters(_ dict : [String: String]) -> String {
        
        let parameterArray = dict.map { (key, value) -> String in
            let percentEscapedKey = self.stringByAddingPercentEncodingForURLQueryValue(key)!
            let percentEscapedValue = self.stringByAddingPercentEncodingForURLQueryValue(value)!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joined(separator: "&")
    }

}

