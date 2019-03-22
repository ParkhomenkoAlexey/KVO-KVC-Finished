//
//  ViewController.swift
//  KVO&KVC SwiftBook.ru
//
//  Created by Алексей Пархоменко on 22/03/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

class Person: NSObject {
    @objc dynamic var name = String()
}

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @objc let taylor = Person()
    
    @objc dynamic var inputText: String?
    
    var nameObservation: NSKeyValueObservation?
    var inputTextObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameObservation = observe(\ViewController.taylor.name, options: [.new, .old]) { (vc, change) in
            guard let updatedName = change.newValue else { return }
            self.nameLabel.text = updatedName
            print("Изменили старое значение: \(change.oldValue) на новое значение: \(change.newValue)")
        }
        
        inputTextObservation = observe(\ViewController.inputText, options: .new) { (vc, change) in
            guard let updatedInputText = change.newValue as? String else { return }
            vc.textLabel.text = updatedInputText
        }
    }

    @IBAction func buttonTapped(_ sender: Any) {
        taylor.name = "Peter"
    }
    
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        inputText = textField.text
    }
    
}

