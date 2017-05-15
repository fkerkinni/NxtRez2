//
//  ReservationTableViewController.swift
//  NxtRez2
//
//  Created by Fuat on 5/15/17.
//  Copyright © 2017 Joseph K. All rights reserved.
//

import UIKit
import os.log

class ReservationTableViewController: UITableViewController {
    
    var reservations = [Reservation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Edit button item provided by - tableviewcontroller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load the hard coded data.
        loadSampleReservations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ReservationTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ReservationTableViewCell  else {
            fatalError("The dequeueReusableCell is not an instance of ReservationTableViewCell.")
        }
        
        // Fetches the reservation by row number.
        let reservation = reservations[indexPath.row]
        
        cell.nameLabel?.text  = reservation.name     // first name last name
        cell.rDateLabel?.text = reservation.rDate    //rezDate
        cell.rTimeLabel?.text = reservation.rTime    //rezTime am pm
        cell.guestLabel?.text = reservation.guest    // number of guest
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            reservations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    // prep for story board
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new reservation.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let reservationDetailViewController = segue.destination as? ReservationViewController else {
                fatalError("Unexpected Error Unknow Destination: \(segue.destination)")
            }
            
            guard let selectedReservationCell = sender as? ReservationTableViewCell else {
                fatalError("Unexpected Error for selectedReservationCell sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedReservationCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedReservation = reservations[indexPath.row]
            reservationDetailViewController.reservation = selectedReservation
            
        default:
            fatalError("Unexpected taking default error - Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    @IBAction func unwindToReservationList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ReservationViewController, let reservation = sourceViewController.reservation {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing reservation.
                reservations[selectedIndexPath.row] = reservation
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new Rez.
                let newIndexPath = IndexPath(row: reservations.count, section: 0)
                
                reservations.append(reservation)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    // add check mark for completed rez
    // TODO: needs to be completed - needs to be added to new rez view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndexPath = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRow(at: indexPath)
        reservations[(selectedIndexPath?.row)!].completed = !reservations[(selectedIndexPath?.row)!].completed
        if reservations[(selectedIndexPath?.row)!].completed {
            cell?.accessoryType = UITableViewCellAccessoryType.checkmark
        } else {
            cell?.accessoryType = UITableViewCellAccessoryType.none
        }
    }
    
    //onload call this
    private func loadSampleReservations() {
        //this called on load
        guard let reservation1 = Reservation(name: "John Doe", rDate: "05/12/2017", rTime: "12:30 pm", guest: "4") else {
            fatalError("Unable to create Rez1")
        }
        
        guard let reservation2 = Reservation(name: "Chris Hart", rDate: "05/12/2017", rTime: "7:30 pm", guest: "5") else {
            fatalError("Unable to create Rez2")
        }
        
        guard let reservation3 = Reservation(name: "Mary Dollen", rDate: "05/15/2017", rTime: "8:00 pm", guest: "3") else {
            fatalError("Unable to create Rez3")
        }
        
        guard let reservation4 = Reservation(name: "Frank Sinatra", rDate: "06/15/2017", rTime: "8:00 pm", guest: "3") else {
            fatalError("Unable to create Rez4")
        }
        
        guard let reservation5 = Reservation(name: "Hillary Clinton", rDate: "06/17/2017", rTime: "8:00 pm", guest: "3") else {
            fatalError("Unable to create Rez5")
        }
        
        guard let reservation6 = Reservation(name: "Steve Jobs", rDate: "06/17/2017", rTime: "7:30 pm", guest: "3") else {
            fatalError("Unable to create Rez6")
        }
        
        guard let reservation7 = Reservation(name: "Bill Gates", rDate: "06/18/2017", rTime: "7:00 pm", guest: "3") else {
            fatalError("Unable to create Rez7")
        }
        
        guard let reservation8 = Reservation(name: "Jeff Swift", rDate: "06/18/2017", rTime: "7:00 pm", guest: "3") else {
            fatalError("Unable to create Rez8")
        }
        
        
        reservations += [reservation1, reservation2, reservation3, reservation4, reservation5, reservation6, reservation7, reservation8 ]
    }
    
}
