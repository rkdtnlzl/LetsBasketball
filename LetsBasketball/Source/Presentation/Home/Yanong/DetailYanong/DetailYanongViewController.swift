//
//  DetailYanongViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/25/24.
//

import UIKit

final class DetailYanongViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let detailYanongView = DetailYanongView()
    
    override func loadView() {
        self.view = detailYanongView
    }
}
