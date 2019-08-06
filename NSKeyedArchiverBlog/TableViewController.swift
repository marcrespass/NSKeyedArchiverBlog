//
//  TableViewController.swift
//  NSKeyedArchiverBlog
//
//  Created by Erica Millado on 3/12/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var store = DataStore.sharedInstance
    
    @IBOutlet weak var tableView: UITableView!
 

    override func viewDidLoad() {
        super.viewDidLoad()
    

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.shoppingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.store.shoppingItems[indexPath.row].name
//        cell.detailTextLabel?.text = self.store.shoppingItems[indexPath.row].serialNumber
        return cell
    }
}
