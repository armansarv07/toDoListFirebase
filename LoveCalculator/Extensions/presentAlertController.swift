//
//  presentAlertController.swift
//  LoveCalculator
//
//  Created by Arman on 27.10.2021.
//

import Foundation
import UIKit

extension ViewController {
    func presentInsertNamesAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler handler: @escaping (String, String) -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            tf.placeholder = "First person's name"
        }
        ac.addTextField { tf in
            tf.placeholder = "Second person's name"
        }
        let calculate = UIAlertAction(title: "Calculate", style: .default) { action in
            let firstTextField = ac.textFields![0] as UITextField
            let secondTextField = ac.textFields![1] as UITextField
            handler(firstTextField.text!, secondTextField.text!)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(calculate)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    func perfectCase(sname: String, fname: String) -> Bool {
        if (sname == "Arman" && fname == "Jamila") || (fname == "Arman" && sname == "Jamila") {
            return true
        }
        
        if (sname == "Arman" && fname == "Zhamila") || (fname == "Arman" && sname == "Zhamila") {
            return true
        }
        
        return false
    }
}
