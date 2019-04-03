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
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.schoolcell", for: indexPath)
        cell.textLabel?.text = schools[indexPath.row].SchoolName
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondViewController = MMController()
        let navigationController = UINavigationController(rootViewController: secondViewController)
        show(navigationController, sender: nil)
    }
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            

            // perform custom segue operation.
        }
    }
        //Use below to get reference,so that you can pass value
            //segue.destinationViewController
        //segue.sourceViewController

    

