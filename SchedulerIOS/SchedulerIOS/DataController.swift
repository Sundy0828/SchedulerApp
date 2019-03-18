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
    let ID: Int?
    let SchoolName: String?
    let PrimaryColor: String?
    let SecondaryColor: String?
}

struct Course: Decodable {
    let ID: Int?
    let MCode: String?
    let CCode: String?
    let SCode: String?
    let Title: String?
    let Prerequisites: String?
    let Semester: String?
    let Year: String?
    let Credits: Int?
    let LibArt: String?
}

struct MajorMinor: Decodable {
    let ID: Int?
    let MMName: String?
}

struct Semester: Decodable {
    let semester: String?
    let year: String?
    let credits: String?
    let courses: [Course]?
}

class DataController: NSObject {
    
    let baseURL = "http://shuscheduler.azurewebsites.net/api/SchedulerAPI/"
    let GetSchools = "GetSchools"
    let GetLibArtCourses = "GetLibArtCourses"
    let GetMMCourses = "GetMajorCourses"
    let GetFinalSchedule = "GetFinalSchedule"
    let GetMajors = "GetMajors"
    let GetMinors = "GetMinors"
    
    func getSchools() -> [School] {
        var schools: [School] = []
        let JsonUrlString = baseURL + GetSchools
        guard let Url = URL(string: JsonUrlString) else { return schools }
        
        let (data, _, _) = URLSession.shared.synchronousDataTask(with: Url)
        do {
            schools = try JSONDecoder().decode([School].self, from: (data ?? nil)!)
        } catch let jsonErr {
            print("Error Serializing Json:", jsonErr)
        }
        
        return schools
    }
    
    func getCourses(CourseType: Bool) -> [Course] {
        var courses: [Course] = []
        var course = GetMMCourses
        if (!CourseType) {
            course = GetLibArtCourses
        }
        let JsonUrlString = baseURL + course
        guard let Url = URL(string: JsonUrlString) else { return courses }
        
        let (data, _, _) = URLSession.shared.synchronousDataTask(with: Url)
        do {
            courses = try JSONDecoder().decode([Course].self, from: (data ?? nil)!)
        } catch let jsonErr {
            print("Error Serializing Json:", jsonErr)
        }
        
        return courses
    }
    
    func getMM(MajorType: Bool) -> [MajorMinor] {
        var courses: [MajorMinor] = []
        var MM = GetMajors
        if (!MajorType) {
            MM = GetMinors
        }
        let JsonUrlString = baseURL + MM
        guard let Url = URL(string: JsonUrlString) else { return courses }
        
        let (data, _, _) = URLSession.shared.synchronousDataTask(with: Url)
        do {
            courses = try JSONDecoder().decode([MajorMinor].self, from: (data ?? nil)!)
        } catch let jsonErr {
            print("Error Serializing Json:", jsonErr)
        }
        
        return courses
    }
    
    func getFinalSchedule() -> [Semester] {
        var semesters: [Semester] = []
        let JsonUrlString = baseURL + GetFinalSchedule
        guard let Url = URL(string: JsonUrlString) else { return semesters}
        
        let (data, _, _) = URLSession.shared.synchronousDataTask(with: Url)
        do {
            semesters = try JSONDecoder().decode([Semester].self, from: (data ?? nil)!)
        } catch let jsonErr {
            print("Error Serializing Json:", jsonErr)
        }
        
        return semesters
    }
    
    
}

extension URLSession {
    func synchronousDataTask(with url: URL) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = self.dataTask(with: url) {
            data = $0
            response = $1
            error = $2
            
            semaphore.signal()
        }
        dataTask.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return (data, response, error)
    }
}
