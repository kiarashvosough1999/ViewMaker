//
//  Style.swift
//  
//
//  Created by Kiarash Vosough on 3/14/22.
//

import Foundation

public protocol Style {
    
    associatedtype Stylable
    
    associatedtype StyleContainer
    
    typealias StyleBlock = (Stylable) -> Void
    
    var container: StyleContainer { get }
    
    init(styleContainer: StyleContainer)
    
    func set(on view: Stylable)
    
    func set(on views: Stylable...)
}

extension Style {
    
    public func set(on views: Stylable...) {
        for view in views {
            set(on: view)
        }
    }
}

extension Style where StyleContainer == StyleBlock {
    
    public func set(on view: Stylable) {
        container(view)
    }
}

extension Style where StyleContainer: Sequence, StyleContainer.Element == StyleBlock {
    
    public func set(on view: Stylable) {
        container.forEach { $0(view) }
    }
}

extension Style where StyleContainer == [AnyHashable:StyleBlock] {
    
    public func set(on view: Stylable) {
        container.forEach { $0.value(view) }
    }
}
