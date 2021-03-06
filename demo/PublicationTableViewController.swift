//
//  PublicationTableViewController.swift
//  demo
//
//  Created by Wen on 14.07.17.
//  Copyright © 2017 jdu. All rights reserved.
//
import UIKit
import AlpsSDK
import Alps

class PublicationTableViewController: UITableViewController {
    // MARK: Properties
    
    // An array that contains all the user's device publications
    var publications = [Publication]()
    
    // Using appDelegate as a singleton
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.appDelegate.userId != nil && self.appDelegate.deviceId != nil {
            // call the API, to retrieve all the subscriptions for current user and device
            getAllPublicationsForDevice(self.appDelegate.userId!, deviceId: self.appDelegate.deviceId!)
            self.tableView.reloadData()
        }else{
            print("ERROR in PUBLICATIONTABLEVIEWCONTROLLER: UserId or deviceId is nil.")
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
        return publications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PublicationTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PublicationTableViewCell else{
            fatalError("The dequeued cell is not an instance of PublicationTableViewCell.")
        }
        
        // Configure the cell...
        guard let pub = publications[indexPath.row] as? Publication else{
            fatalError("PublicationTableViewController error : the publication is not from a Publication class.")
        }
        
        cell.publicationIdLabel.text = pub.id!
        cell.topicLabel.text = pub.topic!
        cell.timeStampLabel.text = transformTimestampToDate(timestamp: pub.createdAt!)
        cell.durationLabel.text = String(describing: pub.duration!)
        
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
    
     // MARK: - Navigation
     
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Detail" {
            // Show the details of a match
            if let dVC = segue.destination as? DetailViewController{
                if let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell){
                    dVC.publication = publicationAtIndexPath(indexPath: indexPath as NSIndexPath)
                }
            }
            
        }
    }
    
    //MARK: HELPER method
    
    // Get the publication at index in publications array
    func publicationAtIndexPath(indexPath: NSIndexPath) -> Publication{
        let publication = publications[indexPath.row]
        return publication
    }
    
    // Use this function to transform timestampe to local date displayed in String
    func transformTimestampToDate(timestamp : Int64) -> String {
        let dateTimeStamp = NSDate(timeIntervalSince1970:Double(timestamp)/1000)  //UTC time
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local //Edit
        dateFormatter.dateFormat = "MMM dd YYYY hh:mm a"
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateFormatter.timeStyle = DateFormatter.Style.short
        let strDateSelect = dateFormatter.string(from: dateTimeStamp as Date)
        
        return strDateSelect
    }
    
    //MARK: Action
    @IBAction func unwindToPublicationList(sender: UIStoryboardSegue) {
    }
    
    //MARK: AlpsSDK Functions
    
    // Calls the SDK to get all publications for specified userId and deviceId
    func getAllPublicationsForDevice(_ userId:String, deviceId: String) {
        self.appDelegate.alps.getAllPublicationsForDevice(userId, deviceId: deviceId) {
            (_ publications) in
            self.publications = publications
            self.tableView.reloadData()
        }
    }
}
