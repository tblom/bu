//
//  CaptureAndUploadController.swift
//  blueunicorn
//
//  Created by Thomas Blom on 6/24/16.
//  Copyright © 2016 Good Karma Software. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
	
	var image: UIImage?
		// the last image we took or chose, which the user may upload.
	
	@IBAction func cameraButton() {
		pickPhoto()
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

	
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		print( "prepareForSegue with identifier \(segue.identifier)" )
		if segue.identifier == "Camera" {
		}
    }

}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func takePhotoWithCamera() {
		let imagePicker = UIImagePickerController()
		imagePicker.sourceType = .Camera
		imagePicker.delegate = self
		imagePicker.allowsEditing = true
		imagePicker.view.tintColor = view.tintColor
		presentViewController(imagePicker, animated: true, completion: nil)
	}
	
	func choosePhotoFromLibrary() {
		let imagePicker = UIImagePickerController()
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
	func showPhotoMenu() {
		let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
		let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
		alertController.addAction(cancelAction)
		let takePhotoAction = UIAlertAction(title: "Take Photo", style: .Default, handler: { _ in
			self.takePhotoWithCamera()
		})
		alertController.addAction(takePhotoAction)
		let chooseFromLibraryAction = UIAlertAction(title:"Choose From Library", style: .Default, handler:{ _ in
			self.choosePhotoFromLibrary()
		})
		alertController.addAction(chooseFromLibraryAction)
		presentViewController(alertController, animated: true, completion: nil)
	}
*/
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		image = info[UIImagePickerControllerEditedImage] as? UIImage
		
		if let metadata = info[UIImagePickerControllerMediaMetadata] as? NSDictionary {
			print( "Metadata for photograph:\n" )
			print( "\(metadata)" )
		}
		
		dismissViewControllerAnimated(false, completion: nil)
		
		if image != nil {
			performSegueWithIdentifier( "Upload", sender: self )
		}
	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	
}

