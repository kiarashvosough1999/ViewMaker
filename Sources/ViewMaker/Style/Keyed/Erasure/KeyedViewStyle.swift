//
//  KeyedViewStyle.swift
//  
//
//  Created by Kiarash Vosough on 3/13/22.
//

import Foundation

public struct KeyedViewStyle<Stylable>: KeyedStyle where Stylable: VMView {
    
    public var container: Dictionary<AnyHashable, (Stylable) -> ()>
    
    public init(styleContainer: Dictionary<AnyHashable, (Stylable) -> ()>) {
        self.container = styleContainer
    }
}
