//
//  PlacesModel.swift
//  FoursquareClone
//
//  Created by Oğuzhan Abuhanoğlu on 23.01.2023.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeLatitude = ""
    var placeLongitude = ""
    var placeImage = UIImage()
    
    private init(){}
}
