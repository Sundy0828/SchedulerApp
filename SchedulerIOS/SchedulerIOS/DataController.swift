//
//  DataController.swift
//  SchedulerIOS
//
//  Created by Jerrod Sunderland on 2/19/19.
//  Copyright © 2019 Sundy Studio's. All rights reserved.
//

import Foundation
import UIKit

var schoolID = 0
var myMajors: [MajorMinor] = []
var myMinors: [MajorMinor] = []
var mmTaken: [Course:Bool] = [:]
var libArtTaken: [Course:Bool] = [:]
var finalSchedule: [Semester] = []

struct School: Decodable {
    let ID: Int?
    let SchoolName: String?
    let PrimaryColor: String?
    let SecondaryColor: String?
}

struct Course: Decodable, Hashable {
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
    
    func getCode() -> String {
        return MCode! + " " + CCode!
    }
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
    
    let baseURL = "http://sandbox.pssolutions.net/api/SchedulerAPI/"
    let GetSchools = "GetSchools"
    let GetLibArtCourses = "GetLibArtCourses"
    let GetMMCourses = "GetMajorCourses"
    let GetFinalSchedule = "GetFinalSchedule"
    let GetMajors = "GetMajors"
    let GetMinors = "GetMinors"
    
    func getSchools() -> [School] {
        var schools: [School] = []
        let JsonUrlString = baseURL + "GetSchools"
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
        var listMM:[String] = []
        if myMajors.count > 0 {
            for i in 0...myMajors.count - 1 {
                var id = ""
                if let item = myMajors[i].ID {
                    id = String(item)
                }
                listMM.append(id)
            }
        }
        if myMinors.count > 0 {
            for i in 0...myMinors.count - 1 {
                var id = ""
                if let item = myMinors[i].ID {
                    id = String(item)
                }
                listMM.append(id)
            }
        }
        var course = GetMMCourses + "?schoolID=\(schoolID)&majors=\(listMM.joined(separator: ","))"
        if (!CourseType) {
            course = GetLibArtCourses + "?schoolID=\(schoolID)"
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
        let JsonUrlString = baseURL + MM + "?schoolID=\(schoolID)"
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
        var listMM:[String] = []
        if myMajors.count > 0 {
            for i in 0...myMajors.count - 1 {
                var id = ""
                if let item = myMajors[i].ID {
                    id = String(item)
                }
                listMM.append(id)
            }
        }
        if myMinors.count > 0 {
            for i in 0...myMinors.count - 1 {
                var id = ""
                if let item = myMinors[i].ID {
                    id = String(item)
                }
                listMM.append(id)
            }
        }
        var takenMM:[String] = []
        for (course, taken) in mmTaken {
            if taken {
                var id = ""
                if let item = course.ID {
                    id = String(item)
                }
                takenMM.append(id)
            }
        }
        var takenLibArt:[String] = []
        for (course, taken) in libArtTaken {
            if taken {
                var id = ""
                if let item = course.ID {
                    id = String(item)
                }
                takenLibArt.append(id)
            }
        }
        let JsonUrlString = baseURL + GetFinalSchedule + "?schoolID=\(schoolID)&majors=\(listMM.joined(separator: ","))&mmCoursesTaken=\(takenMM.joined(separator: ","))&libArtCoursesTaken=\(takenLibArt.joined(separator: ","))&startSem=Fall&startYear=2019&maxCredits=17&maxSem=8"
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
