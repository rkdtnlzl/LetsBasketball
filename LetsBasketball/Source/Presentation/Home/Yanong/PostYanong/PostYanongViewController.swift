//
//  PostYanongViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/24/24.
//

import UIKit
import RxSwift
import RxCocoa

final class PostYanongViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let postYanongView = PostYanongView()
    private let viewModel = PostYanongViewModel()
    private let regionRelay = BehaviorRelay<String>(value: "")
    private let latRelay = BehaviorRelay<String>(value: "")
    private let lonRelay = BehaviorRelay<String>(value: "")
    
    override func loadView() {
        self.view = postYanongView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configureTarget()
    }
    
    override func configureTarget() {
        postYanongView.mapButton.addTarget(self, action: #selector(mapButtonClicked), for: .touchUpInside)
    }
    
    func bind() {
        let input = PostYanongViewModel.Input(
            titleText: postYanongView.titleTextField.rx.text.orEmpty.asObservable(),
            contentText: postYanongView.contentView.rx.text.orEmpty.asObservable(),
            product_id: regionRelay.asObservable(),
            latitude: latRelay.asObservable(),
            longitude: lonRelay.asObservable(),
            completeTap: postYanongView.completeButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.completeResult
            .observe(on: MainScheduler.instance)
            .bind(with: self, onNext: { owner, result in
                print("게시글 작성 성공: \(result)")
                owner.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        output.alertMessage
            .observe(on: MainScheduler.instance)
            .bind(with: self, onNext: { owner, message in
                owner.showAlert(title: message)
            })
            .disposed(by: disposeBag)
        
        regionRelay
            .bind(to: postYanongView.regionLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    @objc func mapButtonClicked() {
        let vc = MapViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PostYanongViewController: MapViewControllerDelegate {
    func didSelectcoordinate(_ lat: Double, lon: Double) {
        let latitude = String(format: "%.6f", lat)
        let longitude = String(format: "%.6f", lon)
        latRelay.accept(latitude)
        lonRelay.accept(longitude)
    }
    
    func didSelectRegionName(_ regionName: String) {
        postYanongView.regionLabel.isHidden = false
        regionRelay.accept(regionName)
    }
}
