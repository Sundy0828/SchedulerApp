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
    var data = DataController()
    override func viewDidLoad() {
        super.viewDidLoad()
        data.getFinalSchedule(schoolID: schoolID, majors: majors)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}
