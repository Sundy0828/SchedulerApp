//
//  MajorController.swift
//  SchedulerIOS
//
//  Created by Jerrod Sunderland on 2/19/19.
//  Copyright © 2019 Sundy Studio's. All rights reserved.
//

import Foundation
import UIKit

class MajorController: UITableViewController {
    
    var MM: [MajorMinor] = []
    let data = DataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var majors = data.getMM(MajorType: true)
        for i in 0..<majors.count {
            if !myMajors.contains(where: { $0.ID == majors[i].ID }) {
                MM.append(majors[i])
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
        myMajors.append(MM[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
