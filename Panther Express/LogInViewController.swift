//
//  LogInViewController.swift
//  Panther Express
//
//  Created by Christian Valencia on 7/18/20.
//  Copyright © 2020 PantherHacks. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var emailText: FormTextField!
    @IBOutlet weak var passwordText: FormTextField!
    @IBOutlet weak var requestExecute: UISegmentedControl!
    
    var execute = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.makeAlert(titleInput: "Sign up compleated", messageInput: "Welcome to Panther Express")
                    self.passwordText.text = ""
                }
            }
        
        } else {
            makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
        }
        
    }
    
    @IBAction func logInClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")

                } else {
                    self.performSegue(withIdentifier: "toApp", sender: nil)

                }
            }
            
            
        } else {
            makeAlert(titleInput: "Error!", messageInput: "Username/Password?")

        }
    }
    
    @IBAction func requestOrExecute(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 1
        {
            execute = true
        }
        
        else
        {
            execute = false
        }
        
    }
    
    
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func unwindSeguetoLogIn(_ sender: UIStoryboardSegue)
    {
//           if let sourceViewController = sender.source as? TorneoCreadoViewController {
//                let torneo = sourceViewController.torneo
//                let newIndexPath = IndexPath(row: torneos.count, section: 0)
//                torneos.append(torneo)
//                tableView.insertRows(at: [newIndexPath], with: .automatic)
//            }
    
            
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        Execute.execute = execute
    }
    

}
