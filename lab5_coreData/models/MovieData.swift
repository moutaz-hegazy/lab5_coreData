//
//  MovieData.swift
//  lab2_moviesApp
//
//  Created by moutaz hegazy on 2/5/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import Foundation

struct Movie: Decodable{
    var title : String = ""
    var image : URL?
    var rating : Double = 0
    var releaseYear : Int = 0
    var genre : [String] = []
    var localImage :URL?
}
