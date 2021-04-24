//
//  AddMovieViewController.swift
//  lab2_moviesApp
//
//  Created by moutaz hegazy on 2/5/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import UIKit

class AddMovieViewController: UIViewController {

    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var imageURLTxt: UITextField!
    @IBOutlet weak var rateTxt: UITextField!
    @IBOutlet weak var releaseDateTxt: UITextField!
    @IBOutlet weak var genreTxt: UITextField!
    
    var movieDelegate : AddMovies?
    
    var newMovie = Movie()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveMovie(_ sender: UIButton) {
        var accepted = true
        print("save pressed")
        if let title = titleTxt.text , !title.isEmpty{
            newMovie.title = title
            print(title)
        }else{
            accepted = false
        }
        
        if let imgURL = imageURLTxt.text , !imgURL.isEmpty{
            newMovie.image = URL(string: imgURL)
            print(imgURL)
        }else{
            accepted = false
        }
        
        if let rate = rateTxt.text , !rate.isEmpty{
            newMovie.rating = Double(rate) ?? 0.0
            print(rate)
        }else{
            accepted = false
        }
        
        if let releaseDate = releaseDateTxt.text , !releaseDate.isEmpty{
            newMovie.releaseYear = Int(releaseDate) ?? 1900
            print(releaseDate)
        }else{
            accepted = false
        }
        
        if let genre = genreTxt.text , !genre.isEmpty{
            newMovie.genre = genre.components(separatedBy: ",")
            print(newMovie.genre)
        }else{
            accepted = false
        }
        
        if accepted{
            CoreDataLayer.shared.addMovieToStorage(newMovie)
            movieDelegate?.addNewMovie(newMovie)
            NotificationCenter.default.post(name: .addMovieNotification, object: nil)
        }
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}


//MARK: - AddMovies Protocool
protocol AddMovies {
    func addNewMovie(_ movie : Movie)
}


//MARK: - ViewController AddMovies extension
extension ViewController : AddMovies{
    func addNewMovie(_ movie: Movie) {
        CoreDataLayer.shared.addMovieToStorage(movie)
            movies += [movie]
            tableView.reloadData()
    }
}


//MARK: - Notification Extension
extension Notification.Name{
    static let addMovieNotification = Notification.Name("AddMovie")
}


