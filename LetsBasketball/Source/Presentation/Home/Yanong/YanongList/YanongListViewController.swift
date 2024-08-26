//
//  YanongListViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/24/24.
//

import UIKit
import RxSwift

final class YanongListViewController: BaseViewController {
    
    let tableView = UITableView()
    private let viewModel: YanongListViewModel

    init(region: String) {
        self.viewModel = YanongListViewModel(region: region)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hiddenTabBar()
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
        tableView.register(YanongListTableViewCell.self, forCellReuseIdentifier: YanongListTableViewCell.id)
        tableView.rowHeight = 120
    }
    
    private func bind() {
        let input = YanongListViewModel.Input(fetchTrigger: Observable.just(()))
        let output = viewModel.transform(input: input)
        
        output.items
            .bind(to: tableView.rx.items(cellIdentifier: YanongListTableViewCell.id, cellType: YanongListTableViewCell.self)) { index, model, cell in
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
        
        tableView.rx.modelSelected(AllGetPostData.self)
            .subscribe(with: self, onNext: { owner, data in
                let vc = DetailYanongViewController()
                vc.detailYanongView.titleLabel.text = data.title
                vc.detailYanongView.contentLabel.text = data.content
                owner.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
