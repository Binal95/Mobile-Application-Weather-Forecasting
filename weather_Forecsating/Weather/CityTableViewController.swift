//
//  ViewController.swift
//  SearchBar
//
//  Created by Patel, Binal Shaileshkumar on 11/06/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

import UIKit
class CityTableViewController: UITableViewController,UISearchResultsUpdating{
    var curCity = String()

    var filteredArray = [String]()
    
    var searchController = UISearchController()
    var resultController = UITableViewController()
    var cityname = String()
    var cityNameArr = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if cityname=="Texas"{
            cityNameArr = ["Houston","Austin","dallas"]}
        else{
            cityNameArr = ["dayton","ohio","dallas"]
        }
     //   cityNameArr = ["dayton","ohio","dallas"]
        self.searchController = UISearchController(searchResultsController: resultController)
        tableView.tableHeaderView = self.searchController.searchBar
        
        self.searchController.searchResultsUpdater = self
        
        self.resultController.tableView.delegate = self
        self.resultController.tableView.dataSource = self
    }
    func loadcitiesintodb() -> Bool {
        let cities = (CityFavDML.fetchCities()!) as! [String]
        print(cities)
        for city in cities {
            if city == curCity{
                print("already exist" )
                
                return false
                
            }
        }
        return true
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == resultController.tableView
        {
            
          curCity = self.filteredArray[indexPath.row]
            searchController.isActive = false

        }
        else
        {
            curCity = self.cityNameArr[indexPath.row]
        }
        let b = loadcitiesintodb()
        if b {
            CityFavDML.addFavCity(curCity)
            self.navigationController?.popToRootViewController(animated: true)

            }
            else{
            let alert = UIAlertController(title: "Alert", message: "Already in Fav", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
            self.present(alert, animated: true, completion: nil)

            
                }

    }
    
   
    
    func updateSearchResults(for searchController: UISearchController) {
        
        
        self.filteredArray = cityNameArr.filter({ (array: String) -> Bool in
            
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if tableView == resultController.tableView
        {
            return self.filteredArray.count
        }
        else
        {
            return self.cityNameArr.count
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
            cell.textLabel?.text = self.cityNameArr[indexPath.row]
        }
        
        
        
        return cell
        
        
        
        
    }
    
}
