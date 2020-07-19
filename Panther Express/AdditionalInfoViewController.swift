//
//  AdditionalInfoViewController.swift
//  Panther Express
//
//  Created by Christian Valencia on 7/18/20.
//  Copyright © 2020 PantherHacks. All rights reserved.
//

import UIKit
import Firebase

class AdditionalInfoViewController: UIViewController {

    @IBOutlet weak var storeName: FormTextField!
    @IBOutlet weak var pickUpName: FormTextField!
    @IBOutlet weak var datePick: FormTextField!
    @IBOutlet weak var addComments: FormTextField!
    
    var order = Order()
    
    
    override func viewDidLoad() {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .dateAndTime
        timePicker.addTarget(self, action: #selector(self.dateChanged(datePicker:)), for: .valueChanged)
        datePick.inputView = timePicker
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognized:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(gestureRecognized: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        datePick.text = dateFormatter.string(from: datePicker.date)
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        order.storeName = storeName.text ?? "Default"
        order.pickUpName = pickUpName.text ?? "Default"
        order.date = datePick.text ?? "Default"
        order.comments = addComments.text ?? "Default"
        order.requestedBy = Auth.auth().currentUser!.email!
        order.open = true
        uploadOrder(order: order)
        performSegue(withIdentifier: "toNewOrder", sender: nil)
        
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
