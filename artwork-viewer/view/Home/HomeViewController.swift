//
//  HomeViewController.swift
//  artwork-viewer
//
//  Created by konojunya on 2017/06/30.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    //MARK: - outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - variable
    let artworks:[String] = [
        "aaa-goldSymphony","aaa-koioto","aaa-lil","aaa-love","aaa-sailing","aaa-wakeUp","aaa-wayOfGlory",
        "daoki-girl",
        "lmfao-partyRockAnthem",
        "nissy-hanacherie","nissy-neverstop",
        "reol-notitle","reol-sigma",
        "yonezu-bremen","yonezu-flowerWall","yonezu-loser","yonezu-madHeadLove","yonezu-orion","yonezu-unbrlievers","yonezu-yankee",
        "yourname"
    ]
    private var aCollectionCellWidth:CGFloat{
        get { return CGFloat(self.artworks.count)*150 }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.contentOffset.x = aCollectionCellWidth
        self.scrollAnimation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollAnimation(){
        
        UIView.animate(withDuration: 0.05, animations: {
            
            self.collectionView.contentOffset.x = self.collectionView.contentOffset.x + 1
            
        }, completion: { finished in
            self.scrollAnimation()
        })
        
    }
    
    //MARK: - collection delegate method
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.artworks.count * 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeCollectionViewCell
        
        let fixedIndex = NSIndexPath(row: indexPath.row%self.artworks.count, section: 0)
        
        cell.setCell(self.artworks[fixedIndex.row])
        
        return cell
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x <= 0 || (scrollView.contentOffset.x >= aCollectionCellWidth * 2.0) {
            scrollView.contentOffset.x  = aCollectionCellWidth
        }
    }
}
