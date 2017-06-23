//
//  ViewController.swift
//  artwork-viewer
//
//  Created by konojunya on 2017/06/21.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ActivityIndicator:UIActivityIndicatorView? = nil
    
    var artistData:[[String:String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.ActivityIndicator = {
            let ActivityIndicator = UIActivityIndicatorView()
            ActivityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            ActivityIndicator.center = self.view.center
            ActivityIndicator.hidesWhenStopped = true
            ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            self.view.addSubview(ActivityIndicator)
            
            return ActivityIndicator
        }()
        
        self.fetchArtistData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// アーティストデータを取得する
    func fetchArtistData(){
        
        self.ActivityIndicator?.startAnimating()
        
        let params = [
            "term": "AAA",
            "media": "music",
            "entity": "musicTrack",
            "country": "jp",
            "lang": "ja_JP"
        ]
        
        let ra = RequestAgent(url: "https://itunes.apple.com", method: "get", path: "/search", data: params)
        ra.run(
            success: { json in
                let results = json["results"] as! [[String : AnyObject]]
                for result in results.enumerated() {
                    self.artistData.append([
                        "trackName": result.element["trackName"]! as! String,
                        "artistName": result.element["artistName"]! as! String,
                        "artworkUrl": result.element["artworkUrl100"]! as! String
                        ])
                }
                self.tableView.reloadData()
                self.ActivityIndicator?.stopAnimating()
            },
            fail: { error in
                print(error)
            }
        )
    }
    
    //MARK: - tableView delegate method
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artistData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.setCell(self.artistData[indexPath.row])
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hoge")
    }
    
}

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artworkImage: UIImageView!
    @IBOutlet weak var musicName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(_ data: [String:String]){
        
        self.artistName.text = data["artistName"]
        self.musicName.text = data["trackName"]
        
        let url = URL(string: "http://i.imgur.com/w5rkSIj.jpg")
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            self.artworkImage.image = UIImage(data: imageData)
        }
    }
    
}

