//
//  NetworkModel.swift
//  lab5_coreData
//
//  Created by moutaz hegazy on 4/24/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import Foundation


class NetworkModel:Service{
    
    static let shared = NetworkModel()
    
    private init(){}
    
    
    func loadMovies() -> [Movie] {
        let url = URL(string: "https://api.androidhive.info/json/movies.json")
        
        return DispatchQueue.global(qos: .userInitiated).sync(execute: { () -> [Movie]? in
            guard let dataUrl = url,
                let webJson = try? String(contentsOf: dataUrl),
                let jsonData = webJson.data(using: .utf8),
                let moviesArr : [Movie] = try? JSONDecoder().decode([Movie].self, from: jsonData)
                else
            {
                return nil
            }
            return moviesArr
        }) ?? []
        
        //{
//                guard let dataUrl = url,
//                    let webJson = try? String(contentsOf: dataUrl),
//                    let jsonData = webJson.data(using: .utf8),
//                    let moviesArr : [Movie] = try? JSONDecoder().decode([Movie].self, from: jsonData)
//                    else
//                {
//                    return
//                }
//                DispatchQueue.main.async{
//
//                }
        //}
    }
    
//    private func fetch(fromUrl urlStr:String , with handler : (([Movie]?,NSError?)->Void)? = nil)
//    {
//
//        let url = URL(string: urlStr)
//
//        DispatchQueue.global(qos: .userInitiated).async{
//                guard let dataUrl = url,
//                    let webJson = try? String(contentsOf: dataUrl),
//                    let jsonData = webJson.data(using: .utf8),
//                    let moviesArr : [Movie] = try? JSONDecoder().decode([Movie].self, from: jsonData)
//                    else
//                {
//                    handler?(nil,NSError())
//                    return
//                }
//                DispatchQueue.main.async{
//                    handler?(moviesArr,nil)
//                }
//        }
//    }
}
