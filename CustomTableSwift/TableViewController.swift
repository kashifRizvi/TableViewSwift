//
//  TableViewController.swift
//  CustomTableSwift
//
//  Created by Kashif on 17/11/16.
//  Copyright © 2016 Kashif. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var parsedData = [[String:String]]()
    var pics = [String:UIImage]()
    var studentRecords = [String:AnyObject]()
    var defaults = UserDefaults.standard
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fileUrl = Bundle.main.url(forResource: "Test", withExtension: "json")
        
        let jsonData = NSData(contentsOf: fileUrl!)
        do {
            
            parsedData = try JSONSerialization.jsonObject(with: jsonData as! Data  , options: .allowFragments) as! [[String:String]]
        } catch let error as NSError {
            print(error)
        }
        
        return parsedData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = CustomCellClass()
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCellClass
        
        let row = indexPath.row
        
        let currentCellData = parsedData[row]
        
        
        
        //        cell.tag = row
        //        cell.imageViewCell.image=nil
        //        cell.name.text = currentCellData["name"]
        //        cell.marks.text = currentCellData["marks"]
        let imgLink = currentCellData["imageUrl"]!
        let imgUrl = URL(string: imgLink)
        
        //        if let present = pics[imgLink]{
        //            cell.imageViewCell.image=present
        //        }
//        let recrd = defaults.object(forKey: "\(row)") as AnyObject?
        if let recrd = defaults.object(forKey: "\(row)") as AnyObject? {
            cell.tag = row
            cell.name.text = recrd["name"] as? String
            cell.marks.text = recrd["marks"] as? String
        }
        else{
            cell.name.text = currentCellData["name"]
            cell.marks.text = currentCellData["marks"]
            
            studentRecords["name"] = currentCellData["name"] as AnyObject?
            studentRecords["marks"] = currentCellData["marks"] as AnyObject?
            
            DispatchQueue.global().async {[weak self] in
                do {
                    let imgData = try Data(contentsOf: imgUrl!)
                    let downloadedImage = UIImage(data: imgData)
                    print(indexPath.row)
                    self?.pics[imgLink] = downloadedImage
                    self?.studentRecords[imgLink] = downloadedImage as AnyObject
                    print(self?.pics[imgLink] ?? "No Image Here!")
                    DispatchQueue.main.async {
                        print(" Cell tag : \(cell.tag)")
                        if cell.tag == row{
                            cell.imageViewCell.image=downloadedImage
                        }
                        else {
                            print("Data ignored!!")
                        }
                    }
                }
                catch{
                    
                }
            }
        }
        
        defaults.set(studentRecords, forKey: "\(row)")
        defaults.synchronize()
        
        return cell
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
