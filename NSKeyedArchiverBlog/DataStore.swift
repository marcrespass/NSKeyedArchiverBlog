//
//  DataStore.swift
//  NSKeyedArchiverBlog
//
//  Created by Erica Millado on 3/12/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import Foundation

class DataStore {
    
    static let sharedInstance = DataStore()
    private init() {}
    var shoppingItems: [ShoppingItem] = []
}
