//
//  URLSessionConfiguration.swift
//  Festa
//
//  Created by Ivan Kopiev on 08.02.2023.
//

import Foundation

extension URLSessionConfiguration {
    class func sessionWith(timeout: TimeInterval) -> URLSessionConfiguration {
        let session = URLSessionConfiguration.default
        session.waitsForConnectivity = true
        session.timeoutIntervalForRequest = timeout
        session.multipathServiceType = .handover
        return session
    }
}
