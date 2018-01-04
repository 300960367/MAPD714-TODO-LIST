/*
 * Centennial College - MAPD714 - Fall 2017
 * MAPD714-TODO-LIST
 * Created by FERNANDO ITO on 2018-01-03.
 * Version 0.1
 */
import Foundation
import UIKit

class Reminder: NSObject, NSCoding {
    // Properties
    var notification: UILocalNotification
    var name: String
    var time: NSDate
    
    // Archive paths for Persistent Data
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("reminders")
    
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
        UIApplication.sharedApplication().cancelLocalNotification(self.notification)
    }
    
    // NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(time, forKey: PropertyKey.timeKey)
        aCoder.encodeObject(notification, forKey: PropertyKey.notificationKey)
    }
    
    required.convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjecForKey(PropertyKey.nameKey) as! String
        let time = aDecoder.decoderObjectForKey(PropertyKey.timeKey) as! NSDate
        let notification = aDecoder.decodeObjectForKey(PropertyKey.notificationKey) as! UILocalNotification
        
        self.init(name: name, time: time, notification: notification)
    }
}
