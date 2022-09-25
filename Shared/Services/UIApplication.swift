//
//  UIApplication.swift
//  qr_tea_example
//
//  Created by ITSTEP on 25.09.2022.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
