//
//  RawViewControllerHolder.swift
//  
//
//  Created by Kiarash Vosough on 3/11/22.
//

import Foundation

public struct RawViewControllerHolder<T> where T: VMViewController {
    
    internal var controller: T
    
    @discardableResult public func with(style: ViewControllerStyle<T>) -> T {
        style.set(on: controller)
        return controller
    }
    
    public func with<S>(style: S) -> StyledComponnent<S> where S: Style, S.Stylable == T {
        StyledComponnent(componnent: controller, styleHolder: style)
    }
}
