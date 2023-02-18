//
//  NotificationCenter.swift
//  Festa
//
//  Created by Ivan Kopiev on 01.12.2022.
//

import Foundation

extension NotificationCenter {
    @discardableResult
    class func addObserver(forName name: NSNotification.Name?, using block: @escaping
    (Notification) -> Void) -> NSObjectProtocol { NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil,
                                                                                         using: block)
    }
    
    class func post(_ name: NSNotification.Name, object: Any? = nil, userInfo: [AnyHashable : Any]? = nil ) {
        NotificationCenter.default.post(name: name, object: nil, userInfo: userInfo)
    }
    
    class func addObserver(_ observer: Any, selector: Selector, name: NSNotification.Name?, object: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
}

extension NSNotification.Name {
    static let AnInvitationCame = Notification.Name("AnInvitationCame")
    static let UserDataLoaded = Notification.Name("UserDataLoaded")
    static let TransactionFinished = Notification.Name("transactionFinished")
    static let CheckReceiptFinished = Notification.Name("CheckReceiptFinished")
	static let ContactsSentToServer = Notification.Name("ContactsSentToServer")
}
