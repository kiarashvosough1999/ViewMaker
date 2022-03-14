//
//  StyledComponnent.swift
//  
//
//  Created by Kiarash Vosough on 3/14/22.
//

import Foundation

public struct StyledComponnent<S> where S: Style {

    public var styleHolder: S
    
    public var componnent: S.Stylable

    public init(componnent: S.Stylable, styleHolder: S) {
        self.styleHolder = styleHolder
        self.componnent = componnent
    }
}
