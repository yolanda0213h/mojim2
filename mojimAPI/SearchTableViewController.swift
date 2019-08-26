//
//  SearchTableViewController.swift
//  mojimAPI
//
//  Created by Yolanda H. on 2019/8/25.
//  Copyright © 2019 Yolanda H. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var mojimSearchController: UISearchController?
    
    
    func settingSeachController(){
        mojimSearchController = UISearchController(searchResultsController: nil)
        mojimSearchController?.searchResultsUpdater = self
        tableView.tableHeaderView = mojimSearchController?.searchBar
        mojimSearchController?.searchBar.placeholder = "請輸入歌手名字"
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        settingSeachController()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if mojimSearchController?.searchBar.text != ""  {
            return 10
            
        }else {
            print("0")
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        if (mojimSearchController?.isActive)! {
            
            if let text = mojimSearchController?.searchBar.text {
            //key12
            if let urlStr = String( "https://www.googleapis.com/customsearch/v1?cx=014436186619858147575:7btb6tfbffm&key=AIzaSyBtNc0oj8yk1jb5BcNkRCzipWwkTFvyGDY&q=" + text + "&siteSearch=mojim.com").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                
                if let url = URL(string: urlStr) {
                
                    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                        let decoder = JSONDecoder()
                        if let data = data, let mojimJson = try? decoder.decode(Mojim.self, from: data){
                            let songs = mojimJson.items[indexPath.row].title
                            let songName = songs.components(separatedBy: "歌詞")

                            DispatchQueue.main.async {
                                /*if songName[0].contains("收藏") {
                                    cell.removeFromSuperview()
                                   
                                }else {
                                cell.textLabel?.text = songName[0]
                                }*/
                                cell.textLabel?.text = songName[0]

                            }
                          }
                    }
                    task.resume()
                }
            }
            }}
        

        return cell
    }
    @IBSegueAction func searchDetail(_ coder: NSCoder) -> SecondViewController? {
        let cellID = self.tableView.indexPathForSelectedRow?.row
        let controller = SecondViewController(coder: coder)
        controller?.singer = mojimSearchController?.searchBar.text
        controller?.number = cellID
        return controller
    }
    func updateSearchResults(for searchController: UISearchController) {
        
        tableView.reloadData()
        
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
