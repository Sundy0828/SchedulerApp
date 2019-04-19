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

struct Major: Decodable {
    let MMName: String?
    let ID: Int?
}

struct Minor: Decodable {
    let MMName: String?
    let ID: Int?
}

struct MMCourses: Decodable {
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

struct LCourses: Decodable {
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

class DataController: NSObject {
    
    let baseURL = "http://sandbox.pssolutions.net/api/SchedulerAPI/"
    let GetSchools = "GetSchools"
    let GetLibArtCourses = "GetLibArtCourses"
    let GetMMCourses = "GetMajorCourses"
    let GetFinalSchedule = "GetFinalSchedule"
    let GetMajors = "GetMajors?schoolID=1"
    let GetMinors = "GetMinors?schoolID=1"
    
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
    
    func getMajor() -> [Major] {
        var majors: [Major] = []
        let JsonUrlString = baseURL + GetMajors
        guard let Url = URL(string: JsonUrlString) else { return majors }
        
        let (data, _, _) = URLSession.shared.synchronousDataTask(with: Url)
        do {
            majors = try JSONDecoder().decode([Major].self, from: (data ?? nil)!)
        } catch let jsonErr {
            print("Error Serializing Json:", jsonErr)
        }
        
        return majors
    }
    func getMinor() -> [Minor] {
        var minors: [Minor] = []
        let JsonUrlString = baseURL + GetMinors
        guard let Url = URL(string: JsonUrlString) else { return minors }
        
        let (data, _, _) = URLSession.shared.synchronousDataTask(with: Url)
        do {
            minors = try JSONDecoder().decode([Minor].self, from: (data ?? nil)!)
        } catch let jsonErr {
            print("Error Serializing Json:", jsonErr)
        }
        
        return minors
    }
    
    func getCourses() -> [MMCourses] {
        var mmcourses: [MMCourses] = []
        let JsonUrlString = baseURL + GetMMCourses
        guard let Url = URL(string: JsonUrlString) else { return mmcourses }
        
        let (data, _, _) = URLSession.shared.synchronousDataTask(with: Url)
        do {
            mmcourses = try JSONDecoder().decode([MMCourses].self, from: (data ?? nil)!)
        } catch let jsonErr {
            print("Error Serializing Json:", jsonErr)
        }
        return mmcourses
    }
    
    func getLib() -> [LCourses] {
        var lcourses: [LCourses] = []
        let JsonUrlString = baseURL + GetLibArtCourses
        guard let Url = URL(string: JsonUrlString) else { return lcourses }
        
        let (data, _, _) = URLSession.shared.synchronousDataTask(with: Url)
        do {
            lcourses = try JSONDecoder().decode([LCourses].self, from: (data ?? nil)!)
        } catch let jsonErr {
            print("Error Serializing Json:", jsonErr)
        }
        return lcourses
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

