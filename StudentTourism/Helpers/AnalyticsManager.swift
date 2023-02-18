//
//  Analytics.swift
//  Festa
//
//  Created by Ivan Kopiev on 10.11.2022.
//

import UIKit

protocol AnalyticsService: AnyObject, Debugble {
    func initialize(app: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    func track(event: AnalyticsEvent, data: [String:Any?])
    func setUser()
    func unsetUser()
    var trackingEvents: [AnalyticsEvent] { get }
}

extension AnalyticsService {
    func setUser() {}
    func unsetUser() {}
    func shouldTrack(event: AnalyticsEvent) -> Bool { trackingEvents.contains(event) }
    var trackingEvents: [AnalyticsEvent] { AnalyticsEvent.allCases }
}

class AnalyticsManager: AnalyticsService {
    
    static let shared: AnalyticsManager = AnalyticsManager()
    private(set) var services: [AnalyticsService] = []
    
    private init() {
//        services.append(FBService())
//        services.append(AdjustService())
    }
    
    func initialize(app: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        services.forEach { $0.initialize(app: app, launchOptions: launchOptions) }
    }
    
    func track(event: AnalyticsEvent, data: [String:Any?] = [:]) {
        for service in services where service.shouldTrack(event: event) {
            service.track(event: event, data: data)
        }
    }
    
    func setUser() {
        services.forEach { $0.setUser() }
    }
    
    func unsetUser() {
        services.forEach { $0.unsetUser() }
    }
    
}
