//
//  NSViewStyle.swift
//  
//
//  Created by Kiarash Vosough on 3/11/22.
//

public struct ViewStyle<Stylable>: SingleStyle where Stylable: VMView {
    
    public var container: (Stylable) -> ()
    
    public init(styleContainer: @escaping (Stylable) -> ()) {
        self.container = styleContainer
    }
}
