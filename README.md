# ViewMaker

An Elegant library to manage your app sytling.

[![Swift](https://img.shields.io/badge/Swift-5.3_or_Higher-orange?style=flat-square)](https://img.shields.io/badge/Swift-5.1_5.2_5.3_5.4-Orange?style=flat-square)
[![Platforms](https://img.shields.io/badge/Platforms-iOS_9.0_/_macOS_10.11_Or_Higher-yellowgreen?style=flat-square)](https://img.shields.io/badge/Platforms-macOS_iOS_tvOS_watchOS_Linux_Windows-Green?style=flat-square)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Alamofire.svg?style=flat-square)](https://img.shields.io/cocoapods/v/Alamofire.svg)
[![Twitter](https://img.shields.io/badge/twitter-@Vosough_k-blue.svg?style=flat-square)](https://twitter.com/AlamofireSF)
[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

CocoAttributedStringBuilder: Elegant and Easy AttributedStringBuilder in Swift

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [SampleProjects](#Sample)
- [Usage](#Usage)
- [Contributors](#Contributors)
- [License](#license)

## Features

- [x] Support Single Style For A View
- [x] Support Multiple Styles For A View With Unique Key
- [x] Combining Styles and Transforming Them To Each Other
- [x] Style propertWrapper To Keep the Styles On ViewController(Handy for Changing Theme)
- [x] Follow A System Design For Creating Styles
- [x] Open for Extension And New Implementation 
- [ ] Supports `resultBuilder` On Creating Keyed Styles 

## Requirements

| Platform | Minimum Swift Version | Installation | Status |
| --- | --- | --- | --- |
| iOS 9.0+ | 5.3 | [SPM](#spm) | Tested |
| macOS 10.11+ | 5.3 | [SPM](#spm) | Tested |

## Installation

### SPM

## Sample

I have provided one sample project in the repository. To use it clone the repo, Source files for these are in the `IOSExamples` and `macOSExample` directory in project navigator. Have fun!

## Usage

Using ViewMaker has several steps to adopt the API.

### Step One

Create a factory class/struct which contains inner classes/structs which represent a nameSpace for the View to want to create style for. In each inner class/struct you can write methods/variables(getter) to return styles. These structure refers as AppStyle, where all of the styles gathered here.

Let's first get familiar with two type of Styles:

 - `KeyedViewStyle`: Use this style when you want to hold and apply several style on different conditions,Ex Here we defined a `ThemeTypes` so that we can use it to create a unique style for each of its cases.


 - `ViewStyle` : Use this style when your view just adopt one style once and for all, In this case you are responsible to change its style manually and apply another style on it (when it is needed). 

Take a look at below implementation. First we defined a `ThemeTypes` which can become handy when we use `KeyedViewStyle` and changing theme

```swift

enum ThemeTypes: Hashable {
    case dark
    case light
}

public struct AppStyle {

    public struct View {
    
        typealias Stylable = UIButton

        func passwordViewUltimate(radius: CGFloat) -> KeyedViewStyle<Stylable> {
            KeyedViewStyle(key: .dark) { view in
                view.backgroundColor = .red
                view.layer.cornerRadius = radius
            }
            .combine(with: .light) { view in
                view.backgroundColor = .blue
                view.layer.cornerRadius = radius * 1.5
            }
        }
        
        func passwordView(radius: CGFloat) -> KeyedViewStyle<Stylable> {
            KeyedViewStyle(key: .dark) { view in
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
}
```
### Step Two

Create a factory class/struct which contains sevaral methods/variables(getter) which each of them return a `Holder` which later we can apply styles from matching `Namesapce` on them.


```swift

struct ViewMaker {
    
    var button: RawViewHolder<UIButton> {
        RawViewHolder(view: UIButton(type: .custom))
    }

    var controller: RawViewHolder<UIViewController> {
        RawViewControllerHolder(view: UIViewController())
    }
}

```

### Step Three

Let's build a componnent

This is the simple usage of styling with `ViewStyle`.

> When using `ViewStyle` the `with` method always returns the specified `View` unless you annotate variable with `@Styled`.


```swift

final class HomeController: UIViewController {
    
    private let viewMaker = ViewMaker()
    
    lazy var button: UIButton = viewMaker
        .button
        .with(style: AppStyle.Button().usernameStaticView)
}


```

The more complex one is `KeyedStyle`, The three variable defined are the same but vary on implementation.

> `@Styled` propertyWrapper is used to wrapp `StyledComponnent`, so that you can use its `projecetedValue` to access view directly. otherwise the view is accessible within `componnent` variable of `StyledComponnent`.

> When using `KeyedStyle` the `with` method always returns  `StyledComponnent`.



```swift

final class HomeController: UIViewController {
    
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


```



## Contributors

Feel free to share your ideas or any other problems. Pull requests are welcomed.

## License

ViewMaker is released under an MIT license. See [LICENSE](https://github.com/kiarashvosough1999/ViewMaker/blob/master/LICENSE) for more information.
