//
//  NewPlacesVC.swift
//  FoursquareClone
//
//  Created by Oğuzhan Abuhanoğlu on 23.01.2023.
//

import UIKit

class NewPlacesVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    private let placeNameText : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Place name"
        textfield.textAlignment = .left
        textfield.backgroundColor = .secondarySystemBackground
        textfield.textColor = .label
        return textfield
    }()
    
    private let placeTypeText : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Place Type"
        textfield.textAlignment = .left
        textfield.backgroundColor = .secondarySystemBackground
        textfield.textColor = .label
        return textfield
    }()
    
    private let placeAtmosphereText : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Place Atmosphere"
        textfield.textAlignment = .left
        textfield.backgroundColor = .secondarySystemBackground
        textfield.textColor = .label
        return textfield
    }()
    
    private let placeImage : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = .label
        imageView.backgroundColor = .systemBackground
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private var nextButton : UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: UIControl.State.normal)
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

        view.backgroundColor = .systemBackground
        
        view.addSubview(placeNameText)
        view.addSubview(placeTypeText)
        view.addSubview(placeAtmosphereText)
        view.addSubview(placeImage)
        view.addSubview(nextButton)
        
        placeImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImage.addGestureRecognizer(gestureRecognizer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let widht = view.frame.size.width
        let height = view.frame.size.height
        
        placeNameText.frame = CGRect(x: widht * 0.5 - (widht * 0.8) / 2, y: height * 0.2 - 20, width: widht * 0.8, height: 40)
        
        placeTypeText.frame = CGRect(x: widht * 0.5 - (widht * 0.8) / 2, y: height * 0.3 - 20, width: widht * 0.8, height: 40)
        
        placeAtmosphereText.frame = CGRect(x: widht * 0.5 - (widht * 0.8) / 2, y: height * 0.4 - 20, width: widht * 0.8, height: 40)
        
        placeImage.frame = CGRect(x: widht * 0.5 - (widht * 0.8) / 2, y: height * 0.63 - (height * 0.3) / 2, width: widht * 0.8, height: height * 0.3)
        
        nextButton.frame = CGRect(x: widht * 0.5 - (widht * 0.8) / 2, y: height * 0.83 - 20, width: widht * 0.8, height: 40)
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: UIControl.Event.touchUpInside)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func chooseImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    

    @objc func nextButtonClicked() {
        
        if placeNameText.text != "" && placeTypeText.text != "" && placeAtmosphereText.text != "" {
            if let choosenImage = placeImage.image {
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placeNameText.text!
                placeModel.placeType = placeTypeText.text!
                placeModel.placeAtmosphere = placeAtmosphereText.text!
                placeModel.placeImage = choosenImage
            }
            
            performSegue(withIdentifier: "toMapVC", sender: nil)
        }else{
            self.makeAlert(titleInput: "Error!", messageInput: "Name / Type / Description ??")
            
        }
    }
    
    
    
    func makeAlert(titleInput : String, messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
        
    }
    
}
