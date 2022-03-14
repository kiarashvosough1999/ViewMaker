//
//  Styled.swift
//  
//
//  Created by Kiarash Vosough on 3/14/22.
//

import Foundation

@propertyWrapper
public struct Styled<S> where S: Style {
    
    public var wrappedValue: StyledComponnent<S>
    
    public var projectedValue: S.Stylable {
        wrappedValue.componnent
    }
    
    public init(wrappedValue: StyledComponnent<S>) {
        self.wrappedValue = wrappedValue
    }
}
