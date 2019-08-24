//
//  ManLyricsTableViewController.swift
//  mojimAPI
//
//  Created by Yolanda H. on 2019/8/21.
//  Copyright © 2019 Yolanda H. All rights reserved.
//

import UIKit

class ManLyricsTableViewController: UITableViewController {

    let singerMen = ["張棟樑","林俊傑","陳奕迅"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return singerMen.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return 10
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return singerMen[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menSongsCell", for: indexPath)
        if let urlStr = String( "https://www.googleapis.com/customsearch/v1?cx=014436186619858147575:7btb6tfbffm&key=AIzaSyAOcDnMK-PHKvUjkM3ACB0qne2WT8pGoHY&q=" + singerMen[indexPath.section] + "&siteSearch=mojim.com").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        {
                    
                    if let url = URL(string: urlStr) {
                    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                        let decoder = JSONDecoder()
                        if let data = data, let mojimJson = try? decoder.decode(Mojim.self, from: data){
                            let songs = mojimJson.items[indexPath.row].title
                            let songName = songs.components(separatedBy: "歌詞")
                            DispatchQueue.main.async {
                                if songs.contains("收藏"){
                                    cell.removeFromSuperview()
                                    
                                }else{
                                cell.textLabel?.text = songName[0]
                                }
                            }
                            
                        }
                    }
                    task.resume()
                        }
                    }
                    
        
        return cell
    }
    

    @IBSegueAction func menSongLyric(_ coder: NSCoder) -> SecondViewController? {
        let indexPath = self.tableView.indexPathForSelectedRow
        let cellID = indexPath?.row
        let sectionID:Int = indexPath!.section
        
        let controller = SecondViewController(coder: coder)
        controller?.number = cellID
        controller?.singer = singerMen[sectionID]
        return controller
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
