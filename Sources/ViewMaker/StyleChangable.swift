//
//  StyleChangable.swift
//  
//
//  Created by Kiarash Vosough on 3/15/22.
//

import Foundation

protocol StyleChangable {
    
    associatedtype StyleType: Style
    
    func changeStyle<Key: Hashable>(with key: Key)
    
    func changeStyle<Key: Hashable>(with map: [String:[Key]])
}

extension StyleChangable where StyleType: KeyedStyle {
    
    func changeStyle<Key: Hashable>(with key: Key) {
        let mir = Mirror(reflecting: self)
        
        mir.children.forEach { child in
            if let child = child.value as? StyledComponnent<StyleType> {
                child.styleHolder.set(just: key, on: child.componnent)
            } else if let child = child.value as? Styled<StyleType> {
                child.wrappedValue.styleHolder.set(just: key, on: child.wrappedValue.componnent)
            }
        }
    }
    
    func changeStyle<Key: Hashable>(with map: [String:[Key]]) {
        let mir = Mirror(reflecting: self)
        
        mir.children.forEach { child in
            if let label = child.label {
                if let childValue = child.value as? Styled<StyleType>, let values = map[label] {
                    childValue.wrappedValue.styleHolder.set(just: values, on: childValue.wrappedValue.componnent)
                }
                else if let childValue = child.value as? StyledComponnent<StyleType>, let values = map[label] {
                    childValue.styleHolder.set(all: values, on: childValue.componnent)
                }
            }

        }
    }
}
