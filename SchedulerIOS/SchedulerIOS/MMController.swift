//
//  MMController.swift
//  SchedulerIOS
//
//  Created by Jerrod Sunderland on 2/19/19.
//  Copyright © 2019 Sundy Studio's. All rights reserved.
//

import Foundation
import UIKit

class MMController: UIViewController {
    
    var data = DataController()
    var majorminor: [MajorMinor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        majorminor = data.getMM(MajorType: <#T##Bool#>)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}
