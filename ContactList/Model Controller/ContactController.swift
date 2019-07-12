//
//  ContactController.swift
//  ContactList
//
//  Created by Madison Kaori Shino on 7/12/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    //Singleton
    static let sharedInstance = ContactController()
    
    //Properties
    var contacts: [Contact] = []
    let privateDatabase = CKContainer.default().publicCloudDatabase
    
    //Create Contact & record from contact for cloud
    func createContact(firstName: String, lastName: String, phoneNumber: String, email: String, completion: @escaping (Contact?) -> Void) {
        let newContact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email)
        let newRecord = CKRecord(contact: newContact)
        privateDatabase.save(newRecord) { (record, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) : \(error)")
                completion(nil)
                return
            }
            guard let record = record else { completion(nil); return }
            guard let contact = Contact(record: record) else { completion(nil); return }
            self.contacts.append(contact)
            completion(contact)
        }
    }
    
    //Update Contact
    func updateContact(contact: Contact, firstName: String, lastName: String, phoneNumber: String, email: String, completion: @escaping (Bool) -> Void ) {
        contact.firstName = firstName
        contact.lastName = lastName
        contact.phoneNumber = phoneNumber
        contact.email = email
        let recordToSave = CKRecord(contact: contact)
        let operation = CKModifyRecordsOperation()
        operation.recordsToSave = [recordToSave]
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        operation.queuePriority = .high
        operation.completionBlock = {
            completion(true)
        }
        privateDatabase.add(operation)
    }

    //Fetch records from cloud and init as contacts
    func fetchContacts(completion: @escaping ([Contact]?) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: ContactConstants.contactTypeKey, predicate: predicate)
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) : \(error)")
                completion(nil)
                return
            }
            guard let records = records else { completion(nil); return }
            let contacts: [Contact] = records.compactMap{Contact(record: $0)}
            self.contacts = contacts
            completion(contacts)
        }
    }
}
