//
//  EmojiListViewController.swift
//  iOS-Slack-API-Example
//
//  Created by WataruSuzuki on 2017/07/01.
//  Copyright © 2017年 WataruSuzuki. All rights reserved.
//

import UIKit
import SlackKit
import SwiftyJSON

class EmojiListViewController: UITableViewController {
    
    let slack = SlackKitHelpers.instance
    var emojiJson: JSON!
    var emojiNameList = Array<String>()
    var emojiUrlList = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        emojiJson = JSON(slack.emojiResponse)
        for (key,subJson):(String, JSON) in emojiJson {
            print("key = \(key)")
            emojiNameList.append(key)
            print("subJson = \(subJson)")
            emojiUrlList.append(subJson.stringValue)
        }
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
        return slack.emojiResponse.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiListViewCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = emojiNameList[indexPath.row]
        let emojiUrl = getEmojiUrlStr(originalUrlStr: emojiUrlList[indexPath.row])
        DispatchQueue.global(qos: .default).async {
            if let url = URL(string: emojiUrl) {
                do {
                    let data = try Data(contentsOf: url)
                    let image = UIImage(data: data)
                    DispatchQueue.main.async(execute: {
                        cell.imageView?.image = image
                        cell.layoutSubviews()
                    })
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }

        return cell
    }
    
    func getEmojiUrlStr(originalUrlStr: String) -> String {
        if originalUrlStr.hasPrefix("http") {
            return originalUrlStr
        }
        let aliasStr = originalUrlStr.replacingOccurrences(of: "alias:", with: "")
        for (index, key) in emojiNameList.enumerated() {
            if key == aliasStr {
                return emojiUrlList[index]
            }
        }
        return "http://emoji.fileformat.info/gemoji/" + aliasStr  + ".png"
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
