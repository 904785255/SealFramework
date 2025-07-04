//
//  NetworkMonitor.swift
//  OnePartner
//
//  Created by bin sun on 2025/7/4.
//

import Foundation
import SwiftUI
import Network
import Combine
class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue   = DispatchQueue.init(label: "NetworkMonitor")
    
    @Published var isConnected: Bool = true
    @Published var isExpensive: Bool = false
    @Published var connectionType: NWInterface.InterfaceType?
    
    deinit {
        monitor.cancel()
    }
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                self?.isExpensive = path.isExpensive
                self?.connectionType = self?.getConnectionType(path)
            }
        }
        monitor.start(queue: queue)
        
    }
    
    private func getConnectionType(_ path: NWPath) -> NWInterface.InterfaceType? {
        if path.usesInterfaceType(.wifi) { return .wifi }
        else if path.usesInterfaceType(.cellular) { return .cellular }
        else if path.usesInterfaceType(.wiredEthernet) { return .wiredEthernet }
        return nil
    }
}


