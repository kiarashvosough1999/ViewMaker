//
//  KeyedViewControllerStyle.swift
//  
//
//  Created by Kiarash Vosough on 3/14/22.
//

import Foundation

public struct KeyedViewControllerStyle<Stylable>: KeyedStyle where Stylable: VMViewController {

    public var container: Dictionary<AnyHashable, (Stylable) -> ()>
    
    public init(styleContainer: Dictionary<AnyHashable, (Stylable) -> ()>) {
        self.container = styleContainer
    }
}
