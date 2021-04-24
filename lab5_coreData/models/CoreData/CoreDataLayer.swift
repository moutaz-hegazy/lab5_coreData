//
//  CoreDataLayer.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/6/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataLayer : Service{
    
    private(set) var stordMovies = [MoviesData]()
    private static var coreDataObj = CoreDataLayer()
    static var shared : CoreDataLayer {
        get{
            coreDataObj.getDataFromStorage()
            return coreDataObj
        }
    }
    
    private init(){}
    
    
    func loadMovies() -> [Movie] {
        return stordMovies.map{
            value in
            var movie = Movie()
            movie.title = value.title
            movie.image = URL(string: value.image ?? "")
            movie.rating = value.rating
            movie.releaseYear = Int(value.releaseYear)
            if let genres = value.genres.allObjects as? [MoviesGenre]{
                for genre in genres{
                    movie.genre += [genre.genre]
                }
            }
            return movie
        }
    }
    
    //MARK:- Core Data Methods
    private func getDataFromStorage(){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest : NSFetchRequest<MoviesData> = MoviesData.fetchRequest()
            do{
                stordMovies = try managedContext.fetch(fetchRequest)
            }catch let error as NSError{
                print(error)
            }
        }
    }

    
    func addMovieToStorage(_ movie: Movie){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let managedContext = appDelegate.persistentContainer.viewContext
            
            if movie.localImage != nil,!movieExistsWith(title : movie.title){
                let newMovie = MoviesData(context: managedContext)
                newMovie.title = movie.title
                newMovie.image = movie.localImage?.relativeString
                newMovie.rating = movie.rating
                newMovie.releaseYear = Int64(movie.releaseYear)
                
                for genre in movie.genre{
                    let movieGenre = MoviesGenre(context: managedContext)
                    movieGenre.genre = genre
                    newMovie.addToGenres(movieGenre)
                }
                stordMovies += [newMovie]
            
                do{
                    try managedContext.save()
                    print("<<<<< SAVED")
                }catch let error as NSError{
                    print(error)
                }
            }
        }
    }
    
    private func movieExistsWith(title: String )->Bool{
        getDataFromStorage()
        for movie in stordMovies{
            if(movie.title == title){
                return true
            }
        }
        return false
    }
    
    

    func deleteFromStorage(at index:Int ){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(stordMovies[index])
            
            if let url = try? FileManager.default.url(for: .downloadsDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("\(stordMovies[index].title)"){
                do{
                    try FileManager.default.removeItem(at: url)
                    print("Image deleted")
                }catch{
                    print("couldn't delete Image")
                }
            }
            do{
                try managedContext.save();
                print("item Deleted")
            }catch let error as NSError{
                print(error);
            }
        }
    }

    func deleteFromStorageIfExistsWith(title : String){
        getDataFromStorage()
        for movie in stordMovies{
            if movie.title == title{
                if let index = stordMovies.firstIndex(of: movie){
                    deleteFromStorage(at: index)
                    stordMovies.remove(at: index)
                }
            }
        }
    }

    func deleteAllFromStorage(){
        for index in stordMovies.indices{
            deleteFromStorage(at: index)
        }
        stordMovies.removeAll()
    }
}
