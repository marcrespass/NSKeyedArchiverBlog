//
//  ViewController.swift
//  NSKeyedArchiverBlog
//
//  Created by Erica Millado on 3/11/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var store = DataStore.sharedInstance

    @IBOutlet weak var itemTextfield: UITextField!
    
    @IBAction func submitBtnTapped(_ sender: Any) {
        if let text = itemTextfield.text, text.isEmpty == false {
            let newShoppingListItem = ShoppingItem(name: text)
            self.saveData(item: newShoppingListItem)
        }
        
    }
    
    var filePath: String {
        //1 - manager lets you examine contents of a files and folders in your app; creates a directory to where we are saving it
        let fileManager = FileManager()
        //2 - this returns an array of urls from our documentDirectory and we take the first path
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { fatalError("Can't find Documents directory for User domain") }

        print("path to data file: \(url.path)")
        //3 - creates a new path component and creates a new file called "Data" which is where we will store our Data array.
        return (url.appendingPathComponent("keyedArchiverData.plist").path)
    }
    
    private func saveData(item: ShoppingItem) {
        self.store.shoppingItems.append(item)
        
        //4 - nskeyedarchiver is going to look in every shopping list class and look for encode function and is going
        // to encode our data and save it to our file path.  This does everything for encoding and decoding.
        //5 - archive root object saves our array of shopping items (our data) to our filepath url
        do {
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: self.store.shoppingItems, requiringSecureCoding: true)
            try archivedData.write(to: URL(fileURLWithPath: self.filePath))
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func loadData() {
        //6 - if we can get back our data from our archives (load our data), get our data along our
        // file path and cast it as an array of ShoppingItems
        if FileManager.default.fileExists(atPath: filePath) == false { return }
        do {
            let fileURL = URL(fileURLWithPath: self.filePath)
            let archivedData = try Data(contentsOf: fileURL)
            
            if let ourData = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, ShoppingItem.self], from: archivedData) as? [ShoppingItem] {
                self.store.shoppingItems = ourData
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

}
