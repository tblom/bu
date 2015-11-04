//
//  HttpManager.swift
//  blueunicorn
//
//  Created by Thomas Blom on 5/3/15.
//  Copyright (c) 2015 Thomas Blom. All rights reserved.
//

import Foundation

let UnicornIndexURL = "http://www.blueunicorn.net/api/index"
//let UnicornIndexURL = "http://localhost:3000/api/index"

class HttpManager {
	
	class func getUnicornsWithSuccess(success: ((UnicornData: NSData!) -> Void)) {
		//1
		loadDataFromURL(NSURL(string: UnicornIndexURL)!, completion:{(data, error) -> Void in
			//2
			if let urlData = data {
				//3
				success(UnicornData: urlData)
			}
		})
	}
	
	class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
		let session = NSURLSession.sharedSession()
		
		// Use NSURLSession to get data from an NSURL
		let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
			if let responseError = error {
				completion(data: nil, error: responseError)
			} else if let httpResponse = response as? NSHTTPURLResponse {
				if httpResponse.statusCode != 200 {
					let statusError = NSError(domain:"net.blueunicorn", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
					completion(data: nil, error: statusError)
				} else {
					completion(data: data, error: nil)
				}
			}
		})
		
		loadDataTask.resume()
	}
}
