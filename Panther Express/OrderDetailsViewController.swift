//
//  OrderDetailsViewController.swift
//  Panther Express
//
//  Created by Christian Valencia on 7/19/20.
//  Copyright © 2020 PantherHacks. All rights reserved.
//

import UIKit

class OrderDetailsViewController: UIViewController {

    var order = Order()
    var execute = false
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var requestedBy: UILabel!
    @IBOutlet weak var executedBy: UILabel!
    @IBOutlet weak var store: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var upperButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !execute {
            upperButton.isEnabled = false
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
    

}
