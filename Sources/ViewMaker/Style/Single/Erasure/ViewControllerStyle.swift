//
//  NSViewControllerStyle.swift
//  
//
//  Created by Kiarash Vosough on 3/11/22.
//

public struct ViewControllerStyle<Stylable>: SingleStyle where Stylable: VMViewController {

    public var container: (Stylable) -> ()
    
    public init(styleContainer: @escaping (Stylable) -> ()) {
        self.container = styleContainer
    }
}
