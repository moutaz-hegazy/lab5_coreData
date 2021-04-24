//
//  facadePattern.swift
//  lab5_coreData
//
//  Created by moutaz hegazy on 4/24/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import Foundation
import Network

class FacadeModel{
    
    private init()
    {
        monitor = NWPathMonitor()
    }
    private let monitor : NWPathMonitor
    public static var shared = FacadeModel()
    
    func loadMovies()->[Movie]{
        if Connection.shared.isConnected{
            print("Connected")
            return Builder.build(status: .online).loadMovies()
        }else{
            print("Not Connected!!")
            return Builder.build(status: .offline).loadMovies()
        }
    }
    
}
