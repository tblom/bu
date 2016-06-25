//
//  CameraController.swift
//  blueunicorn
//
//  Created by Thomas Blom on 6/25/16.
//  Copyright © 2016 Good Karma Software. All rights reserved.
//

import UIKit

class CameraController: UIViewController {

	var image: UIImage?
	let imagePicker = UIImagePickerController()
	
    override func viewDidLoad() {
        super.viewDidLoad()
	//	pickPhoto()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func takePhotoWithCamera() {
//		let imagePicker = UIImagePickerController()
		imagePicker.sourceType = .Camera
		imagePicker.delegate = self
		imagePicker.allowsEditing = true
		imagePicker.view.tintColor = view.tintColor
		presentViewController(imagePicker, animated: true, completion: nil)
	}
	
	func choosePhotoFromLibrary() {
//		let imagePicker = UIImagePickerController()
		imagePicker.sourceType = .PhotoLibrary
		imagePicker.delegate = self
		imagePicker.allowsEditing = true
		imagePicker.view.tintColor = view.tintColor
		presentViewController(imagePicker, animated: true, completion: nil)
	}
	
	func pickPhoto() {
		if UIImagePickerController.isSourceTypeAvailable(.Camera) {
			takePhotoWithCamera()
			// showPhotoMenu()
		}
		else {
			choosePhotoFromLibrary()
		}
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

extension CameraController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		image = info[UIImagePickerControllerEditedImage] as? UIImage
		
		if let metadata = info[UIImagePickerControllerMediaMetadata] as? NSDictionary {
			print( "Metadata for photograph:\n" )
			print( "\(metadata)" )
		}
		
		dismissViewControllerAnimated(false, completion: nil)
		
	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		print( "user cancel image capture" )
		dismissViewControllerAnimated(true, completion: nil)
	}
}


