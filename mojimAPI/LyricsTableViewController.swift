//
//  LyricsTableViewController.swift
//  mojimAPI
//
//  Created by Yolanda H. on 2019/8/15.
//  Copyright © 2019 Yolanda H. All rights reserved.
//

import UIKit

class LyricsTableViewController: UITableViewController {

    
    let singerLady = ["梁靜茹","戴佩妮","蔡依林"]
    var mojimItems:[Item?] = []
    
    let key = "AIzaSyC6nxpw0jRP9c9vd_oKScmbWmSLUeN7xJw"
    //key 9
    var lyricGroup:[Lyrics?] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // API
        for i in 0...singerLady.count-1 {
        if let urlStr = String( "https://www.googleapis.com/customsearch/v1?cx=014436186619858147575:7btb6tfbffm&key=\(key)&q=\(singerLady[i])&siteSearch=mojim.com").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        {
                    
                    if let url = URL(string: urlStr) {
                    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                        let decoder = JSONDecoder()
                        if let data = data, let mojimJson = try? decoder.decode(Mojim.self, from: data){
                            print(mojimJson.items.count)
                            
                            for j in 0...mojimJson.items.count-1 {
                                self.mojimItems.append(mojimJson.items[j])
                                
                                let songs = mojimJson.items[j].title
                                let lyrics = mojimJson.items[j].snippet
                                self.lyricGroup.append(Lyrics(singer: self.singerLady[i], song: songs, lyric: lyrics, sectionID: i, rowID: j))
                            }
                            print(url)
                            
                        }
                        print(self.lyricGroup[2]?.rowID)
                        print(self.lyricGroup[2]?.song)
                        print(self.mojimItems[2]?.title)
                        print(self.mojimItems.count)
                    }
                    task.resume()
                        }
            }}
        
    }

    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return singerLady.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
     
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return singerLady[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ladySongsCell", for: indexPath)
        
        //cell.textLabel?.text = mojimItems[indexPath.row]?.title
        //DispatchQueue.main.async {
        
        //}
        
        return cell
    }
    @IBSegueAction func ladySongs(_ coder: NSCoder) -> SecondViewController? {
        let indexPath = self.tableView.indexPathForSelectedRow
        let cellID:Int = self.tableView.indexPathForSelectedRow!.row
        let sectionA:Int = indexPath!.section
        let controller = SecondViewController(coder: coder)
        controller?.number = cellID
        controller?.singer = singerLady[sectionA]
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
