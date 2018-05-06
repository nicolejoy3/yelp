//
//  PhotoMapViewController.swift
//  instagram_demo
//
//  Created by Elizabeth on 2/21/18.
//  Copyright © 2018 Elizabeth. All rights reserved.
//

import UIKit
import Parse

class PhotoMapViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate {
    

    @IBOutlet weak var takeImageView: UIImageView!
    @IBOutlet weak var captiontextView: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        captiontextView.delegate = self as? UITextFieldDelegate
        captiontextView.textColor = UIColor.gray
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickPhoto(tapGestureRecognizer: )))
        takeImageView.addGestureRecognizer(tapGestureRecognizer)
        takeImageView.isUserInteractionEnabled = true

    }

    
    @IBAction func onCancel(_ sender: Any) {
        self.performSegue(withIdentifier: "backtoHome", sender: nil)
    }
    
    @IBAction func onShare(_ sender: Any) {
        if self.takeImageView.image == nil {
            print("No Photo was selected, could not share")
            return
        }
        let resizedImage = resize(image: takeImageView.image!, newSize: CGSize(width: 200, height: 200))
        let caption = captiontextView.text
        UserPost.postUserImage(image: resizedImage, withCaption: caption) {(success: Bool, error: Error?) in
            if success {
                print("Upoloded photo")
                self.takeImageView.image = nil
                self.captiontextView.text = ""
            } else {
                print(error?.localizedDescription ?? "Error sharing photo")
            }
        }
        toHome()
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            takeImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func pickPhoto(tapGestureRecognizer: UITapGestureRecognizer) {
        imagePicker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available")
            imagePicker.sourceType = .camera
        }
        else {
            print("Camera is not available, using photo library instead")
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if captiontextView.text == "Enter a caption" {
            captiontextView.text = ""
            captiontextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if captiontextView.text == "" {
            captiontextView.text = "Enter a caption"
            captiontextView.textColor = UIColor.gray
        }
        captiontextView.resignFirstResponder()
    }
    
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    func toHome() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        view.window!.layer.add(transition, forKey: kCATransition)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "Home")
        present(mainViewController, animated: false, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
