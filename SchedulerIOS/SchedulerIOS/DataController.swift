//
//  DataController.swift
//  SchedulerIOS
//
//  Created by Jerrod Sunderland on 2/19/19.
//  Copyright © 2019 Sundy Studio's. All rights reserved.
//

import Foundation
import UIKit

struct School: Decodable {
    let ID: Int
    let SchoolName: String
}

struct Courses: Decodable {
    let ID: Int
    let MCode: String
    let CCode: String
    let SCode: String
    let Title: String
    let Prerequisites: String
    let Semester: String
    let Year: String
    let Credits: Int
    let LibArt: String
}

struct Semesters: Decodable {
    let semester: String
    let year: String
    let credits: String
    let courses: [Courses]
}

class DataController : UITableViewController {
    
    func getSchools() {
        let JsonUrlString = "http://shuscheduler.azurewebsites.net/api/SchedulerAPI/GetSchools"
        guard let Url = URL(string: JsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: Url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let school = try JSONDecoder().decode([School].self, from: data)
                print(school)
            } catch let jsonErr {
                print("Error Serializing Json:", jsonErr)
            }
            }.resume()
    }
    
    func getLibArtCourses() {
        let JsonUrlString = "http://shuscheduler.azurewebsites.net/api/SchedulerAPI/GetLibArtCourses"
        guard let Url = URL(string: JsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: Url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let school = try JSONDecoder().decode([Courses].self, from: data)
                print(school)
            } catch let jsonErr {
                print("Error Serializing Json:", jsonErr)
            }
            }.resume()
    }
    
    func getMMCourses() {
        let JsonUrlString = "http://shuscheduler.azurewebsites.net/api/SchedulerAPI/GetMajorCourses"
        guard let Url = URL(string: JsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: Url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let school = try JSONDecoder().decode([Courses].self, from: data)
                print(school)
            } catch let jsonErr {
                print("Error Serializing Json:", jsonErr)
            }
            }.resume()
    }
    
    func getFinalSchedule() {
        let JsonUrlString = "http://shuscheduler.azurewebsites.net/api/SchedulerAPI/GetFinalSchedule"
        guard let Url = URL(string: JsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: Url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let school = try JSONDecoder().decode([Semesters].self, from: data)
                print(school)
            } catch let jsonErr {
                print("Error Serializing Json:", jsonErr)
            }
            }.resume()
    }
    
    
}
