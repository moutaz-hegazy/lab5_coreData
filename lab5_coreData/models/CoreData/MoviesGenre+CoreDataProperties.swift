//
//  MoviesGenre+CoreDataProperties.swift
//  lab5_coreData
//
//  Created by moutaz hegazy on 2/12/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//
//

import Foundation
import CoreData


extension MoviesGenre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoviesGenre> {
        return NSFetchRequest<MoviesGenre>(entityName: "MoviesGenre")
    }

    @NSManaged public var genre: String
    @NSManaged public var movie: NSSet

}

// MARK: Generated accessors for movie
extension MoviesGenre {

    @objc(addMovieObject:)
    @NSManaged public func addToMovie(_ value: MoviesData)

    @objc(removeMovieObject:)
    @NSManaged public func removeFromMovie(_ value: MoviesData)

    @objc(addMovie:)
    @NSManaged public func addToMovie(_ values: NSSet)

    @objc(removeMovie:)
    @NSManaged public func removeFromMovie(_ values: NSSet)

}
