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
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - collection delegate method
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.artworks.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeCollectionViewCell
        
        cell.setCell(self.artworks[indexPath.row])
        
        return cell
        
    }
    
}
