//
//  AppStyle++View.swift
//  IOS-Example
//
//  Created by Kiarash Vosough on 4/1/22.
//

import ViewMaker
import UIKit

extension AppStyle.Button {
    
    typealias Stylable = UIButton

    func passwordViewUltimate(radius: CGFloat) -> KeyedViewStyle<Stylable> {
        KeyedViewStyle(key: ThemeTypes.dark) { view in
            view.backgroundColor = .red
            view.layer.cornerRadius = radius
        }
        .combine(with: ThemeTypes.light) { view in
            view.backgroundColor = .blue
            view.layer.cornerRadius = radius * 1.5
        }
    }
    
    func passwordView(radius: CGFloat) -> KeyedViewStyle<Stylable> {
        KeyedViewStyle(key: ThemeTypes.dark) { view in
            view.backgroundColor = .red
            view.layer.cornerRadius = radius
        }
    }
    
    func usernameView(radius: CGFloat) -> ViewStyle<Stylable> {
        ViewStyle { view in
            view.backgroundColor = .red
            view.layer.cornerRadius = radius
        }
    }
    
    var usernameStaticView: ViewStyle<Stylable> {
        ViewStyle { view in
            view.backgroundColor = .red
            view.layer.cornerRadius = 10
        }
    }
}
