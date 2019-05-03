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
    
    var MM: [MajorMinor] = []
    let data = DataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var minors = data.getMM(MajorType: false)
        for i in 0..<minors.count {
            if !myMinors.contains(where: { $0.ID == minors[i].ID }) {
                MM.append(minors[i])
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "majorCell") as? SchoolCell
        cell?.title.text = MM[indexPath.row].MMName
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myMinors.append(MM[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
    
}
