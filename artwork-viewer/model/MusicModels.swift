//
//  MusicModels.swift
//  artwork-viewer
//
//  Created by konojunya on 2017/07/02.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import ObjectMapper

class MusicModels: Mappable {
    
    var musics = [MusicModel]()
    
    required convenience init?(map: Map) {
        self.init
    }
    
    mutating func mapping(map: Map) {
        self.musics <- map["results"]
    }
    
}
