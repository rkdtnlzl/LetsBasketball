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
            titleText: postYanongView.titleTextField.rx.text.orEmpty,
            contentText: postYanongView.contentView.rx.text.orEmpty,
            product_id: Observable.just("영등포구"),
            completeTap: postYanongView.completeButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.completeResult
            .observe(on: MainScheduler.instance)
            .bind(with: self, onNext: { owner, result in
                print("게시글 작성 성공: \(result)")
                owner.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    @objc func mapButtonClicked() {
        let vc = MapViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
