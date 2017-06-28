//
//  ArtworkModelStore.swift
//  artwork-viewer
//
//  Created by konojunya on 2017/06/28.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import Foundation

class ArtworkModelStore {
    
    private var artworkModels:[ArtworkModel] = []
    
    /// model setter
    ///
    /// - Parameter model: artwork model
    func setModel(_ model: ArtworkModel){
        self.artworkModels.append(model)
    }
    
    /// models getter
    ///
    /// - Returns: artwork model
    func getModels() -> [ArtworkModel] {
        return self.artworkModels
    }
    
    /// model getter
    ///
    /// - Parameter row: index
    /// - Returns: artwork model
    func getModel(_ index: Int) -> ArtworkModel {
        return self.artworkModels[index]
    }
    
    /// modelの数を返す
    ///
    /// - Returns: model count
    func getModelCount() -> Int {
        return self.artworkModels.count
    }
    
}
