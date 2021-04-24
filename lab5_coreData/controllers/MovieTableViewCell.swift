//
//  MovieTableViewCell.swift
//  lab2_moviesApp
//
//  Created by moutaz hegazy on 2/5/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    
    var cellImage:UIImage?{
        get{
            return imageView?.image
        }
        set{
            imageView?.image = newValue
        }
    }
    var imageDelegate : CachedImage?
    var cellIndex : Int?
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    func loadImage(from url : URL, with title : String){
        spinner.isHidden = false
        spinner.startAnimating();
        DispatchQueue.global(qos: .userInitiated).async {
            if let imageData = try? Data(contentsOf: url)
            {
                DispatchQueue.main.async {
                    [weak self] in
                    self?.movieImg.image = UIImage(data: imageData)
                    self?.spinner.isHidden = true
                    
                    if let url = try? FileManager.default.url(for: .downloadsDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("\(self?.titleLbl.text ?? "none")"){
                        do{
                            try imageData.write(to: url)
                            self?.imageDelegate?.cachedImage(at: self?.cellIndex, to: url)
                        }catch{
                            print("couldn't sava image named \(self?.titleLbl.text ?? "none")")
                        }
                    }
                }
            }else{
                DispatchQueue.main.async{
                    [weak self] in
                    if let url = try? FileManager.default.url(for: .downloadsDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("\(title)"){
                        if let imgData = try? Data(contentsOf: url){
                            self?.movieImg?.image = UIImage(data: imgData)
                            self?.spinner.isHidden = true
                        }
                    }
                }
            }
        }
    }
}


protocol CachedImage {
    func cachedImage(at index :Int?,to url:URL)
}
