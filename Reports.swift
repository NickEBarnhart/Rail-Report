//
//  Reports.swift
//  Siemens_Reporter
//
//  Created by Nicholas Barnhart on 3/21/17.
//  Copyright © 2017 Nicholas Edward Barnhart. All rights reserved.
//

import UIKit
import os.log


class Reports: NSObject, NSCoding{
    
    var team: String
    var date: String
    var description1: String
    var day: String
    var location: String
    var observation: String
    var action: String
    var impact: String
    var workers: String
    var counter1: String
    var photo: UIImage?
    var photo2: UIImage?
    var photo3: UIImage?
    var orientation1: String
    var orientation2: String
    var orientation3: String
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("report")
    
    
    init?(team: String, date: String, location: String, observation: String, action: String, impact: String, workers: String, photo: UIImage?, photo2: UIImage?, photo3: UIImage?, counter1: String, description1: String, day: String, orientation1: String, orientation2: String, orientation3: String) {
        
        guard !team.isEmpty else {
            return nil
        }
        

        

        self.team = team
        self.date = date
        self.description1 = description1
        self.day = day
        self.location = location
        self.observation = observation
        self.action = action
        self.impact = impact
        self.workers = workers
        self.counter1 = counter1
        self.photo = photo
        self.photo2 = photo2
        self.photo3 = photo3
        self.orientation1 = orientation1
        self.orientation2 = orientation2
        self.orientation3 = orientation3
    }
    
    struct PropertyKey{
        static let team = "team"
        static let date = "date"
        static let description1 = "description1"
        static let day  = "day"
        static let location = "location"
        static let observation = "observation"
        static let action = "action"
        static let impact = "impact"
        static let workers = "workers"
        static let counter1 = "1"
        static let photo = "photo"
        static let photo2 = "photo2"
        static let photo3 = "photo3"
        static let orientation1 = "orientation1"
        static let orientation2 = "orientation2"
        static let orientation3 = "orientation3"
        
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(team, forKey: PropertyKey.team)
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(description1, forKey: PropertyKey.description1)
        aCoder.encode(day, forKey: PropertyKey.day)
        aCoder.encode(location, forKey: PropertyKey.location)
        aCoder.encode(observation, forKey: PropertyKey.observation)
        aCoder.encode(impact, forKey: PropertyKey.impact)
        aCoder.encode(action, forKey: PropertyKey.action)
        aCoder.encode(workers, forKey: PropertyKey.workers)
        aCoder.encode(counter1, forKey: PropertyKey.counter1)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(photo2, forKey: PropertyKey.photo2)
        aCoder.encode(photo3, forKey: PropertyKey.photo3)
        aCoder.encode(orientation1, forKey: PropertyKey.orientation1)
        aCoder.encode(orientation2, forKey: PropertyKey.orientation2)
        aCoder.encode(orientation3, forKey: PropertyKey.orientation3)



        


    }
    
    required convenience init?(coder aDecoder: NSCoder){
        guard let team = aDecoder.decodeObject(forKey: PropertyKey.team) as? String else {
            os_log("Unable to decode the name for a report object.", log: OSLog.default, type: .debug)
            return nil
            
        }
        
            let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let photo2 = aDecoder.decodeObject(forKey: PropertyKey.photo2) as? UIImage
        let photo3 = aDecoder.decodeObject(forKey: PropertyKey.photo3) as? UIImage
        let location = aDecoder.decodeObject(forKey: PropertyKey.location) as? String
        let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String
        let description1 = aDecoder.decodeObject(forKey: PropertyKey.description1) as? String
        let day = aDecoder.decodeObject(forKey: PropertyKey.day) as? String
        let observation = aDecoder.decodeObject(forKey: PropertyKey.observation) as? String
        let impact = aDecoder.decodeObject(forKey: PropertyKey.impact) as? String
        let action = aDecoder.decodeObject(forKey: PropertyKey.action) as? String
        let workers = aDecoder.decodeObject(forKey: PropertyKey.workers) as? String
        let counter1 = aDecoder.decodeObject(forKey: PropertyKey.counter1) as? String
        let orientation1 = aDecoder.decodeObject(forKey: PropertyKey.orientation1) as? String
        let orientation2 = aDecoder.decodeObject(forKey: PropertyKey.orientation2) as? String
        let orientation3 = aDecoder.decodeObject(forKey: PropertyKey.orientation3) as? String




        
        
        
        self.init(team: team, date: date!, location: location!, observation: observation!, action: action!, impact: impact!, workers: workers!, photo: photo, photo2: photo2, photo3: photo3, counter1: counter1!, description1: description1!, day: day!, orientation1: orientation1!, orientation2: orientation2!, orientation3: orientation3!)
            
        
    }
    
    
}
