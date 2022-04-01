//
//  RawViewHolder.swift
//  
//
//  Created by Kiarash Vosough on 3/11/22.
//

import Foundation

public struct RawViewHolder<T> where T: VMView {
    
    public var view: T
    
    public init(view: T) {
        self.view = view
    }
    
    @discardableResult
    public func with(style: ViewStyle<T>) -> T {
        style.set(on: view)
        return view
    }
    
    public func using<S>(style: S) -> StyledComponnent<S> where S: Style, S.Stylable == T {
        StyledComponnent(componnent: view, styleHolder: style)
    }
}
