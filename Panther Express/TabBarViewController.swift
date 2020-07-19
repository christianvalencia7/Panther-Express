//
//  TabBarViewController.swift
//  Panther Express
//
//  Created by Christian Valencia on 7/19/20.
//  Copyright © 2020 PantherHacks. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var execute = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let viewController = segue.destination as? NewOrderViewController {
            viewController.execute = self.execute
        }
        
        if let viewController = segue.destination as? OrdersTableViewController {
            viewController.execute = self.execute
        }
    }
    

}
