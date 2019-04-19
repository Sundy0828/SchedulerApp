//
//  TakenMMController.swift
//  SchedulerIOS
//
//  Created by Jerrod Sunderland on 2/19/19.
//  Copyright © 2019 Sundy Studio's. All rights reserved.
//

import Foundation
import UIKit

class TakenMMController: UIViewController {
    
    var data = DataController()
    var mcourses: [MMCourses] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mcourses = data.getCourses()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.mcoursecell", for: indexPath)
        cell.textLabel?.text = mcourses[indexPath.row].Title
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mcourses.count
    }
}
