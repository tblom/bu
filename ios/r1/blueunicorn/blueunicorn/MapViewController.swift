//
//  MapViewController.swift
//  blueunicorn
//
//  Created by Thomas Blom on 4/17/15.
//  Copyright (c) 2015 Thomas Blom. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

		@IBOutlet weak var mapView: MKMapView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
			let initialLocation = CLLocation(latitude: 30.248502, longitude: -97.752191)
				// town lake, near lamar footbridge.
			centerMapOnLocation( initialLocation );
			
			mapView.delegate = self
			
			HttpManager.getUnicornsWithSuccess( { (UnicornData) -> Void in
				let json = JSON( data: UnicornData )
				if let unicornArray = json["features"].array {
					dispatch_async( dispatch_get_main_queue(), {
						for unicorn in unicornArray {
							let coordLon =  unicorn["geometry"]["coordinates"][0].double
							let coordLat =  unicorn["geometry"]["coordinates"][1].double
							
							let unicornMapInfo = UnicornMapInfo ( title: unicorn["properties"]["title"].string!,
								date: unicorn["properties"]["date"].string!, coordinate: CLLocationCoordinate2D( latitude: coordLat!, longitude: coordLon! ) )
							
							self.mapView.addAnnotation( unicornMapInfo );
							print( "Added unicorn!" )
						}
					})
				}
			})
    }
	
		let regionRadius: CLLocationDistance = 4000
		func centerMapOnLocation(location: CLLocation) {
				let coordinateRegion = MKCoordinateRegionMakeWithDistance( location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
				mapView.setRegion(coordinateRegion, animated: true)
		}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
