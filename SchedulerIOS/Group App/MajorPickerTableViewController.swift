//
//  MajorPickerTableViewController.swift
//  Group App
//
//  Created by Adam Webb on 3/20/19.
//  Copyright © 2019 Adam Webb. All rights reserved.
//

import UIKit
import Foundation

struct Majors {
    
    var Name: String
    
}

class MajorPickerTableViewCell: UITableViewCell{
    
   @IBOutlet weak var Major: UILabel!
    
}

class MajorPickerTableViewController: UITableViewController {
    
    
    
    var majors = [
        Majors(Name:"Computer Science BA")]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return majors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "majorcell", for: indexPath) as! MajorPickerTableViewCell
        
        let major = majors[indexPath.row]
        cell.Major?.text = major.Name
        
        return cell
    }
    
}
