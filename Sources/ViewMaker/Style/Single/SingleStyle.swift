//
//  Stylable.swift
//  
//
//  Created by Kiarash Vosough on 3/11/22.
//

import Foundation

public protocol SingleStyle: Style where StyleContainer == StyleBlock {
    
    static func combine(_ styles: Self...)-> Self
    
    static func combine(_ styles: [Self])-> Self
    
    func combine(_ other: Self) -> Self
    
    func combine(_ otherStyling: @escaping (Stylable)-> Void)-> Self
}

public extension SingleStyle {
    
    static func combine(_ styles: Self...)-> Self {
        combine(styles)
    }
    
    static func combine(_ styles: [Self])-> Self {
        return Self { view in
            for style in styles {
                style.container(view)
            }
        }
    }
    
    func combine(_ other: Self) -> Self {
        return Self { view in
            self.container(view)
            other.container(view)
        }
    }
    
    func combine(_ otherStyling: @escaping (Stylable)-> Void)-> Self {
        return combine(Self(styleContainer: otherStyling))
    }
}
