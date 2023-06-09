//
//  utils.swift
//  flickFunnies
//
//  Created by Batista Tone on 19/05/23.
//

import UIKit


func hexStringToUIColor (hex: String)-> UIColor {
    
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    
}

func getImageFromUrl(imageURLString: String, imageView: UIImageView) {
   
           if let imageURL = URL(string: imageURLString) {
              
               let session = URLSession.shared
               
               
               let task = session.dataTask(with: imageURL) {  (data, response, error) in
                  
                   if let error = error {
                       print("Error loading image: \(error.localizedDescription)")
                       return
                   }
                   
                   
                   if let imageData = data {
                      
                       if let image = UIImage(data: imageData) {
                           DispatchQueue.main.async {
                               imageView.image = image
                           }
                       } else {
                           print("Unable to create image from data")
                       }
                   }
               }
               
               task.resume()
           }
}
