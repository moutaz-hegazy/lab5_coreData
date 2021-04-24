//
//  FactoryBuilder.swift
//  lab5_coreData
//
//  Created by moutaz hegazy on 4/24/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import Foundation

enum Status{
    case online
    case offline
}

protocol Service {
    func loadMovies()->[Movie]
}

class Builder{
    static func build(status : Status)->Service{
        switch status {
        case .online:
            return NetworkModel.shared
        case .offline:
            return CoreDataLayer.shared
        }
    }
}
