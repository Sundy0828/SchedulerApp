//
//  MajorController.swift
//  SchedulerIOS
//
//  Created by Jerrod Sunderland on 2/19/19.
//  Copyright © 2019 Sundy Studio's. All rights reserved.
//

import Foundation
import UIKit

class MajorController: UITableViewController {
    
    var data = DataController()
    var majors: [Major] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        majors = data.getMajor()
        //courses = data.getMM(MajorType: true)
        
        // MajorTable.dataSource = self
        // MajorTable.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.majorcell", for: indexPath)
        cell.textLabel?.text = majors[indexPath.row].MMName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return majors.count
    }
    
    
}
