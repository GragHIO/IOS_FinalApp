//
//  SongDetailViewController.swift
//  myFinalApp
//
//  Created by user_09 on 2017/6/14.
//  Copyright © 2017年 GragHIO. All rights reserved.
//

import UIKit

class SongDetailViewController: UIViewController {
    var songs = [String:String]()
    
    @IBAction func addFavoriteList(_ sender: Any) {
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory,
                             in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("FavoriteList.txt")
        
        var likeDic=[[String:String]]()
        
        do{
            let content = try String(contentsOf: url!, encoding: String.Encoding.utf8)
            for line in content.components(separatedBy: "\r\n"){
                if(line.contains("\t")){
                    let s = line.components(separatedBy: "\t")
                    likeDic.append(["idolName":s[0].decomposedStringWithCanonicalMapping,"songName":s[1].decomposedStringWithCanonicalMapping,"type":s[2]])
                }
            }
        }
        catch{
            return
        }
        for dic in likeDic{
            if(dic["idolName"]?.decomposedStringWithCanonicalMapping == songs["idolName"]){
                let controller = UIAlertController(title: "", message: "已加入我的最愛", preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in})
                controller.addAction(action)
                present(controller, animated: true, completion: nil)
                
                return
            }
        }

        likeDic.append(songs)
        print(likeDic)
        do{
            var s = ""
            for dic in likeDic{
                s += dic["idolName"]! + "\t"
                s += dic["songName"]! + "\t"
                s += dic["type"]! + "\r\n"
            }
            try s.write(to: url!, atomically: false, encoding: String.Encoding.utf8)
            } catch {
            return
        }
    }

    @IBOutlet weak var idolImg: UIImageView!
    @IBOutlet weak var lyrics: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        idolImg.image = UIImage(named:songs["idolName"]!+"_小立")
        idolImg.alpha = 0.5
        if let asset = NSDataAsset(name: songs["songName"]!), let contents = String(data: asset.data, encoding: String.Encoding.utf8){
            lyrics.text = contents
        }
        self.title = songs["songName"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
