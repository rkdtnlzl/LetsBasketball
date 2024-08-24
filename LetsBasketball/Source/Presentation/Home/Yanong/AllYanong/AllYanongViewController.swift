//
//  AllYanongViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/22/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class AllYanongViewController: BaseViewController {
    
    let tableView = UITableView()
    private let viewModel = AllYanongViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        tableView.register(YanongTableViewCell.self, forCellReuseIdentifier: YanongTableViewCell.id)
        tableView.rowHeight = 120
    }
    
    private func bind() {
        let input = AllYanongViewModel.Input(fetchTrigger: Observable.just(()))
        let output = viewModel.transform(input: input)
        
        output.items
            .bind(to: tableView.rx.items(cellIdentifier: YanongTableViewCell.id, cellType: YanongTableViewCell.self)) { index, model, cell in
                cell.configure(with: model)
            }
            .disposed(by: disposeBag)
        
        output.error
            .subscribe(onNext: { error in
                if error != nil {
                    print("에러 발생")
                }
            })
            .disposed(by: disposeBag)
    }
}
