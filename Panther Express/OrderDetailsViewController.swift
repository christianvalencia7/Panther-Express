//
//  OrderDetailsViewController.swift
//  Panther Express
//
//  Created by Christian Valencia on 7/19/20.
//  Copyright © 2020 PantherHacks. All rights reserved.
//

import UIKit
import Firebase

class OrderDetailsViewController: UIViewController {

    var order = Order()
    var execute = false
    var candidate = false
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var requestedBy: UILabel!
    @IBOutlet weak var executedBy: UILabel!
    @IBOutlet weak var store: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var upperButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !execute && !candidate {
            upperButton.isEnabled = false
            upperButton.title = ""
        }
        else if candidate{
            upperButton.title = "Execute Order"
        }
        
        
        if order.open {
            status.text = "Open"
        }
        else if order.inProgress {
            status.text = "In Progress"
        }
        else {
            status.text = "Compleated"
        }
        
        requestedBy.text = order.requestedBy
        executedBy.text = order.excecutedBy
        store.text = order.storeName
        date.text = order.date
        comments.text = order.comments
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func markClicked(_ sender: UIBarButtonItem) {
        if candidate {
            order.excecutedBy = Auth.auth().currentUser!.email!
            order.open = false
            order.inProgress = true
            uploadOrder(order: order)
            performSegue(withIdentifier: "toNewOrder", sender: nil)
        }
        
        else if execute {
            order.inProgress = false
            order.completead = true
            uploadOrder(order: order)
            performSegue(withIdentifier: "toOrders", sender: nil)
        }
    }
    
    
     @IBAction func locationsClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toLocations", sender: nil)
     }
     
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let viewController = segue.destination as? LocationsViewController {
            viewController.order = order
        }
    }
    

    //MARK: - ONLINE DATABASE MANAGMENT
    private func uploadOrder(order: Order) {
        let firestoreDatabase = Firestore.firestore()
        do {
            let jsonData = try JSONEncoder().encode(order)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            let firestoreOrder = [order.pickUpName : jsonObject] as [String : Any]
            firestoreDatabase.collection("Orders").document(order.id.uuidString).setData(firestoreOrder)

        }
        catch {
            print("ERROR!!! \(error.localizedDescription)")
        }
    }
    
}
