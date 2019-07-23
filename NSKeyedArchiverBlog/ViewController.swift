//
//  ViewController.swift
//  NSKeyedArchiverBlog
//
//  Created by Erica Millado on 3/11/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var store = DataStore.sharedInstnce

    @IBOutlet weak var itemTextfield: UITextField!
    
    @IBAction func submitBtnTapped(_ sender: Any) {
        if itemTextfield.text != "" {
            if let unwrappedText = itemTextfield.text {
                let newShoppingListItem = ShoppingItem(name: unwrappedText)
                self.saveData(item: newShoppingListItem)
            }
        }
        
    }
    
    var filePath: String {
        //1 - manager lets you examine contents of a files and folders in your app; creates a directory to where we are saving it
        let manager = FileManager.default
        //2 - this returns an array of urls from our documentDirectory and we take the first path
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        print("this is the url path in the documentDirectory \(String(describing: url))")
        //3 - creates a new path component and creates a new file called "Data" which is where we will store our Data array.
        return (url!.appendingPathComponent("Data").path)
    }
    
    private func saveData(item: ShoppingItem) {
        self.store.shoppingItems.append(item)
        
        //4 - nskeyedarchiver is going to look in every shopping list class and look for encode function and is going to encode our data and save it to our file path.  This does everything for encoding and decoding.
        //5 - archive root object saves our array of shopping items (our data) to our filepath url
        //        NSKeyedArchiver.archiveRootObject(self.store.shoppingItems, toFile: filePath)
        do {
            NSKeyedArchiver.setClassName("ShoppingItem", for: ShoppingItem.self)

            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: self.store.shoppingItems, requiringSecureCoding: false)
            try archivedData.write(to: URL(fileURLWithPath: self.filePath))
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    private func loadData() {
        //6 - if we can get back our data from our archives (load our data), get our data along our file path and cast it as an array of ShoppingItems
        do {
            NSKeyedUnarchiver.setClass(ShoppingItem.self, forClassName: "ShoppingItem")
            let archivedData = try Data(contentsOf: URL(fileURLWithPath: self.filePath))
            if let ourData = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, ShoppingItem.self], from: archivedData) as? [ShoppingItem] {
                self.store.shoppingItems = ourData
            }
            //            if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [ShoppingItem] {
            //                self.store.shoppingItems = ourData
            //            }
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view, typically from a nib.
    }



}

