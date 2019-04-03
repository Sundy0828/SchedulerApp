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
    var majors: [MajorMinor] = []
    @IBOutlet weak var majorcell: UITableViewCell!
    @IBOutlet weak var minorcell: UITableViewCell!
    @IBOutlet weak var MajorName: UILabel!
    @IBOutlet weak var MinorName: UILabel!
    @IBOutlet weak var MajorTable: UITableView!
    @IBOutlet weak var MinorTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        majors = data.getMM(MajorType: true)
        
        MajorTable.delegate = self
        MajorTable.dataSource = self
    }
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MajorTable.dequeueReusableCell(withIdentifier: "com.codepath.majorcell", for: indexPath)
        cell.textLabel?.text = majors[indexPath.row].MMName
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return majors.count
    }
    
    
    
}


