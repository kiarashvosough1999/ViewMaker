//
//  RawViewControllerHolder.swift
//  
//
//  Created by Kiarash Vosough on 3/11/22.
//

import Foundation

public struct RawViewControllerHolder<T> where T: VMViewController {
    
    public var controller: T
    
    public init(controller: T) {
        self.controller = controller
    }
    
    @discardableResult
    public func with(style: ViewControllerStyle<T>) -> T {
        style.set(on: controller)
        return controller
    }
    
    public func using<S>(style: S) -> StyledComponnent<S> where S: Style, S.Stylable == T {
        StyledComponnent(componnent: controller, styleHolder: style)
    }
}
