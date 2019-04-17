//
//  MMController.swift
//  SchedulerIOS
//
//  Created by Jerrod Sunderland on 2/19/19.
//  Copyright © 2019 Sundy Studio's. All rights reserved.
//

import Foundation
import UIKit

class MMController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data = DataController()
    var majors: [Major] = []
    //var courses: [MajorMinor] = []
    
    
    
    @IBOutlet weak var MajorTable: UITableView!
    
    @IBOutlet weak var MinorTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        majors = data.getMajor()
        //courses = data.getMM(MajorType: true)
        
       // MajorTable.dataSource = self
       // MajorTable.delegate = self
    }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.majorcell", for: indexPath)
        cell.textLabel?.text = majors[indexPath.row].MMName
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return majors.count
    }
    
    
}



