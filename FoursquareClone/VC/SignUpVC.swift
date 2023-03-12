//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Oğuzhan Abuhanoğlu on 21.01.2023.
//

import UIKit
import Parse

class SignUpVC: UIViewController {
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signUpClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            let user = PFUser()
            user.username = usernameText.text
            user.password = passwordText.text
            
            user.signUpInBackground { success, error in
                if error != nil {
                    self.makeAlert(tittleInput: "Error", messageInput: error!.localizedDescription ?? "Error!!")
                }else{
                   
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
        }else{
            self.makeAlert(tittleInput: "Error!", messageInput: "Username / Password ??")
        }
        
    }
    
    
    
    @IBAction func signInClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { user, error in
                if error != nil {
                    self.makeAlert(tittleInput: "Error!", messageInput: error!.localizedDescription ?? "Error!!")
                }else{
                    
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
        }else{
            self.makeAlert(tittleInput: "Error!", messageInput: "Username / Password ??")
        }
        
        
    }
    
    
    
    
    func makeAlert(tittleInput : String, messageInput : String) {
        let alert = UIAlertController(title: tittleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

