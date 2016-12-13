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
        
        cell.tag = row
        cell.imageViewCell.image=nil
        cell.name.text = currentCellData["name"]
        cell.marks.text = currentCellData["marks"]
        let imgLink = currentCellData["imageUrl"]!
        let imgUrl = URL(string: imgLink)
        
        print(" Cell tag in main thread  : \(cell.tag)")
        print(" Row variable in main thread : \(row)")
        
        if let present = pics[imgLink]{
            cell.imageViewCell.image=present
            
        }else{
            cell.name.text = currentCellData["name"]
            cell.marks.text = currentCellData["marks"]
            
            DispatchQueue.global().async { [weak self] in
                do {
                    //                    print(" Cell tag in global thread before fetching : \(cell.tag)")
                    //                    print(" Row variable in global before fetching thread : \(row)")
                    let imgData = try Data(contentsOf: imgUrl!)
                    let downloadedImage = UIImage(data: imgData)
                    //                    print(" Cell tag in global thread after fetching : \(cell.tag)")
                    //                    print(" Row variable in global thread after fetching : \(row)")
                    self?.pics[imgLink] = downloadedImage
                    DispatchQueue.main.async {
                        //                        print(" Cell tag in main in global thread : \(cell.tag)")
                        //                        print(" Row variable in main in global thread : \(row)")
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
