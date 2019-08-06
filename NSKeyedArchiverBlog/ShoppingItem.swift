//
//  ShoppingItem.swift
//  NSKeyedArchiverBlog
//
//  Created by Erica Millado on 3/11/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import Foundation

//1 - Adopt the NSObject and NSCoding protocols
class ShoppingItem: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool = true

    //5 - A safe way of naming my decoder key(s)
    struct Keys {
        static let name = "name"
    }
    
     var name = ""

    //4 - my own initializer
    init(name: String) {
        self.name = name
    }
    
    //2 - this decodes our objects; this isn't called explicitly, it will be called with NSKeyedArchiver
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: Keys.name) as? String ?? "Unknown"
    }
    
    //3 - this encodes our objects (saves them)
    func encode(with coder: NSCoder) {
        //we are saving the name for the key "name"
        coder.encode(self.name, forKey: Keys.name)
    }
}
