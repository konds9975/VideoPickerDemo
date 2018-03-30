//
//  ViewController.swift
//  VideoPickerDemo
//
//  Created by Kondiram Sonawane on 3/30/18.
//  Copyright © 2018 Kondiram Sonawane. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit
import AVFoundation
class ViewController: UIViewController {

    var playerController : AVPlayerViewController?
    @IBOutlet weak var view1: UIView!
    @IBAction func play(_ sender: Any) {
        
        playerController?.player?.play()
    }
    var imagePickerController = UIImagePickerController()
    var videoURL: URL?
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func openAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Choose Video", message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
            
            
           self.openCamrea()
           
        }
        
        let gallery = UIAlertAction(title: "Gallary", style: .default) { (action) in
           
            self.openGallery()
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
            
        }
        
        
        alertController.addAction(camera)
        alertController.addAction(gallery)
        alertController.addAction(cancel)
        let presentationController = alertController.popoverPresentationController
        presentationController?.barButtonItem = (sender as! UIBarButtonItem)
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    func openGallery()  {
        
            let mediaUI = UIImagePickerController()
            mediaUI.sourceType = .savedPhotosAlbum
            mediaUI.mediaTypes = [kUTTypeMovie as NSString as String]
            mediaUI.allowsEditing = false
            mediaUI.delegate = self
            present(mediaUI, animated: true, completion: nil)
        
        }
    func openCamrea()  {
        
        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = .camera
        mediaUI.mediaTypes = [kUTTypeMovie as NSString as String]
        mediaUI.allowsEditing = false
        mediaUI.delegate = self
        present(mediaUI, animated: true, completion: nil)
        
    }
    
}
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        videoURL = info[UIImagePickerControllerMediaURL] as? URL
        print("videoURL:\(String(describing: videoURL))")
        self.dismiss(animated: true, completion: nil)
        
        playerController = AVPlayerViewController()
        let player = AVPlayer(url: videoURL!)
        playerController?.player = player
        playerController?.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.addChildViewController(playerController!)
        self.view1.addSubview((playerController?.view)!)
        playerController?.view.frame = view1.bounds
       
        
    }
    
    
}
