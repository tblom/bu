//
//  UnicornMapInfo.swift
//  blueunicorn
//
//  Created by Thomas Blom on 5/2/15.
//  Copyright (c) 2015 Thomas Blom. All rights reserved.
//

import Foundation
import MapKit

class UnicornMapInfo: NSObject, MKAnnotation {
	let title: String
	let date: String
	let coordinate: CLLocationCoordinate2D
 
	init(title: String, date: String, coordinate: CLLocationCoordinate2D) {
		self.title = title
		self.date = date
		self.coordinate = coordinate
		
		super.init()
	}
 
	var subtitle: String {
		return date
	}
}
