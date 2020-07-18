//
//  Order.swift
//  Panther Express
//
//  Created by Christian Valencia on 7/18/20.
//  Copyright © 2020 PantherHacks. All rights reserved.
//

import Foundation

class Order: Codable {
    var requestedBy = User()
    var excecutedBy = User()
    var date = Date()
    var excecuterRating = -1
    var requestRating = -1
    var open = false
    var inProgress = false
    var completead = false
    
    var pickupLocation = ""
    var deliveryLocation = ""
}
