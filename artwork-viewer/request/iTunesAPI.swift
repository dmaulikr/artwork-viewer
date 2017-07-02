//
//  iTunesAPI.swift
//  artwork-viewer
//
//  Created by konojunya on 2017/07/02.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import APIKit
import ObjectMapper

protocol iTunesRequest: Request {

}

extension iTunesRequest {
    
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }
    
}

struct FetchArtworkRequest: iTunesRequest {
    
    var term: String?
    var media: String?
    var entity: String?
    var country: String?
    var lang: String?
    
    typealias Response = MusicModels
    
    var path: String {
        return "/search"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Any? {
        return [
            "term": self.term,
            "media": self.media,
            "entity": self.entity,
            "country": self.country,
            "lang": self.lang
        ]
    }
    
    init(term: String, media: String, entity: String, country: String, lang: String) {
        self.term = term
        self.media = media
        self.entity = entity
        self.country = country
        self.lang = lang
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> FetchArtworkRequest.Response {
        return Mapper<MusicModels>().map(JSONObject: object)!
    }
    
}
