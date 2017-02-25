//
//  ChatViewController.swift
//  Chatr
//
//  Created by Enzo Ames on 2/23/17.
//  Copyright © 2017 Enzo Ames. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    //|||||||||||||||||||||||||||||||||||||||||||||||||
    //|||||||||||OUTLETS AND VARIABLES|||||||||||||||||
    //|||||||||||||||||||||||||||||||||||||||||||||||||
    
    @IBOutlet weak var messageField: UITextField!

    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject] = []
    
    @IBAction func onTapSend(_ sender: Any)
    {
        let message = PFObject(className:"Message")
        message["text"] = messageField.text!
        message["user"] = PFUser.current()
        
        message.saveInBackground { (success: Bool, error: Error?) in
            if(success)
            {
                print("message:  \(self.messageField.text!)")
            }
            else
            {
                print("error in message:")
            }
        }
    }

    //||||||||||||||||||||||||||||||||||||||||||
    //|||||||||||VIEW DID LOAD||||||||||||||||||
    //||||||||||||||||||||||||||||||||||||||||||
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //refresh text every one second
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(pullMessages), userInfo: nil, repeats: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //|||||||||||||||||||||||||||||||||||||||||||||||||
    //|||||||||||TABLE VIEW FUNCTIONS||||||||||||||||||
    //|||||||||||||||||||||||||||||||||||||||||||||||||
   
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.messages.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        let message = self.messages[indexPath.row]

        if let text = message["text"] as? String {
            cell.textLabel?.text = text
        }
        
        if let user = message["user"] as? String {
            cell.UserLabel.isHidden = false
            cell.UserLabel.text = user
        } else {
            //cell.userLabel.isHidden = true
        }
        
        return cell
    }
    
    
    func pullMessages()
    {
        let query = PFQuery(className: "Message").includeKey("user")
            
        //SORTING QUERY
        query.order(byDescending: "createdAt")
    
        query.findObjectsInBackground
        {
            (messages: [PFObject]?, error: Error?) in
            if error == nil
            {
                // the find succeeded
                print("Successfully retrieved \(messages!.count) messages.")
                    
                // do something with the found objects
                if let messages = messages
                {
                    self.messages = messages
                    print("Messages updated!")
                    self.tableView.reloadData()
                    print(messages)
                }
                else
                {
                    print("Error: \(error!)")
                }
            }
        }
    
    }
    
    


}








