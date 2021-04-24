//
//  tableViewSettings.swift
//  lab2_moviesApp
//
//  Created by moutaz hegazy on 2/5/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import Foundation
import UIKit

extension ViewController : UITableViewDelegate,UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? MovieTableViewCell;
        
            cell?.titleLbl.text = movies[indexPath.row].title
            cell?.imageDelegate = self
            cell?.cellIndex = indexPath.row
            if let url = movies[indexPath.row].image{
                cell?.loadImage(from: url,with : movies[indexPath.row].title)
            }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieDetailsVC = storyboard?.instantiateViewController(identifier: "MovieDetailsVC") as? ViewDetailesTableViewController{
                present(movieDetailsVC, animated: true, completion: {
                    [weak self] in
                    movieDetailsVC.titleLbl?.text = self?.movies[indexPath.row].title
                    
                    movieDetailsVC.movieImageView.image = (tableView.cellForRow(at: indexPath) as? MovieTableViewCell)?.movieImg.image
                    
                    movieDetailsVC.spinner.isHidden = true
                    movieDetailsVC.ratingLbl?.text = "Rate : \( String(self?.movies[indexPath.row].rating ?? -1))"
                    movieDetailsVC.releaseYearLbl?.text = "Release date : \(String(self?.movies[indexPath.row].releaseYear ?? -1))"
                    var genreString = "Genre : "
                    self?.movies[indexPath.row].genre.forEach({
                        genreString += "\($0), "
                    })
                    
                    movieDetailsVC.genreLbl?.text = genreString
                    
                    
                })
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
                CoreDataLayer.shared.deleteFromStorageIfExistsWith(title: movies[indexPath.row].title)
                movies.remove(at: indexPath.row)
                tableView.reloadData()
        }
    }
}
