//
//  CustomerDetailsData.swift
//  OffmadeDemo
//
//  Created by Syed Najam on 27/09/2020.
//

import Foundation

struct CustomerDetails {
    var customerPersonalInfo : CustomerPersonalInfo
    var customerPropertyInfo : CustomerPropertyInfo
    var reminderGroupList : [ReminderGroup]
}

//struct CustomerDetails {
//    var customerPersonalInfo : CustomerPersonalInfo?
//    var customerPropertyInfo : CustomerPropertyInfo?
//    var reminderGroupList : [ReminderGroup]?
//}

struct CustomerPersonalInfo {
    var firstName: String
    var lastName: String
    var fullName : String
    var companyName: String
    var phoneNumber: String
    var emailAddress: String
}

struct CustomerPropertyInfo {
    var description: String
    var purchasePrice: String
    var multiplePrice: String
}

struct ReminderGroup : Hashable {
    var status : ReminderStatus
    var reminderList : [ReminderObject]
}

struct ReminderObject : Hashable {
    var id = UUID().uuidString
    var title: String
    var address: String
    var isCompleted: Bool
}

enum ReminderStatus : Int {
    case OVERDUE = 1
    case TODAY = 2
    case TOMORROW = 3
    case UPCOMING = 4
}

class CustomerDetailsData: ObservableObject {
    
    @Published var customerDetails : CustomerDetails?
    @Published var isNetworking = true
    
    init(employeeId: String) {
        
        //Just Dummy Data
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            self.setCustomerDetails()
        }
    }
    
    //set customer details
    private func setCustomerDetails() {
        
        self.customerDetails = CustomerDetails.init(customerPersonalInfo: CustomerPersonalInfo.init(firstName: "Max", lastName: "Aalmann", fullName: "Max Aalmann", companyName: "Aalmann Property GmbH", phoneNumber: "+49 1783 4567 0987", emailAddress: "hellofromAalmann@gmail.com"), customerPropertyInfo: CustomerPropertyInfo.init(description: "Max Aalmann is looking for good residential property deals in tier 1 and tier 2 in Berlin, Hamburg and Munich", purchasePrice: "Purchase price up to 10M", multiplePrice: "Multiples up to 30-35 ok"), reminderGroupList: [ReminderGroup]())
            
        self.setRemidnersList()
        
        //End of call
        self.isNetworking = false
    }
    
    //Set reminder group
    private func setRemidnersList(){
        //Do some API call here
        
        //Dummy Data
        var overdueReminder = ReminderGroup.init(status: .OVERDUE, reminderList: [ReminderObject]())
        for _ in 1..<3 {
            overdueReminder.reminderList.append(ReminderObject.init(title: "Check-in about sonnenalle", address: "sonnenalle 45, 12045 Berlin", isCompleted: false))
        }
        
        var todayReminder = ReminderGroup.init(status: .TODAY, reminderList: [ReminderObject]())
        for _ in 1..<5 {
            todayReminder.reminderList.append(ReminderObject.init(title: "Send info memo", address: "sonnenalle 22, 93134 Berlin", isCompleted: false))
        }
        
        var tomorrowReminder = ReminderGroup.init(status: .TOMORROW, reminderList: [ReminderObject]())
        for _ in 1..<7 {
            tomorrowReminder.reminderList.append(ReminderObject.init(title: "Follow up about Storkower str", address: "sonnenalle 11, 22445 Berlin", isCompleted: false))
        }
        
        var upcomingReminder = ReminderGroup.init(status: .UPCOMING, reminderList: [ReminderObject]())
        for _ in 1..<2 {
            upcomingReminder.reminderList.append(ReminderObject.init(title: "Client Birthday", address: "", isCompleted: false))
        }
        
        var reminderGroups = [ReminderGroup]()
        reminderGroups.append(overdueReminder)
        reminderGroups.append(todayReminder)
        reminderGroups.append(tomorrowReminder)
        reminderGroups.append(upcomingReminder)
        
        self.customerDetails!.reminderGroupList = reminderGroups
    }
    
    //Update status of Reminder
    func updateReminder(reminderObject : ReminderObject){
        //Do some API call here
        
        //Dummy Data
        for (i, group) in self.customerDetails!.reminderGroupList.enumerated() {
            for (j, reminder) in group.reminderList.enumerated(){
                if reminderObject.id == reminder.id {
                    self.customerDetails!.reminderGroupList[i].reminderList[j].isCompleted.toggle()
                    return
                }
            }
        }
    }
    
    //Get Reminder group name based on status
    func getReminderGroupName(reminderStatus: ReminderStatus) -> String {
        switch reminderStatus {
        case .OVERDUE:
            return "Overdue"
        case .TODAY:
            return "Today"
        case .TOMORROW:
            return "Tomorrow"
        case .UPCOMING:
            return "Upcoming"
        }
    }
}
