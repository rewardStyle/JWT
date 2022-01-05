//
//  TokenTextTypeDescription.swift
//  JWTDesktopSwift
//
//  Created by Lobanov Dmitry on 01.10.16.
//  Copyright © 2016 JWTIO. All rights reserved.
//

import SwiftUI

// MARK: Token text type.
public enum TokenTextType: Int {
    case unknown = 0
    case header
    case payload
    case signature
    case dot
    
    static var typicalSchemeComponents: [Self] {
        [.header, .dot, .payload, .dot, .signature]
    }
}

// MARK: NSAttributes.
extension TokenTextType {
    fileprivate var encodedTextAttributes: [NSAttributedString.Key: Any] {
        encodedTextAttributes(type: self)
    }
    
    fileprivate func encodedTextAttributes(type: TokenTextType) -> [NSAttributedString.Key: Any] {
        var attributes = self.defaultEncodedTextAttributes()
        attributes[NSAttributedString.Key.foregroundColor] = type.color
        return attributes
    }    
}

// MARK: Serialization
fileprivate class TokenTextSerialization {
    fileprivate func textPart(parts: [String], type: TokenTextType) -> String? {
        switch type {
        case .unknown: return nil
        case .header: return parts.first
        case .payload where parts.count > 1: return parts[1]
        case .signature where parts.count > 2: return parts[2..<parts.count].joined(separator: ".")
        case .dot: return "."
        default: return nil
        }
    }
    public init() {}
}

// MARK: Appearance.
public class TokenTextAppearance {
    private let serialization: TokenTextSerialization = .init()
    fileprivate func encodedAttributes(text: String, tokenSerialization: TokenTextSerialization) -> [(String, Attributes)] {
        let parts = text.components(separatedBy: ".")
        
        return TokenTextType.typicalSchemeComponents.flatMap { (type) -> [(String, Attributes)] in
            if let part = tokenSerialization.textPart(parts: parts, type: type) {
                let color = type.color
                let font = type.font
                return [(part, Attributes(color: color, font: font))]
            }
            return []
        }
    }
    public init() {}
}


// MARK: Appearance.Public.
public extension TokenTextAppearance {
    func encodedAttributes(text: String) -> [(string: String, attributes: Attributes)] {
        self.encodedAttributes(text: text, tokenSerialization: self.serialization)
    }
    
    func encodedAttributedString(text: String) -> NSAttributedString? {
        self.encodedAttributes(text: text, tokenSerialization: self.serialization).reduce(NSMutableAttributedString()) { (result, pair) in
            let (part, attributes) = pair
            let string = NSAttributedString(string: part, attributes: [
                .foregroundColor: attributes.color,
                .font: attributes.font
                ])
            result.append(string)
            return result
        }
    }
}
