//
//  RegionViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/24/24.
//

import UIKit
import RxSwift

final class RegionViewController: BaseViewController {
    
    let tableView = UITableView()
    private let viewModel: RegionViewModel

    init(region: String) {
        self.viewModel = RegionViewModel(region: region)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let input = RegionViewModel.Input(fetchTrigger: Observable.just(()))
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
