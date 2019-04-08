//
//  SchoolSelectionTableViewController.swift
//  Group App
//
//  Created by Adam Webb on 3/19/19.
//  Copyright © 2019 Adam Webb. All rights reserved.
//

import UIKit

struct Schools {
    
    var Name: String
    var Logo: String
}

class SchoolSeclectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var SchoolName: UILabel!
    @IBOutlet weak var SchoolLogo: UIImageView!
    
}

class SchoolSelectionTableViewController: UITableViewController {
    
    var schools = [
        Schools(Name:"Seton Hill University", Logo:"SHU")]

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolcell", for: indexPath) as! SchoolSeclectionTableViewCell
        
        let school = schools[indexPath.row]
        cell.SchoolName?.text = school.Name
        cell.SchoolLogo?.image = UIImage(named: school.Logo)
        
        return cell
    }
    
}
