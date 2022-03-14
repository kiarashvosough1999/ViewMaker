
#if os(macOS)

import AppKit

public typealias VMViewController = NSViewController

public typealias VMView = NSView

#endif

#if os(iOS)

import UIKit

public typealias VMViewController = UIViewController

public typealias VMView = UIView

#endif

public struct ViewMaker {}
