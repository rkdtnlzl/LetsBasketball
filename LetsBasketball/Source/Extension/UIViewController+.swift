//
//  UIViewController+.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/15/24.
//

import UIKit

extension UIViewController {
    func setRootViewController(_ viewController: UIViewController) {
        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
        let window = scene.window {
            window.rootViewController = viewController
            UIView.transition(with: window, duration: 0.2, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        }
    }
}
