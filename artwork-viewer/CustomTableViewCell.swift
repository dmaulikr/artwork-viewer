//
//  CustomTableViewCell.swift
//  artwork-viewer
//
//  Created by konojunya on 2017/06/28.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artworkImage: UIImageView!
    @IBOutlet weak var musicName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(_ model: ArtworkModel){
        
        self.artistName.text = model.artistName
        self.musicName.text = model.musicName
        
        let url = URL(string: model.artworkImage)
        
        self.artworkImage.image = UIImage(named: "placeholder")
        
        DispatchQueue.global(qos: .background).async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                if let imageData = data {
                    self.artworkImage.image = UIImage(data: imageData)
                }
            }
        }
    }
    
}

