//
//  UIViewController+Alert.swift
//  Marley Spoon
//
//  Created by Majid Khoshpour on 9/6/21.
//

import UIKit

typealias Completion = (() -> Void)?

extension UIViewController {
    func showAlertWith(_ message: String, title: String, completion: Completion) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        self.present(ac, animated: true, completion: nil)
    }
}
