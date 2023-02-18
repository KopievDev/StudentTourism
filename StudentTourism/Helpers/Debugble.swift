//
//  Debugble.swift
//  Festa
//
//  Created by Ivan Kopiev on 04.10.2022.
//

import UIKit

protocol Debugble {
    var debug: String { get }
    func log(_ log: String)
}

extension Debugble {
    var debug: String { "-\(Self.self)Debug" }
    func log(_ log: String) {
        if debug.isEnabledArgument { print("[\(Self.self)] - ", log) }
    }
    
}

extension String {
    var isEnabledArgument: Bool { CommandLine.arguments.contains(self) }
}


public protocol DebugMenuInteractionDelegate: AnyObject {
    func debugActions() -> [UIMenuElement]
}

public final class DebugMenuInteraction: UIContextMenuInteraction {
    
    class DelegateProxy: NSObject, UIContextMenuInteractionDelegate {
        weak var delegate: DebugMenuInteractionDelegate?
        var title: String
        
        public init(title: String) {
            self.title = title
        }
        
        public func contextMenuInteraction(
            _ interaction: UIContextMenuInteraction,
            configurationForMenuAtLocation location: CGPoint
        ) -> UIContextMenuConfiguration? {
            return UIContextMenuConfiguration(
                identifier: nil,
                previewProvider: nil
            ) { [weak self] _ in
                let actions = self?.delegate?.debugActions() ?? []
                return UIMenu(title: self?.title ?? "Festa", children: actions)
            }
        }
    }

    private let contextMenuDelegateProxy: DelegateProxy

    public init(delegate: DebugMenuInteractionDelegate, title: String) {
        let contextMenuDelegateProxy = DelegateProxy(title: title)
        contextMenuDelegateProxy.delegate = delegate
        self.contextMenuDelegateProxy = contextMenuDelegateProxy
        super.init(delegate: contextMenuDelegateProxy)
    }
}

extension UIView {
    public func addDebugMenuInteraction() {
        #if DEBUG
        guard let delegate = self as? DebugMenuInteractionDelegate else { return }
        let debugInteraction = DebugMenuInteraction(delegate: delegate, title: "Debug actions")
        addInteraction(debugInteraction)
        #endif
    }
    public func addMenuInteraction(title: String) {
        guard let delegate = self as? DebugMenuInteractionDelegate else { return }
        let debugInteraction = DebugMenuInteraction(delegate: delegate, title: title)
        addInteraction(debugInteraction)
    }
}
