//
//  ViewMaker.swift
//  IOS-Example
//
//  Created by Kiarash Vosough on 4/1/22.
//

import ViewMaker
import UIKit

struct ViewMaker {
    
    var button: RawViewHolder<UIButton> {
        RawViewHolder(view: UIButton(type: .custom))
    }

    var controller: RawViewHolder<UIViewController> {
        RawViewControllerHolder(view: UIViewController())
    }
}
