//
//  MinorController.swift
//  SchedulerIOS
//
//  Created by Jerrod Sunderland on 2/19/19.
//  Copyright © 2019 Sundy Studio's. All rights reserved.
//

import Foundation
import UIKit

class MinorController: UITableViewController {
    
    var data = DataController()
    var minors: [Minor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        minors = data.getMinor()
        //courses = data.getMM(MajorType: true)
        
        // MajorTable.dataSource = self
        // MajorTable.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.minorcell", for: indexPath)
        cell.textLabel?.text = minors[indexPath.row].MMName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return minors.count
    }
    
    
}
