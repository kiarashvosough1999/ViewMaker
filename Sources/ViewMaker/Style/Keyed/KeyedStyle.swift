//
//  KeyedStyleHolder.swift
//  
//
//  Created by Kiarash Vosough on 3/13/22.
//

import Foundation

public enum KeyedStyleMergePolicy<Stylable: KeyedStyle> {
    
    public typealias Which = (Stylable.StyleBlock, Stylable.StyleBlock) -> Stylable.StyleBlock

    case first
    case second
    case choose(which: Which)
}

public protocol KeyedStyle: Style where StyleContainer == [AnyHashable:StyleBlock] {


    static func combine(policy: KeyedStyleMergePolicy<Self>, _ styles: Self...)-> Self
    
    static func newStyle(key: AnyHashable, _ style: @escaping StyleBlock) -> Self


    func combine(policy: KeyedStyleMergePolicy<Self>, _ other: Self) -> Self
    
    func combine(policy: KeyedStyleMergePolicy<Self>, with key: AnyHashable, _ otherStyling: @escaping StyleBlock) -> Self


    func set(just key: AnyHashable, on view: Stylable)
    
    func set(all keys: [AnyHashable], on view: Stylable)
    
    func set(just key: AnyHashable, on views: Stylable...)
    
    func set(all keys: [AnyHashable], on views: Stylable...)
    
    func set(just key: AnyHashable, on views: [Stylable])
    
    func set(all keys: [AnyHashable], on views: [Stylable])
    
    func style(for key: AnyHashable) -> StyleBlock?
    
    func singleStyle<S>(with key: AnyHashable) -> S? where S: SingleStyle, S.Stylable == Self.Stylable
    
    subscript(_ key: AnyHashable) -> StyleBlock? { get }
}

extension KeyedStyle {
    
    public init(stylePairs: [(AnyHashable, StyleBlock)]) {
        self.init(styleContainer: Dictionary(uniqueKeysWithValues: stylePairs))
    }
    
    public init(key: AnyHashable, _ style: @escaping StyleBlock) {
        self.init(styleContainer: [key:style])
    }
    
    public static func newStyle(key: AnyHashable, _ style: @escaping StyleBlock) -> Self {
        self.init(key: key, style)
    }
    
    public static func combine(policy: KeyedStyleMergePolicy<Self> = .first, _ styles: Self...)-> Self {
        var pairs = StyleContainer()
        styles.forEach { style in
            pairs.merge(style.container) { firstStyle, secondStyle in
                switch policy {
                case .first: return firstStyle
                case .second: return secondStyle
                case .choose(let which): return which(firstStyle, secondStyle)
                }
            }
        }
        return Self.init(styleContainer: pairs)
    }
    
    public func combine(policy: KeyedStyleMergePolicy<Self> = .first, _ other: Self) -> Self {
        return Self.combine(policy: policy, other)
    }
    
    public func combine(policy: KeyedStyleMergePolicy<Self> = .first, with key: AnyHashable, _ otherStyling: @escaping StyleBlock) -> Self {
        return combine(policy: policy, Self(styleContainer: [key: otherStyling]))
    }
    
    public func set(on view: Stylable) {
        container.forEach { $0.value(view) }
    }
    
    public func set(just key: AnyHashable, on view: Stylable) {
        container.forEach { if key == $0.key { $0.value(view) } }
    }
    
    public func set(all keys: [AnyHashable], on view: Stylable) {
        container.forEach { if keys.contains($0.key) { $0.value(view) } }
    }
    
    public func set(just key: AnyHashable, on views: Stylable...) {
        for view in views {
            set(just: key, on: view)
        }
    }
    
    public func set(all keys: [AnyHashable], on views: Stylable...) {
        for view in views {
            set(all: keys, on: view)
        }
    }
    
    public func set(just key: AnyHashable, on views: [Stylable]) {
        set(just: key, on: views)
    }
    
    public func set(all keys: [AnyHashable], on views: [Stylable]) {
        set(all: keys, on: views)
    }
    
    public func set(on views: Stylable...) {
        for view in views {
            set(on: view)
        }
    }
    
    public func style(for key: AnyHashable) -> StyleBlock? {
        self[key]
    }
    
    public func singleStyle<S>(with key: AnyHashable) -> S? where S: SingleStyle, S.Stylable == Self.Stylable {
        guard let value = self[key] else { return nil }
        return S(styleContainer: value)
    }
    
    public subscript(_ key: AnyHashable) -> StyleBlock? {
        get {
            self.container[key]
        }
    }
    
    public func set<Key>(just key: Key, on view: Stylable) where Key: Hashable {
        set(just: AnyHashable(key), on: view)
    }

    public func set<Key>(all keys: [Key], on view: Stylable) where Key: Hashable {
        set(all: keys.map { AnyHashable($0) }, on: view)
    }

    public func set<Key>(just key: Key, on views: Stylable...) where Key: Hashable {
        set(just: AnyHashable(key), on: views)
    }

    public func set<Key>(all keys: [Key], on views: Stylable...) where Key: Hashable {
        set(all: keys.map { AnyHashable($0) }, on: views)
    }

    public func style<Key>(for key: Key) -> StyleBlock? where Key: Hashable {
        style(for: AnyHashable(key))
    }

    public func singleStyle<S,Key>(key: Key) -> S? where S: SingleStyle, S.Stylable == Self.Stylable, Key: Hashable {
        singleStyle(with: AnyHashable(key))
    }

    public subscript<Key>(_ key: Key) -> StyleBlock? where Key: Hashable {
        get {
            self[AnyHashable(key)]
        }
    }
}
