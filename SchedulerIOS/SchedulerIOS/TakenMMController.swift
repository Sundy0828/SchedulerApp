//
//  TakenMMController.swift
//  SchedulerIOS
//
//  Created by Jerrod Sunderland on 2/19/19.
//  Copyright © 2019 Sundy Studio's. All rights reserved.
//

import Foundation
import UIKit

class TakenMMController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var takenMM: UITableView!
    
    let data = DataController()
    var taken: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        taken = data.getCourses(CourseType: true)
        for i in 0..<taken.count {
            mmTaken[taken[i]] = false
        }
        
        takenMM.dataSource = self
        takenMM.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mmTaken.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = takenMM.dequeueReusableCell(withIdentifier: "mmTaken")
        let key = Array(mmTaken.keys)[indexPath.row]
        cell?.textLabel?.text = key.Title
        cell?.detailTextLabel?.text = key.getCode()
        return cell!
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let key = Array(mmTaken.keys)[indexPath.row]
        let value = Array(mmTaken.values)[indexPath.row]
        if !value {
            let editAction = UITableViewRowAction(style: .normal, title: "Taken") { (rowAction, indexPath) in
                //TODO: edit the row at indexPath here
                let cell = tableView.cellForRow(at: indexPath)
                //cell?.backgroundColor = .green
                cell?.accessoryType = .checkmark
                mmTaken[key] = true
            }
            editAction.backgroundColor = .green
            return [editAction]
        }else {
            let editAction = UITableViewRowAction(style: .normal, title: "Not Taken") { (rowAction, indexPath) in
                //TODO: edit the row at indexPath here
                let cell = tableView.cellForRow(at: indexPath)
                //cell?.backgroundColor = .white
                cell?.accessoryType = .none
                mmTaken[key] = false
            }
            editAction.backgroundColor = .gray
            return [editAction]
        }
        
        
    }
    
    
}
