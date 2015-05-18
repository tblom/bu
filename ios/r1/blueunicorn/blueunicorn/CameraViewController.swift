//
//  CameraViewController.swift
//  blueunicorn
//
//  Created by Thomas Blom on 5/15/15.
//  Copyright (c) 2015 Thomas Blom. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    @IBOutlet weak var cameraView: UIImageView!

    let captureSession = AVCaptureSession()

    var previewLayer : AVCaptureVideoPreviewLayer?
    var imageCapture : AVCaptureStillImageOutput?
    
    // If we find a device we'll store it here for later use
    var captureDevice : AVCaptureDevice?
    
    override func viewDidLoad() {
        println( "View did load!" )
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
        let devices = AVCaptureDevice.devices()
        
        // Loop through all the capture devices on this phone
        for device in devices {
            // Make sure this particular device supports video
            if (device.hasMediaType(AVMediaTypeVideo)) {
                // Finally check the position and confirm we've got the back camera
                if(device.position == AVCaptureDevicePosition.Front) {
                    captureDevice = device as? AVCaptureDevice
                    if captureDevice != nil {
                        println("Capture device found")
                        beginSession()
                        break
                    }
                }
            }
        }
        
    }
    
    func beginSession() {

        var err : NSError? = nil
        var input = AVCaptureDeviceInput(device: captureDevice, error: &err)
        
        if err != nil {
            println("error: \(err?.localizedDescription)")
        }

        captureSession.addInput( input )

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraView.layer.addSublayer(previewLayer)
        
        previewLayer?.frame = cameraView.bounds;
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill;
        println( "camera preview rect is \(previewLayer?.frame)")
        
        imageCapture = AVCaptureStillImageOutput()
        captureSession.addOutput( imageCapture )
        
        captureSession.startRunning()
    }
    

    @IBAction func takePicture(sender: UIButton) {
        var videoConnection : AVCaptureConnection?
        for connection in self.imageCapture!.connections{
            for port in connection.inputPorts!{
                if port.mediaType == AVMediaTypeVideo{
                    videoConnection = connection as? AVCaptureConnection
                    break //for ports
                }
            }
            if videoConnection != nil{
                break //for connections
            }
        }
        if( videoConnection != nil ) {
            imageCapture?.captureStillImageAsynchronouslyFromConnection(videoConnection) {
            
                (imageSampleBuffer : CMSampleBuffer!, _) in
            
                let imageDataJpeg = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageSampleBuffer)
                
                var image: UIImage = UIImage( data: imageDataJpeg )!
                UIImageWriteToSavedPhotosAlbum( image, nil, nil, nil )
                
            }
            self.captureSession.stopRunning()
        }
    }
}
