//
//  Annotation.swift
//  Balet
//
//  Created by Guillermo Romo Jiménez on 06/12/18.
//  Copyright © 2018 memoromoj. All rights reserved.

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    var eta: String?
    var image: UIImage?
    var subtitle: String?
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
