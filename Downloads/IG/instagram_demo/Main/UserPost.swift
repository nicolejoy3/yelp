//
//  UserPost.swift
//  instagram_demo
//
//  Created by Elizabeth on 2/23/18.
//  Copyright © 2018 Elizabeth. All rights reserved.
//

import UIKit
import Parse


class UserPost: NSObject {


    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        
        let post = PFObject(className: "UserPost")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image: image) // PFFile column type
        post["username"] = PFUser.current() // Pointer column type that points to PFUser
        post["caption"] = caption
      
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // Check if image is not nil
        if let image = image {
            // Get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "some Image.png", data: imageData)
            }
        }
        return nil
    }

}
