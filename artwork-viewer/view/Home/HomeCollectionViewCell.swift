//
//  HomeCollectionViewCell.swift
//  artwork-viewer
//
//  Created by konojunya on 2017/06/30.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    //MARK: - outlet
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(_ imageName: String){
        
        if let imageData = UIImage(named: imageName) {
            self.imageView.image = imageData
        }
        
    }
    
}
