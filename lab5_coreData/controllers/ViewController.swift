//
//  ViewController.swift
//  lab2_moviesApp
//
//  Created by moutaz hegazy on 2/5/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController{
    
    
//MARK:- instance varibales & outlets
    var movies : [Movie] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
//MARK:- class methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;
        
        movies = FacadeModel.shared.loadMovies()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(notificationAction(_:)), name: .addMovieNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        print("viewWillDisappear")
    }
        
    //MARK:- Action  Methods
    
    @objc func notificationAction(_ notification: Notification){
        print("Notified")
    }
    
    @IBAction func addMovie(_ sender: Any) {
        if let addMovieVC = storyboard?.instantiateViewController(identifier: "AddMovieVC") as? AddMovieViewController{
            addMovieVC.movieDelegate = self
            present(addMovieVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func clearList(_ sender: Any) {
        CoreDataLayer.shared.deleteAllFromStorage()
        movies.removeAll()
        self.tableView.reloadData()
    }
}



//MARK:- EXTENSION
extension ViewController : CachedImage{
    func cachedImage(at index: Int?, to url: URL) {
        if let ind = index{
            movies[ind].localImage = url
            CoreDataLayer.shared.addMovieToStorage(movies[ind])
        }
    }
}

