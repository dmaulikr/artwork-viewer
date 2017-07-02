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
        self.init()
    }
    
    func mapping(map: Map) {
        self.musics <- map["results"]
    }
    
    func getCount() -> Int {
        return self.musics.count
    }
    
    func getMusic(_ row: Int) -> MusicModel {
        return self.musics[row]
    }
    
}
