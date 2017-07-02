//
//  HomeViewControllerAnimation.swift
//  artwork-viewer
//
//  Created by konojunya on 2017/07/02.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import UIKit

extension HomeViewController {
    
    func scrollAnimation(){
        
        UIView.animate(withDuration: 0.05, animations: {
            
            self.collectionView.contentOffset.x = self.collectionView.contentOffset.x + 1
            
        }, completion: { finished in
            self.scrollAnimation()
        })
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x <= 0 || (scrollView.contentOffset.x >= aCollectionCellWidth * 2.0) {
            scrollView.contentOffset.x  = aCollectionCellWidth
        }
    }
    
}
