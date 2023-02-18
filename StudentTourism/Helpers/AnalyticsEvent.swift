//
//  AnalyticsEvent.swift
//  Festa
//
//  Created by Ivan Kopiev on 10.11.2022.
//

import Foundation

enum AnalyticsEvent : String, CaseIterable {
    case local_error
    case network_error
    case contacts_are_synced
    case contact_access_granted
}
