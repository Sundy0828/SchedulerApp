//
//  SchoolController.swift
//  SchedulerIOS
//
//  Created by Jerrod Sunderland on 2/19/19.
//  Copyright © 2019 Sundy Studio's. All rights reserved.
//

import Foundation
import UIKit

class SchoolController: UITableViewController {
    
    var data = DataController()
    var schools: [School] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        schools = data.getSchools()
        
        
    }
    
    
    
}
