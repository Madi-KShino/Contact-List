//
//  ContactDetailViewController.swift
//  ContactList
//
//  Created by Madison Kaori Shino on 7/12/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    //Landing pad
    var contact: Contact? 
    
    //Outlets
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var phoneNumberLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //Actions
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let firstName = firstNameLabel.text, !firstName.isEmpty,
            let lastName = lastNameLabel.text,
            let email = emailLabel.text,
            let phoneNumber = phoneNumberLabel.text
            else { return }
        if let contact = contact {
            ContactController.sharedInstance.updateContact(contact: contact, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email) { (success) in
                if success {
                    print("Contact successfully updated")
                }
            }
        } else {
            ContactController.sharedInstance.createContact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email) { (contact) in
                if contact != nil {
                    print("Contact successfully created")
                }
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    //Helper Functions
    func updateViews() {
        guard let contact = contact else { return }
        firstNameLabel.text = contact.firstName
        lastNameLabel.text = contact.lastName
        emailLabel.text = contact.email
        phoneNumberLabel.text = contact.phoneNumber
    }
}
