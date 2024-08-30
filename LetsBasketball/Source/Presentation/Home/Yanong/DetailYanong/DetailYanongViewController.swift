//
//  DetailYanongViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/25/24.
//

import UIKit
import RxSwift

final class DetailYanongViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let viewModel = DetailYanongViewModel()
    let detailYanongView = DetailYanongView()
    
    var latitude: String = ""
    var longitude: String = ""
    
    override func loadView() {
        self.view = detailYanongView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func configureNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: nil)
    }
    
    override func configureTarget() {
        detailYanongView.mapButton.addTarget(self, action: #selector(mapButtonClicked), for: .touchUpInside)
    }
    
    private func bind() {
        let input = DetailYanongViewModel.Input(heartButtonClicked: navigationItem.rightBarButtonItem!.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.isLiked
            .observe(on: MainScheduler.instance)
            .bind(with: self, onNext: { owner, isLiked in
                let imageName = isLiked ? "heart.fill" : "heart"
                owner.navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
            })
            .disposed(by: disposeBag)
        
        output.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                if let error = error {
                    print(error)
                }
            })
            .disposed(by: disposeBag)
    }
    
    @objc func mapButtonClicked() {
        let vc = DetailMapViewController()
        vc.latitude = latitude
        vc.longitude = longitude
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
