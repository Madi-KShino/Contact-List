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
    let privateDatabase = CKContainer.default().privateCloudDatabase
    
    
}
