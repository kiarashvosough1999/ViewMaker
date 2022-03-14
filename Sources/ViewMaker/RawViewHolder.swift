//
//  RawViewHolder.swift
//  
//
//  Created by Kiarash Vosough on 3/11/22.
//

import Foundation

public struct RawViewHolder<T> where T: VMView {
    
    internal var view: T
    
    @discardableResult public func with(style: ViewStyle<T>) -> T {
        style.set(on: view)
        return view
    }
    
    public func with<S>(style: S) -> StyledComponnent<S> where S: Style, S.Stylable == T {
        StyledComponnent(componnent: view, styleHolder: style)
    }
}
