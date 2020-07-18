//
//  NewOrderViewController.swift
//  Panther Express
//
//  Created by Christian Valencia on 7/18/20.
//  Copyright © 2020 PantherHacks. All rights reserved.
//

import UIKit

class NewOrderViewController: UIViewController {
    
    var execute = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func newOrder(_ sender: Any) {
        if !execute {
            performSegue(withIdentifier: "toSelectDelivery", sender: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}