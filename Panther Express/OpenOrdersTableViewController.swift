//
//  OpenOrdersTableViewController.swift
//  Panther Express
//
//  Created by Christian Valencia on 7/19/20.
//  Copyright © 2020 PantherHacks. All rights reserved.
//

import UIKit
import Firebase

class OpenOrdersTableViewController: UITableViewController {
    
    var orders = [Order]()
    var selectedRow = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadExecuteOrders()
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ordersCell", for: indexPath) as! CustomTableViewCell
        
        cell.orderName.text = "\(orders[indexPath.row].storeName) order"
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "toOrderDetails", sender: nil)
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let viewController = segue.destination as? OrderDetailsViewController {
            viewController.order = orders[selectedRow]
            viewController.candidate = true
        }
    }

    @IBAction func unwindSegueToOrders(_ sender: UIStoryboardSegue)
    {
            
    }

    //MARK: - DATABASE MANAGMENT
    
    private func loadExecuteOrders()  {
        let fireStoreDatabase = Firestore.firestore()
        orders.removeAll()
        fireStoreDatabase.collection("Orders").getDocuments { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription ?? "ERROR")
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        let data = document.data()
                        for (_, j) in data {
                            do{
                                let data = try? JSONSerialization.data(withJSONObject: j as Any, options: [])
                                let order = try JSONDecoder().decode(Order.self, from: data!)
                                if order.open{
                                    self.orders.append(order)
                                }
                                
                            }
                            catch {
                                print(error.localizedDescription)
                            }

                        }
                        self.tableView.reloadData()
                    }
                }
                
            }
            
        }
    }
}
