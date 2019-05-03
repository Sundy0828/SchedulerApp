//
//  FinalScheduleController.swift
//  SchedulerIOS
//
//  Created by Jerrod Sunderland on 2/19/19.
//  Copyright © 2019 Sundy Studio's. All rights reserved.
//

import Foundation
import UIKit

class FinalScheduleController: UITableViewController {
    
    let data = DataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        finalSchedule = data.getFinalSchedule()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (finalSchedule[section].courses?.count)!
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 28/255, green: 36/255, blue: 41/255, alpha: 1)
        
        let screenSize = UIScreen.main.bounds.width
        
        let label = UILabel()
        label.text = finalSchedule[section].semester! + " " + finalSchedule[section].year!
        label.textColor = UIColor.white
        label.frame = CGRect(x: 5, y: 5, width: screenSize - 5, height: 35)
        view.addSubview(label)
        
        return view
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return finalSchedule.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "finalScheduleCell")
        let schedule = finalSchedule[indexPath.section].courses![indexPath.row]
        cell?.textLabel?.text = schedule.Title
        var credits = ""
        if let item = schedule.Credits {
            credits = String(item)
        }
        cell?.detailTextLabel?.text = "Course Code: " + schedule.getCode() + " Credits: " + credits
        return cell!
    }
    
    
}
