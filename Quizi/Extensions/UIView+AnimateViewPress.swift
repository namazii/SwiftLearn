//
//  UIView+AnimateViewPress.swift
//  Quizi
//
//  Created by Назар Ткаченко on 20.08.2022.
//

import UIKit

extension UIView {
    func animateViewPress(_ viewToAnimate: UIView){
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 3, options: .allowUserInteraction) {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        } completion: { (_) in
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 3, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
}
