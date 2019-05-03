//
//  FinalScheduleController.swift
//  SchedulerIOS
//
//  Created by Jerrod Sunderland on 2/19/19.
//  Copyright © 2019 Sundy Studio's. All rights reserved.
//

import Foundation
import UIKit

class FinalScheduleController: UIViewController {
<<<<<<< Updated upstream
    var data = DataController()
    override func viewDidLoad() {
        super.viewDidLoad()
        data.getFinalSchedule(schoolID: schoolID, majors: majors)
=======
    
    var data = DataController()
    var schedule: [Semester] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        schedule = data.getFinalSchedule()
>>>>>>> Stashed changes
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //func tableView(_ tableView: UITableView, cellForRowAt indexpath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.finalschedulecell", for: indexPath)
        //cell.textLabel?.text = schedule[IndexPath.row].
        //return cell}
    
    //func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return schedule.count}
    
}
