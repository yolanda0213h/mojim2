//
//  SecondViewController.swift
//  mojimAPI
//
//  Created by Yolanda H. on 2019/8/15.
//  Copyright © 2019 Yolanda H. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var singer:String?
    var number:Int?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lyricLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // key9
         if let urlStr = String( "https://www.googleapis.com/customsearch/v1?cx=014436186619858147575:7btb6tfbffm&key=AIzaSyC6nxpw0jRP9c9vd_oKScmbWmSLUeN7xJw&q=" + singer! + "&siteSearch=mojim.com").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        {
                    
                    if let url = URL(string: urlStr) {
                    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                        let decoder = JSONDecoder()
                        if let data = data, let mojimJson = try? decoder.decode(Mojim.self, from: data){
                            let song = mojimJson.items[self.number!].title
                            let songName = song.components(separatedBy: "歌詞")
                            let lyric = mojimJson.items[self.number!].snippet
                            DispatchQueue.main.async {
                                self.titleLabel.text = songName[0] + " " + self.singer!
                                self.lyricLabel.text = lyric
                                }
                        }
                    }
                    task.resume()
                        }
                }
       
    }


}

