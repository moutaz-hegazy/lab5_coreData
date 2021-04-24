//
//  ConnectionStatus.swift
//  lab5_coreData
//
//  Created by moutaz hegazy on 4/24/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import Foundation
import Network

class Connection {
    static let shared = Connection()
    
    private init(){}
    
    private let monitor = NWPathMonitor()
    
    public private(set) var isConnected = false
    
    public func startMonitoring(){
        monitor.start(queue: DispatchQueue.global())
        monitor.pathUpdateHandler = {
            [weak self]
            path in
            self?.isConnected = path.status != .unsatisfied
        }
    }
    
    
    public func stopMonitoring(){
        monitor.cancel()
    }
}
