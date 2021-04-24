//
//  MovieDetailsViewController.swift
//  lab2_moviesApp
//
//  Created by moutaz hegazy on 2/5/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var releaseYearLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var imageURL : URL?{
        didSet{
            if let url = imageURL{
                loadImage(from: url)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func loadImage(from url : URL){
        spinner.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async {
            if let imageData = try? Data(contentsOf: url)
            {
                DispatchQueue.main.async {
                    [weak self] in
                    self?.movieImageView?.image = UIImage(data: imageData)
                    self?.spinner.isHidden = true
                }
            }
        }
    }

}
