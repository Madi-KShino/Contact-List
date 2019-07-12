//
//  Contact.swift
//  ContactList
//
//  Created by Madison Kaori Shino on 7/12/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation
import CloudKit

class Contact {
    
    //Contact object properties
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var email: String
    var cloudRecordId: CKRecord.ID
    
    //Designated/Memberwise Init
    init(firstName: String, lastName: String, phoneNumber: String, email: String, cloudRecordId: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email
        self.cloudRecordId = cloudRecordId
    }
    
    //Init a contact object from a cloud record
    convenience init?(record: CKRecord) {
        guard let firstName = record[ContactConstants.firstNameKey] as? String,
        let lastName = record[ContactConstants.lastNameKey] as? String,
        let phoneNumber = record[ContactConstants.phoneNumberKey] as? String,
        let email = record[ContactConstants.emailKey] as? String
            else { return nil }
        self.init(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email, cloudRecordId: record.recordID)
    }
}

//Init a record for cloud
extension CKRecord {
    convenience init(contact: Contact) {
        self.init(recordType: ContactConstants.contactTypeKey, recordID: contact.cloudRecordId)
        self.setValue(contact.firstName, forKey: ContactConstants.firstNameKey)
        self.setValue(contact.lastName, forKey: ContactConstants.lastNameKey)
        self.setValue(contact.phoneNumber, forKey: ContactConstants.phoneNumberKey)
        self.setValue(contact.email, forKey: ContactConstants.emailKey)
    }
}

//Record key constants
struct ContactConstants {
    static let contactTypeKey = "Contact"
    fileprivate static let firstNameKey = "firstName"
    fileprivate static let lastNameKey = "lastName"
    fileprivate static let phoneNumberKey = "phoneNumber"
    fileprivate static let emailKey = "email"
}
