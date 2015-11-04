//
//  MapViewAnnotation.swift
//  blueunicorn
//
//  Created by Thomas Blom on 5/3/15.
//  Copyright (c) 2015 Thomas Blom. All rights reserved.
//

import Foundation
import MapKit

extension MapViewController: MKMapViewDelegate {
 
	// 1
	func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
		if let annotation = annotation as? UnicornMapInfo {
			let identifier = "unicorn"
			var view: MKAnnotationView
			if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
				as? MKPinAnnotationView { // 2
					dequeuedView.annotation = annotation
					view = dequeuedView
			} else {
				// 3
				view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
				view.canShowCallout = true
				view.calloutOffset = CGPoint(x: -5, y: 5)
				view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
				view.image = UIImage( named: "unicorn_icon40x49.png" )

			}
			
			return view
		}
		return nil
	}
}