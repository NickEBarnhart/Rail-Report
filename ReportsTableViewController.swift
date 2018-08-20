//
//  ReportsTableViewController.swift
//  Siemens_Reporter
//
//  Created by Nicholas Barnhart on 3/21/17.
//  Copyright © 2017 Nicholas Edward Barnhart. All rights reserved.
//

import UIKit
import os.log

class ReportsTableViewController: UITableViewController {

    
    var reports = [Reports]()
    var weekReports = [weekChildReport]()
    var dayCountNet = ""
    var weekChanger = false
    var row = 0
    var weekRow = 0
    @IBOutlet weak var homeButton: UIBarButtonItem!
    let cheeki = UIBarButtonItem()
    
    var rowCounter = -1
    var report: weekChildReport?
    
    var teamCatcher: String?
    var weekCatcher: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(weekChanger){
        navigationItem.leftBarButtonItems = [cheeki]
        navigationItem.rightBarButtonItems = []
        }
        else{
            navigationItem.leftBarButtonItems = [homeButton, editButtonItem]
        }
        
        
        if let savedReports = loadReports() {
            reports += savedReports
            
        }
        else{
            loadSamples()
        }
        
        if(dayCountNet != "")
        {
            editButtonItem.isEnabled = false
        }
        

    }
    
    
    
    func setBorders(spot: StorageTableViewCell)
    {

        spot.dayItem.layer.borderColor = UIColor.blue.cgColor
        //spot.dayItem.layer.backgroundColor = UIColor.orange.cgColor
        spot.dayItem.layer.borderWidth = 1.0
        spot.dayItem.layer.cornerRadius = 5.0



        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            navigationController?.popToRootViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return reports.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ReportTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StorageTableViewCell else{
            fatalError("The dequeued cell is not an instance of StorageTableViewCell.")
        }
        
        let report = reports[indexPath.row]
        
        let imageData1 = UIImageJPEGRepresentation(report.photo!, 0)
        let imageData2 = UIImageJPEGRepresentation(report.photo2!, 0)
        let imageData3 = UIImageJPEGRepresentation(report.photo3!, 0)
        
        let data1 = UIImage(data: imageData1!)
        let data2 = UIImage(data: imageData2!)
        let data3 = UIImage(data: imageData3!)
        
        cell.titleItem.text = report.team
        cell.imageItem.image = data1!
        cell.locationItem.text = report.location
        cell.dateItem.text = report.date
        cell.observationItem.text = report.observation
        cell.actionItem.text = report.action
        cell.impactItem.text = report.impact
        cell.workerItem.text = report.workers
        
        cell.imageItem2.image = data2!
        cell.imageItem3.image = data3!
        
        cell.descriptionItem.text = report.description1
        cell.dayItem.text = report.day

        

        setBorders(spot: cell)


        return cell
    }
    
    @IBAction func unwindToReportList(sender: UIStoryboardSegue)
    {
       
        
        if let sourceViewController = sender.source as? ViewController, let report = sourceViewController.report {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //append old report
                reports[selectedIndexPath.row] = report
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            
            else{
                //add new report
            let newIndexPath = IndexPath(row: reports.count, section:0)
            
            reports.append(report)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            saveReports()
            
        }
        
        
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // Delete the row from the data source
            reports.remove(at: indexPath.row)
            saveReports()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if(weekChanger){
            
        let destinationVC: ViewController = segue.destination as! ViewController
            destinationVC.dayCountNet = dayCountNet
            destinationVC.weekChange = true
            destinationVC.row = rowCounter
            destinationVC.weekRow = weekRow
            destinationVC.weekReports = weekReports
            
            destinationVC.teamCatcher = teamCatcher
            destinationVC.weekCatcher = weekCatcher
            destinationVC.previousView = self

            
        }
        
        
        switch(segue.identifier ?? "")
        {
            case "addItem": os_log("Adding a new report.", log: OSLog.default, type: .debug)
            
        case "showDetail":
            guard let reportDetailViewcontroller = segue.destination as? ViewController
                
                else{
                fatalError("Unexpected Destination: \(segue.destination)")
            
            }
            
            guard let selectedReportCell = sender as? StorageTableViewCell else {
                fatalError("Unexpected sender: \(sender!)")
            }
            
        guard let indexPath = tableView.indexPath(for: selectedReportCell) else {
            fatalError("The selected cell is not being displayed by the table")
            
            }
            
            
            
            let selectedReport = reports[indexPath.row]
            reportDetailViewcontroller.report = selectedReport
            
            
            
        default: fatalError("Unexpected Segue Identifier; \(segue.identifier!)")
        
        }
    }

    
    private func loadSamples(){
        
    }
    
    private func saveReports()
    {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(reports, toFile: Reports.ArchiveURL.path)
        
        if isSuccessfulSave{
            os_log("Reports Successful saved.", log: OSLog.default, type: .debug)
        }
        else{
            os_log("Failed to save.", log: OSLog.default, type: .error)
        }
    }
    
    private func loadReports() -> [Reports]?{
        return (NSKeyedUnarchiver.unarchiveObject(withFile: Reports.ArchiveURL.path) as? [Reports])
    }
    
    @IBAction func sendHome(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)

    }
    
    
    

}
