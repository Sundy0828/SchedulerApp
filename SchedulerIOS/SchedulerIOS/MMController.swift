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
    
    @IBOutlet weak var majorTableView: UITableView!
    @IBOutlet weak var minorTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        majorTableView.reloadData()
        minorTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        majorTableView.dataSource = self
        majorTableView.delegate = self
        
        minorTableView.dataSource = self
        minorTableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == majorTableView {
            return myMajors.count
        }else {
            return myMinors.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == majorTableView {
            let cell = majorTableView.dequeueReusableCell(withIdentifier: "majorCell")
            cell?.textLabel?.text = myMajors[indexPath.row].MMName
            return cell!
        }else {
            let cell = minorTableView.dequeueReusableCell(withIdentifier: "minorCell")
            cell?.textLabel?.text = myMinors[indexPath.row].MMName
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == majorTableView {
            if editingStyle == .delete {
                myMajors.remove(at: indexPath.row)
                majorTableView.deleteRows(at: [indexPath], with: .fade)
            }
        }else {
            if editingStyle == .delete {
                myMinors.remove(at: indexPath.row)
                minorTableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
}
