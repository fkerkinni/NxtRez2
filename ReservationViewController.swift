//
//  ViewController.swift
//  NxtRez2
//
//  Created by Fuat on 5/15/17.
//  Copyright © 2017 Joseph K. All rights reserved.
//

import UIKit
import os.log

class ReservationViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField:  UITextField!
    @IBOutlet weak var rDateTextField: UITextField!
    @IBOutlet weak var rTimeTextField: UITextField!
    @IBOutlet weak var guestTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value passed by  sender
     or constructed as a new reservation.
     */
    var reservation: Reservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate  = self
        rDateTextField.delegate = self
        rTimeTextField.delegate = self
        guestTextField.delegate = self
        
        
        // Set up views if editing an existing Reservation.
        if let reservation = reservation {
            navigationItem.title  = reservation.name
            nameTextField.text    = reservation.name
            rDateTextField.text   = reservation.rDate
            rTimeTextField.text   = reservation.rTime
            guestTextField.text   = reservation.guest
        }
        
        // Enable the Save button all req meant.
        updateSaveButtonState()
    }
    
    //  Disable Save button during edit
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    // Hide Keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddReservationMode = presentingViewController is UINavigationController
        
        if isPresentingInAddReservationMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The viewCont missing nav controller.")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("Not saved, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name   = nameTextField.text ??  ""
        let rDate  = rDateTextField.text ?? ""
        let rTime  = rTimeTextField.text ?? ""
        let guest  = guestTextField.text ?? ""
        
        // Set the reservation to be passed to ReservationTableViewController after the unwind segue.
        reservation = Reservation(name: name, rDate: rDate, rTime: rTime, guest: guest)
    }
    
    
    // Disable Save button if only if all any of text fields left empty. all required fields
    private func updateSaveButtonState() {
        let textName  = nameTextField.text  ?? ""
        let textRDate = rDateTextField.text ?? ""
        let textRTime = rTimeTextField.text ?? ""
        let textGuest = guestTextField.text ?? ""
        
        saveButton.isEnabled = !textName.isEmpty
        saveButton.isEnabled = !textRDate.isEmpty
        saveButton.isEnabled = !textRTime.isEmpty
        saveButton.isEnabled = !textGuest.isEmpty
    }
    
}



