//
//  HomeViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/17/24.
//

import UIKit

final class HomeViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let homeView = HomeView()
    private let viewModel = HomeViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<Int, Int>!
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
        applySnapshot()
        bind()
    }
    
    func bind() {
        let input = HomeViewModel.Input(
            yanongTapped: homeView.yanongButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.navigateToYanong
            .bind(with: self, onNext: { owner, _ in
                let vc = YanongViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: homeView.collectionView) { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCollectionViewCell.id, for: indexPath)
            cell.backgroundColor = .white
            return cell
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems(Array(0..<4))
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
