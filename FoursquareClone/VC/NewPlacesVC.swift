//
//  NewPlacesVC.swift
//  FoursquareClone
//
//  Created by Oğuzhan Abuhanoğlu on 23.01.2023.
//

import UIKit

class NewPlacesVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var placeAtmosphere: UITextField!
    @IBOutlet weak var placeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placeImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImage.addGestureRecognizer(gestureRecognizer)
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
    

    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if placeName.text != "" && placeType.text != "" && placeAtmosphere.text != "" {
            if let choosenImage = placeImage.image {
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placeName.text!
                placeModel.placeType = placeType.text!
                placeModel.placeAtmosphere = placeAtmosphere.text!
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
