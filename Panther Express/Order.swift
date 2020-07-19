//
//  Order.swift
//  Panther Express
//
//  Created by Christian Valencia on 7/18/20.
//  Copyright © 2020 PantherHacks. All rights reserved.
//

import Foundation

class Order: Codable {
    var id = UUID()
    
    var requestedBy = ""
    var excecutedBy = ""
   
    var excecuterRating = -1
    var requestRating = -1
    var open = false
    var inProgress = false
    var completead = false
    
    var deliveryLogitud = Double()
    var deliveryLatitud = Double()
    
    var pickUpLogitud = Double()
    var pickUpLatitud = Double()
    
    var storeName = ""
    var pickUpName = ""
    var date = ""
    var comments = ""
}
