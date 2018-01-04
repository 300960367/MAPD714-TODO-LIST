/*
 * Centennial College - MAPD714 - Fall 2017
 * MAPD714-TODO-LIST
 * Created by:
 *    300929258 - Irvinder Kaur
 *    300960367 - Fernando Ito
 * Reminder.swift - Version 1.0
 */
import Foundation
import UIKit

class Reminder: NSObject, NSCoding {
    
    // Properties
    var notification: UILocalNotification
    var name: String
    var time: NSDate
    
    // Archive paths for Persistent Data
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("reminders")
    
    // Enum for property keys
    struct PropertyKey {
        static let nameKey = "name"
        static let timeKey = "time"
        static let notificationKey = "notification"
    }
    
    // Initializer
    init(name: String, time: NSDate, notification: UILocalNotification) {
        self.name = name
        self.time = time
        self.notification = notification
        
        super.init()
    }
    
    // Destructor
    deinit {
        // Cancel notification
        UIApplication.shared.cancelLocalNotification(self.notification)
    }
    
    // NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(time, forKey: PropertyKey.timeKey)
        aCoder.encode(notification, forKey: PropertyKey.notificationKey)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let time = aDecoder.decodeObject(forKey: PropertyKey.timeKey) as! NSDate
        let notification = aDecoder.decodeObject(forKey: PropertyKey.notificationKey) as! UILocalNotification
        
        self.init(name: name, time: time, notification: notification)
    }
}
