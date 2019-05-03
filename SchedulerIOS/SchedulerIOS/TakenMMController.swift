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
    
    let coursename = ["SCS 116: Computer Ethics and Society", "SCS 132: Prog 1: Intro to Development", "SCS 135: Exper with Comp & IT Professionals", "SCS 141: Prog 2: Mobile App Development", "SCS 212: Systems Programming", "SCS 215: Unix Concepts and Programming", "SCS 225: Exper with Computer Systems Admin", "SCS 230: Database Management Systems", "SCS 250: Programming Languages", "SCS 270: Computer Forensics Desktop & Mobile", "SCS 275: Comp Security Networks & Mobile", "SCS 290: App Dev with Data Structures", "SCS 301: Analysis of Mobile Software Systems", "SCS 321: Operating Systems", "SCS 341: Algorithms Analysis", "SCS 374: Software Engineering for Mobile Sys", "SCS 390: Select Topics in Computer Science", "SCS 400: Computer Systems Research/ Seminar", "SCS 430: Internship", "SCY 391: Computer Networks Wired & Wireless", "SMA 130: Calculus 1 with Analytic Geometry", "SMA 205: Discrete Mathematics", "SMA 215: Applied Math for Computer Science"]
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.mcoursecell", for: indexPath) as! CourseTableViewCell
        let Course = coursename[indexPath.row].components(separatedBy: ", ")
        cell.CourseName?.text = Course.first
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coursename.count
}
}
