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
    
    var latitude: String = ""
    var longitude: String = ""
    
    override func loadView() {
        self.view = detailYanongView
    }
    
    override func configureTarget() {
        detailYanongView.mapButton.addTarget(self, action: #selector(mapButtonClicked), for: .touchUpInside)
    }
    
    @objc func mapButtonClicked() {
        let vc = DetailMapViewController()
        vc.latitude = latitude
        vc.longitude = longitude
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
