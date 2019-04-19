//
//  TakenLibArtController.swift
//  SchedulerIOS
//
//  Created by Jerrod Sunderland on 2/19/19.
//  Copyright © 2019 Sundy Studio's. All rights reserved.
//

import Foundation
import UIKit

class TakenLibArtController: UIViewController {
    
    var data = DataController()
    var lcourses: [LCourses] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lcourses = data.getLib()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.lcoursecell", for: indexPath)
        cell.textLabel?.text = lcourses[indexPath.row].Title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lcourses.count
    }
}
