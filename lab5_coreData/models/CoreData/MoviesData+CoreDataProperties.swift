//
//  MoviesData+CoreDataProperties.swift
//  lab5_coreData
//
//  Created by moutaz hegazy on 2/12/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//
//

import Foundation
import CoreData


extension MoviesData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoviesData> {
        return NSFetchRequest<MoviesData>(entityName: "MoviesData")
    }

    @NSManaged public var image: String?
    @NSManaged public var rating: Double
    @NSManaged public var releaseYear: Int64
    @NSManaged public var title: String
    @NSManaged public var genres: NSSet

}

// MARK: Generated accessors for genres
extension MoviesData {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: MoviesGenre)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: MoviesGenre)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}
