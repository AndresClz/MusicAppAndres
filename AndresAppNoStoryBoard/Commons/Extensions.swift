//
//  Extensions.swift
//  AndresAppNoStoryBoard
//
//  Created by Andres Calizaya on 03/12/2021.
//

import Foundation
import UIKit

extension NSObject{
    public static func Init<Type>(value : Type, block: (_ object: Type) -> Void) -> Type { block(value)
       return value
    }
}

extension UIView{
    func fitInSuperviewSafeArea() {
       guard let sv = self.superview else { return }
       self.translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: sv.safeAreaLayoutGuide.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: sv.safeAreaLayoutGuide.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: sv.safeAreaLayoutGuide.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: sv.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    func fitInSuperview() {
       guard let sv = self.superview else { return }
       self.translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: sv.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: sv.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: sv.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: sv.rightAnchor).isActive = true
    }
}
extension String {
    func isValidEmail() -> Bool {
        let patron = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"
        let regExp = try! NSRegularExpression(pattern: patron, options: [])
        let coincidencias = regExp.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
        return coincidencias.count > 0 ? true: false
    }
    func isValidPassword() -> Bool {
        let patron = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,})"
        let regExp = try! NSRegularExpression(pattern: patron, options: [])
        let coincidencias = regExp.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
        return coincidencias.count > 0 ? true: false
    }
}
extension UITextField {
    func errorAnimated(){
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = 4
        animation.duration = 0.4/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [10, -10]
        self.layer.add(animation, forKey: "shake")
    }
}

extension UIViewController {
    func simpleAlert(title: String, message: String, action: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { _ in }))
        self.present(alert, animated: true, completion: nil)
    }
}
