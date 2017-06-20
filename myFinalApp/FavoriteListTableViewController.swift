//
//  FavoriteListTableViewController.swift
//  myFinalApp
//
//  Created by user_09 on 2017/6/15.
//  Copyright © 2017年 GragHIO. All rights reserved.
//

import UIKit

class FavoriteListTableViewController: UITableViewController {
    var songs = [[String:String]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory,
                             in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("FavoriteList.txt")
        do{
            let content = try String(contentsOf: url!, encoding: String.Encoding.utf8)
            for line in content.components(separatedBy: "\r\n"){
                if(line.contains("\t")){
                    let s = line.components(separatedBy: "\t")
                    songs.append(["idolName":s[0].decomposedStringWithCanonicalMapping,"songName":s[1].decomposedStringWithCanonicalMapping,"type":s[2]])
                }
            }
        }
        catch{
            return
        }

                print(songs)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory,
                             in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("FavoriteList.txt")
        let list = songs
        do{
            songs.removeAll()
            let content = try String(contentsOf: url!, encoding: String.Encoding.utf8)
            for line in content.components(separatedBy: "\r\n"){
                if(line.contains("\t")){
                    let s = line.components(separatedBy: "\t")
                    songs.append(["idolName":s[0].decomposedStringWithCanonicalMapping,"songName":s[1].decomposedStringWithCanonicalMapping,"type":s[2]])
                }
            }
        }
        catch{
            songs = list
        }
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return songs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteListTableViewCell
        
        let dic = songs[indexPath.row]
        cell.songImg.image = UIImage(named: dic["idolName"]!+"_專輯")
        cell.songName.text = dic["songName"]
        switch dic["type"]{
        case "cute"?:
            cell.backgroundColor = UIColor(red: CGFloat(255.0/255.0), green: (188.0/255.0), blue: (228.0/255.0), alpha: (1.0))
            break
        case "cool"?:
            cell.backgroundColor = UIColor(red: CGFloat(207.0/255.0), green: (241.0/255.0), blue: (255.0/255.0), alpha: (1.0))
            break
        case "passion"?:
            cell.backgroundColor = UIColor(red: CGFloat(255.0/255.0), green: (245.0/255.0), blue: (242.0/255.0), alpha: (1.0))
            break
        default: break
        }

        // Configure the cell...

        return cell
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        let controller = segue.destination as! SongDetailViewController
        controller.songs = songs[indexPath!.row]
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            songs.remove(at: indexPath.row)
            saveList()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 
    func saveList(){
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory,
                             in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("FavoriteList.txt")
       
        
        do{
            var s = ""
            for dic in songs{
                s += dic["idolName"]! + "\t"
                s += dic["songName"]! + "\t"
                s += dic["type"]! + "\r\n"
            }
            try s.write(to: url!, atomically: false, encoding: String.Encoding.utf8)
        } catch {
            return
        }

    }
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
