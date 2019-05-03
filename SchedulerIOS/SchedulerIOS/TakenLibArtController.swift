//
//  TakenLibArtController.swift
//  SchedulerIOS
//
//  Created by Jerrod Sunderland on 2/19/19.
//  Copyright © 2019 Sundy Studio's. All rights reserved.
//

import Foundation
import UIKit

class TakenLibArtController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var libArtTbl: UITableView!
    
    let data = DataController()
    var taken: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        taken = data.getCourses(CourseType: false)
        for i in 0..<taken.count {
            libArtTaken[taken[i]] = false
        }
        
        libArtTbl.dataSource = self
        libArtTbl.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libArtTaken.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = libArtTbl.dequeueReusableCell(withIdentifier: "libArtCell")
        let key = Array(libArtTaken.keys)[indexPath.row]
        cell?.textLabel?.text = key.Title
        cell?.detailTextLabel?.text = key.getCode()
        return cell!
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let key = Array(libArtTaken.keys)[indexPath.row]
        let value = Array(libArtTaken.values)[indexPath.row]
        if !value {
            let editAction = UITableViewRowAction(style: .normal, title: "Taken") { (rowAction, indexPath) in
                //TODO: edit the row at indexPath here
                let cell = tableView.cellForRow(at: indexPath)
                //cell?.backgroundColor = .green
                cell?.accessoryType = .checkmark
                libArtTaken[key] = true
            }
            editAction.backgroundColor = .green
            return [editAction]
        }else {
            let editAction = UITableViewRowAction(style: .normal, title: "Not Taken") { (rowAction, indexPath) in
                //TODO: edit the row at indexPath here
                let cell = tableView.cellForRow(at: indexPath)
                //cell?.backgroundColor = .white
                cell?.accessoryType = .none
                libArtTaken[key] = false
            }
            editAction.backgroundColor = .gray
            return [editAction]
        }
        
        
    }
    
    
}
