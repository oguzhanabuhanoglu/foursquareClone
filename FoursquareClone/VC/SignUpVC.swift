//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Oğuzhan Abuhanoğlu on 21.01.2023.
//

import UIKit
import Parse

class SignUpVC: UIViewController {
    
    private let appNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Foursquare Clone"
        label.textColor = .label
        label.font = UIFont(name:  "Helvetica", size: 25)
        label.textAlignment = .center
        label.backgroundColor = .systemBackground
        return label
    }()
    
    private let usernameText : UITextField = {
        let textField = UITextField()
        textField.placeholder = "username"
        textField.textAlignment = .left
        textField.backgroundColor = .secondarySystemBackground
        textField.textColor = .label
        return textField
    }()
    
    private let passwordText : UITextField = {
        let textField = UITextField ()
        textField.placeholder = "password"
        textField.textAlignment = .left
        textField.backgroundColor = .secondarySystemBackground
        textField.textColor = .label
        return textField
    }()
    
    private let signInButton : UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: UIControl.State.normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(UIColor.label, for: UIControl.State.normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        return button
    }()
    
    private let logInButton : UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: UIControl.State.normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(UIColor.label, for: UIControl.State.normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(appNameLabel)
        view.addSubview(usernameText)
        view.addSubview(passwordText)
        view.addSubview(signInButton)
        view.addSubview(logInButton)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let widht = view.frame.size.width
        let height = view.frame.size.height
        
        appNameLabel.frame = CGRect(x: widht * 0.5 - (widht * 0.8) / 2, y: height * 0.2 - 35, width: widht * 0.8, height: 70)
        
        usernameText.frame = CGRect(x: widht * 0.5 - (widht * 0.8) / 2 , y: height * 0.3 - 20, width: widht * 0.8, height: 40)
        
        passwordText.frame = CGRect(x: widht * 0.5 - (widht * 0.8) / 2 , y: height * 0.37 - 20, width: widht * 0.8, height: 40)
        
        signInButton.frame = CGRect(x: widht * 0.25 - (widht * 0.3) / 2, y: height * 0.44 - 20, width: widht * 0.3, height: 40)
        signInButton.addTarget(self, action: #selector(signInClicked), for: UIControl.Event.touchUpInside)
        
        
        logInButton.frame = CGRect(x: widht * 0.75 - (widht * 0.3) / 2, y: height * 0.44 - 20, width: widht * 0.3, height: 40)
        logInButton.addTarget(self, action: #selector(logInClicked), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    @objc func signInClicked() {
        
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
    
    
    
    @objc func logInClicked() {
        
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

