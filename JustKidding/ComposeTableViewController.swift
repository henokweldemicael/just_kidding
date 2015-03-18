//
//  ComposeTableViewController.swift
//  JustKidding
//
//  Created by Henok Weldemicael on 3/15/15.
//  Copyright (c) 2015 Henok WeldeMicael. All rights reserved.
//

import UIKit
import Parse

class ComposeTableViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet var entryTextView: UITextView! = UITextView()
    
    @IBOutlet var charRemaining: UILabel! = UILabel()
    
    /*required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func sendEntry(sender: AnyObject) {
        
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            // Do stuff with the user
            
            //Create Joke object and set initial values
            
            var joke = PFObject(className: "Jokes")
            joke["isOnStage"] = false
            joke["joke"] = entryTextView.text
            joke["redFlags"] = 0
            joke["likersArray"] = []
            joke["dislikersArray"] = []
            joke["senderId"] = currentUser.objectId
            joke["senderName"] = currentUser.username
            joke.saveInBackgroundWithBlock {
                (success: Bool, error: NSError!) -> Void in
                if (success) {
                    // The entry has been saved
                    println("Joke Saved!")
                } else {
                    // There was a problem, check error.description
                    println(error)
                }
            }
            
            self.navigationController?.popToRootViewControllerAnimated(true)
            
            
        } else {
            // Show the signup or login screen
        }
    }
  
    
    func textView(textView:UITextView!, shouldChangeTextInRange range:NSRange, replacementText text: String!) -> Bool{
        
        var newLength:Int = (textView.text as NSString).length + (text as NSString).length - range.length
        var remainingChar:Int = 240 - newLength
        
        charRemaining.text = "\(remainingChar)"
        
        return (newLength > 240) ? false : true
    }

    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
