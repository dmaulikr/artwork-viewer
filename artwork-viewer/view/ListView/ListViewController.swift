//
//  ViewController.swift
//  artwork-viewer
//
//  Created by konojunya on 2017/06/21.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import UIKit
import Foundation
import APIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - outlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - variable
    var ActivityIndicator:UIActivityIndicatorView? = nil
    var musicModels:MusicModels = MusicModels()
    
    var searchArtistName:String? = nil
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.navigationItem.title = self.searchArtistName
        
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// アーティストデータを取得する
    func fetchArtistData(){
        
        self.ActivityIndicator?.startAnimating()
        
        let request = FetchArtworkRequest(
            term: self.searchArtistName!,
            media: "music",
            entity: "musicTrack",
            country: "jp",
            lang: "ja_JP"
        )
        Session.send(request) { result in
            switch result {
            case .success(let musicModels):
                if musicModels.getCount() == 0 {
                    self.buildNoResultView()
                }else{
                    self.musicModels = musicModels
                    self.tableView.reloadData()
                }
                self.ActivityIndicator?.stopAnimating()
            case .failure(let error):
                print("error: \(error)")
            }
        }
        
    }
    
    func buildNoResultView(){
        
        let view  = Bundle.main.loadNibNamed("NoResultView", owner: self, options: nil)?.first as! UIView
        view.frame = self.view.bounds
        view.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
        self.view.addSubview(view)
        
    }
    
    //MARK: - tableView delegate method
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.musicModels.getCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListViewCell
        
        cell.setCell(self.musicModels.getMusic(indexPath.row))
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hoge")
    }
    
}
