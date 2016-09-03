//
//  Tab3VC.swift
//  LocationManager
//
//  Created by Dmytro Bohachevskyy on 9/3/16.
//  Copyright © 2016 Dmytro Bohachevskyy. All rights reserved.
//

import UIKit
import RealmSwift

class Tab3VC: UITableViewController {
    // MARK : utils
    let realm = try! Realm()
    let dateFormat = NSDateFormatter()
    
    // MARK : data
    var data : Results<Record>!
    var token : NotificationToken!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // se style for date
        dateFormat.timeStyle = .LongStyle
        dateFormat.dateStyle = .LongStyle
        
        // get data from database
        data = realm.objects(Record).sorted("date")
        token = data.addNotificationBlock { _ in
            self.tableView.reloadData()
        }
    }
    
    
    // MARK : UITableViewDataSource implementation
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        cell.textLabel!.text = dateFormat.stringFromDate(data[indexPath.row].date!)
        return cell
    }
}
