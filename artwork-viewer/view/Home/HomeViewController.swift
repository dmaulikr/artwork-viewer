//
//  HomeViewController.swift
//  artwork-viewer
//
//  Created by konojunya on 2017/06/30.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {

    //MARK: - outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField!
    @IBAction func searchButton(_ sender: UIButton) {
        self.moveView()
    }
    
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
    var aCollectionCellWidth:CGFloat{
        get { return CGFloat(self.artworks.count)*150 }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.textField.delegate = self
        
        self.collectionView.contentOffset.x = aCollectionCellWidth
        self.scrollAnimation()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    //MARK: - perform segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listView" {
            guard let listViewController = segue.destination as? ListViewController else { return }
            
            if let text = self.textField.text {
                listViewController.searchArtistName = text
            }else{
                listViewController.searchArtistName = "AAA"
            }

        }
    }
    
    // keyboard close
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.textField.resignFirstResponder()
        
        self.moveView()
        
        return true
    }
    
    // 範囲外をタップしたらキーボード下ろす
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.textField.isFirstResponder {
            self.textField.resignFirstResponder()
        }
    }
    
    func moveView(){
        
        if self.textField.text == "" {
            
            let alert = UIAlertController(title: "アーティスト名を\n入力してください。", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            
            return
        }
        
        performSegue(withIdentifier: "listView", sender: self)
    }
}
