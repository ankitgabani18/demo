//
//  FrameVC.swift
//  photo
//
//  Created by MyDG on 06/10/17.
//  Copyright © 2017 Lead_Infosoft. All rights reserved.
//

import UIKit
import CoreImage

class FrameVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    //MARK:- Outlets
    @IBOutlet weak var img_Selected: UIImageView!
    @IBOutlet weak var img_frame: UIImageView!
    @IBOutlet weak var collectionview_frameVC: UICollectionView!
    
    var Image : UIImage!
    
    var frameArray:[String] = ["frame-1","frame-2","frame-3"]
    var EffectArray:[String] = [
        "CIPhotoEffectChrome",
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectNoir",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CISepiaTone"
    ]
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionview_frameVC.delegate = self
        self.collectionview_frameVC.dataSource = self
        
        img_Selected.image = Image
    }
    
    //MARK:- Colelctionview Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:FrameCell = collectionview_frameVC.dequeueReusableCell(withReuseIdentifier: "FrameCell", for: indexPath) as! FrameCell
//        cell.img_frameCell.image = (UIImage.init(named: frameArray[indexPath.row]))
        
//        cell.img_frameCell?.image = (UIImage.init(named: "Jennifer_Winget"))
        
        let inputImage = UIImage(named: "Jennifer_Winget")!
        let context = CIContext(options: nil)
        
        if let currentFilter = CIFilter(name: "CISepiaTone") {
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.setValue(0.5, forKey: kCIInputIntensityKey)
            
            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    
                    cell.img_frameCell.image = processedImage
                    // do something interesting with the processed image
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        img_frame.image = (UIImage.init(named: frameArray[indexPath.row]))
    }
    
    //MARK:- Button Action
    @IBAction func btn_Action_back(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Action_save(_ sender: UIButton) {
        
        let bottomImage = img_Selected.image
        let topImage = img_frame.image
        
        img_Selected.contentMode = UIViewContentMode.scaleAspectFill;
        img_frame.contentMode = UIViewContentMode.scaleAspectFill;
        
        let size = CGSize(width: img_Selected.frame.size.width, height: img_Selected.frame.size.height)
        UIGraphicsBeginImageContext(size)
        
//        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        bottomImage!.draw(in: areaSize)
        
        let areaSize = CGRect(x: 0, y: 0, width: img_Selected.frame.size.width, height: img_Selected.frame.size.height)
        
        bottomImage!.draw(in: areaSize)

        topImage!.draw(in: areaSize, blendMode: CGBlendMode.normal, alpha: 1.0)
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(newImage, self,#selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    
    // show message after image saved to photo gallery.
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        // show success or error message.
        if error == nil {
            print("Success")
//            self.showAlertMessage(alertTitle: "Success", alertMessage: "Image Saved To Photo Gallery")
        }
        else {
            print("Error")
//            self.showAlertMessage(alertTitle: "Error!", alertMessage: (error?.localizedDescription)! )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
