//
//  Artwork.swift
//  artwork-viewer
//
//  Created by konojunya on 2017/06/21.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import APIKit

protocol ArtworkRequestType: Request {}

extension ArtworkRequestType {
    var baseURL:URL {
        return URL(string: "https://itunes.apple.com")!
    }
}

struct ArtworkData {
    var albumData: [[String:String]] = []
    
    init?(_ dic: [String: Any]) {
        
        print(dic["results"]! as! [[String:String]])
        
        guard let array = dic["results"] as? [[String:String]] else {
            return nil
        }
        
        for item in array {
            guard let title = item["collectionName"] else {
                return nil
            }
            guard let image = item["artworkUrl100"] else {
                return nil
            }
            let data = [
                "title": title,
                "image": image
            ]
            
            self.albumData.append(data)
            
        }
        
    }
    
}

struct GetArtworkRequest: ArtworkRequestType {
    // 成功時の値をArtworkData型で返す
    typealias Response = ArtworkData
    
    // メソッド
    var method: HTTPMethod {
        return .get
    }
    
    // リソース
    var path: String {
        return "/search"
    }
    
    // 付加するパラメータ
    var parameters: [String:String] {
        return [
            "term": "AAA",
            "media": "music",
            "entity": "musicTrack",
            "country": "jp",
            "lang": "ja_JP"
        ]
    }
    
    // 受信完了後のデコード処理
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        
        print(object)
        
        let dic = object as? [String:Any]
        let artworkData = ArtworkData(dic!)
        
        return artworkData!
        
    }
    
}
