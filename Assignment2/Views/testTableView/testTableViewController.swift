//
//  testTableViewController.swift
//  Assignment2
//
//  Created by Hasan Qasim on 26/9/19.
//  Copyright © 2019 M Rahman. All rights reserved.
//

import UIKit

class testTableViewController: UITableViewController, DatabaseListener {
    var allReadings = [SensorReading]()
    weak var databaseController: DatabaseProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allReadings.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           databaseController?.addListener(listener: self)
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           databaseController?.removeListener(listener: self)
       }
    func onSensorReadingListChange(change: DatabaseChange, sensorReadings: [SensorReading]) {
        allReadings = sensorReadings
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "readingCell", for: indexPath)
        let reading = allReadings[indexPath.row]
        cell.textLabel!.text = reading.id
        cell.detailTextLabel!.text = reading.timestamp
    
        return cell
    }

}
