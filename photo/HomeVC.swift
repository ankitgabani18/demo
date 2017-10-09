//
//  HomeVC.swift
//  photo
//
//  Created by MyDG on 06/10/17.
//  Copyright © 2017 Lead_Infosoft. All rights reserved.
//

import UIKit

class HomeVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //MARK:- Outlets
    let picker = UIImagePickerController()
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
    }
    
    //MARK:- Button Action
    @IBAction func btn_Action_camera(_ sender: UIBarButtonItem) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        }
        else
        {
            noCamera()
        }
    }
    
    func noCamera()
    {
        let alertVC = UIAlertController(title: "No Camera",message: "Sorry, this device has no camera",preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",style:.default,handler: nil)
        alertVC.addAction(okAction)
        present(alertVC,animated: true,completion: nil)
    }
    
    @IBAction func btn_Action_library(_ sender: UIBarButtonItem) {
        // iOS 11 support
        if #available(iOS 11, *) {
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion: nil)
            picker.popoverPresentationController?.barButtonItem = sender
        }
        else
        {
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated: true, completion: nil)
            picker.popoverPresentationController?.barButtonItem = sender
        }
    }
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
//        myImageView.contentMode = .scaleAspectFit //3
//        myImageView.image = chosenImage //4
        
        let frame = self.storyboard?.instantiateViewController(withIdentifier: "FrameVC") as! FrameVC
        frame.Image = chosenImage
        self.navigationController?.pushViewController(frame, animated: true)
        
        dismiss(animated:true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
