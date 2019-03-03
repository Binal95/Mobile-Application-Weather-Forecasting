//
//  TableViewController.swift
//  SearchTutorial
//
//  Created by CSCI5737 Fall18 on 10/2/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

import UIKit

class StatesTableViewController: UITableViewController, UISearchResultsUpdating {

    @IBAction func backbtn(_ sender: Any) {
     
self.dismiss(animated: true, completion: nil)
        
    }
    
    var anotherVariable = String()
    var array = ["California","Texas","Florida","NewYork","Illinois","Pennsylvania","Ohio","Georgia","NorthCarolina","Michigan"]
    
    var filteredArray = [String]()
    
    var searchController = UISearchController()
    var resultController = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchController = UISearchController(searchResultsController: resultController)
        tableView.tableHeaderView = self.searchController.searchBar
        
        self.searchController.searchResultsUpdater = self
        
        self.resultController.tableView.delegate = self
        self.resultController.tableView.dataSource = self
        
        
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        
        self.filteredArray = array.filter({ (array: String) -> Bool in
            
            if array.contains(searchController.searchBar.text!)
            {
                return true
            }
            else
            {
                return false
            }
            
        })
        
        self.resultController.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == resultController.tableView
        {
            anotherVariable = self.filteredArray[indexPath.row]
            performSegue(withIdentifier: "city", sender: self)
            searchController.isActive = false

        }
        else
        {
            anotherVariable = self.array[indexPath.row]
            performSegue(withIdentifier: "city", sender: self)
//            searchController.isActive = false

        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let something = segue.destination as! CityTableViewController
        something.cityname = anotherVariable
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
      
        if tableView == resultController.tableView
        {
            return self.filteredArray.count
        }
        else
        {
            return self.array.count
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()

       
        if tableView == resultController.tableView
        {
           
            cell.textLabel?.text = self.filteredArray[indexPath.row]
        }
        else
        {
           cell.textLabel?.text = self.array[indexPath.row]
        }
        
        
       
        return cell
        
        

       
    }
    

}
