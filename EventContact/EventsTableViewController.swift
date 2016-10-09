//
//  EventsTableViewController.swift
//  EventContact
//
//  Created by Princess Sampson on 10/1/16.
//  Copyright © 2016 Princess Sampson. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {
    var currentUser: User?
    var store = EventStore()
    var events = [Event]() {
        didSet {
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchEvents { (result) in
            
            switch result {
            case let .Success(events):
                self.events = events
            case let .Failure(error, message):
                print("GOD DAMN IT: \(error), \n \(message)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        cell.textLabel?.text = event.title
        return cell
    }}
