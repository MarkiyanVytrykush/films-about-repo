//
//  NetworkMonitorService.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Network

final class NetworkMonitorService {
    enum Reachable {
        case yes, no
    }
    
    private let monitor: NWPathMonitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .utility)
    private var reachableStatus: Reachable?
    
    var isReachable: Bool {
        reachableStatus == .yes
    }
    
    init() {
        monitor.start(queue: queue)
    }
    
    func monitorChanges( callBack: @escaping (_ rechable: Reachable) -> Void ) -> Void {
        if reachableStatus == nil {
            setInitialStatus()
        }
        monitor.pathUpdateHandler = { [weak self] path in
            
            let reachable = (path.status == .unsatisfied || path.status == .requiresConnection)  ? Reachable.no  : Reachable.yes

            guard reachable != self?.reachableStatus else {
                return // Status not changed
            }
            Log.atention("Network Connection Changed to '\(path.status)' \(reachable == .yes ? "✅" : "⛔️")")
            self?.reachableStatus = reachable
            callBack(reachable)
        }
    }
    
    private func setInitialStatus() {
        let currentStatus = monitor.currentPath.status
        reachableStatus = (currentStatus == .unsatisfied || currentStatus == .requiresConnection)  ? Reachable.no  : Reachable.yes
    }
}
