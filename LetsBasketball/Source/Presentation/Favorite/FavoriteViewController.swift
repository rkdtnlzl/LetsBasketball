//
//  FavoriteViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/19/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class FavoriteViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let tableView = UITableView()
    let viewModel = FavoriteViewModel()
    
    private let fetchTrigger = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchTrigger.onNext(())
    }
    
    func bind() {
        let input = FavoriteViewModel.Input(
            fetchTrigger: fetchTrigger.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.items
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: YanongListTableViewCell.id, cellType: YanongListTableViewCell.self)) { index, item, cell in
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
        
        output.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                if let error = error {
                    print(error)
                }
            })
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(AllGetPostData.self)
            .bind(with: self, onNext: { owner, item in
                print(item)
            })
            .disposed(by: disposeBag)
    }
    
    override func configureNavigation() {
        navigationItem.title = "관심 게시글"
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
}
