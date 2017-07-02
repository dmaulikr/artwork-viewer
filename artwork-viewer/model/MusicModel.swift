//
//  MusicModel.swift
//  artwork-viewer
//
//  Created by konojunya on 2017/07/02.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import ObjectMapper

class MusicModel: Mappable {
    
    var artworkImage: String?
    var trackName: String?
    var artistName: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        self.artworkImage <- map["artworkUrl100"]
        self.trackName <- map["trackName"]
        self.artistName <- map["artistName"]
    }
    
}
