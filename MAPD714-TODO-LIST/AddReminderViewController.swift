/*
 * Centennial College - MAPD714 - Fall 2017
 * MAPD714-TODO-LIST
 * Created by:
 *    300929258 - Irvinder Kaur
 *    300960367 - Fernando Ito
 * AddReminderViewController.swift - Version 1.0
 */


import UIKit

class AddReminderViewController: UIViewController, UITextFieldDelegate {
    var reminder: Reminder?
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var reminderTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.reminderTextField.delegate = self
        
        // Set currente date/time as minimum date for the picker
        timePicker.minimumDate = NSDate() as Date
        timePicker.locale = NSLocale.current
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkName() {
        // Disable Save button if the text field is empty
        let text = reminderTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

    func checkDate() {
        // Disable save button if the date in the date picker has passed
        if NSDate().earlierDate(timePicker.date) == timePicker.date {
            saveButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkName()
        navigationItem.title = textField.text
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
        
    }
    
    @IBAction func timeChanged(_ sender: UIDatePicker) {
        checkDate()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let sender = sender as? UIBarButtonItem, sender === saveButton  {
            let name = reminderTextField.text
            var time = timePicker.date
            let timeInterval = floor(time.timeIntervalSinceReferenceDate/60) * 60
            time = NSDate(timeIntervalSinceReferenceDate: timeInterval) as Date
            
            // Build notification
            let notification = UILocalNotification()
            notification.alertTitle = "Reminder"
            notification.alertBody = "Don't forget to \(String(describing: name!))!"
            notification.fireDate = time
            notification.soundName = UILocalNotificationDefaultSoundName
            
            UIApplication.shared.scheduleLocalNotification(notification)
            
            reminder = Reminder(name: name!, time: time as NSDate, notification: notification)
        }
    }
}
