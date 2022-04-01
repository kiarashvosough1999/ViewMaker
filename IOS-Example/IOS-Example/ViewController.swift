//
//  ViewController.swift
//  IOS-Example
//
//  Created by Kiarash Vosough on 4/1/22.
//

import UIKit
import ViewMaker

class ViewController: UIViewController {
    
    private var viewMaker = ViewMaker()
    
    lazy var button: StyledComponnent<KeyedViewStyle<AppStyle.Button.Stylable>> = viewMaker
        .button
        .with(style: AppStyle.Button().passwordView(radius: 10))
    
    lazy var button2 = viewMaker
        .button
        .with(style: AppStyle.Button().passwordView(radius: 10))
    
    @Styled
    var button3 = ViewMaker()
        .button
        .with(style: AppStyle.Button().passwordView(radius: 10))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.componnent.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button2.componnent.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        $button3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

