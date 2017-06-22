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
    
    var artistData:[[String:String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.fetchArtistData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchArtistData(){
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
                let results = json["results"] as! [[String:String]]
                for result in results.enumerated() {
                    self.artistData.append([
                        "trackName": result.element["trackName"]!,
                        "artistName": result.element["artistName"]!,
                        "artworkUrl": result.element["artworkUrl100"]!
                    ])
                }
            },
            fail: { error in
                print(error)
            }
        )
    }
    
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(_ data: [String:String]){
        let url = URL(string: data["artworkUrl"]!)
        guard let imageData = try? Data(contentsOf: url!) else { return }
        
        self.artworkImage.image = UIImage(data: imageData)
        self.artistName.text = data["artistName"]
        self.musicName.text = data["trackName"]
    }
    
}

