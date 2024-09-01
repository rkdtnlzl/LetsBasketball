//
//  HomeViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/17/24.
//

import UIKit
import RealmSwift

final class HomeViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let homeView = HomeView()
    private let viewModel = HomeViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<Int, RecentTable>!
    private let realm = try! Realm()
    private var recentPosts: [RecentTable] = []
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
        loadRecentPosts()
        applySnapshot()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showTabBar()
    }
    
    override func configureTarget() {
        homeView.recentMoreButton.addTarget(self, action: #selector(moreButtonClicked), for: .touchUpInside)
    }
    
    private func loadRecentPosts() {
        let results = realm.objects(RecentTable.self)
            .sorted(byKeyPath: "viewDate", ascending: false)
        
        recentPosts = Array(results.prefix(5))
    }
    
    func bind() {
        let input = HomeViewModel.Input(
            yanongTapped: homeView.yanongButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.navigateToYanong
            .bind(with: self, onNext: { owner, _ in
                let vc = LBTabManViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, RecentTable>(collectionView: homeView.collectionView) { (collectionView, indexPath, post) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCollectionViewCell.id, for: indexPath) as? RecentCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: post)
            return cell
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, RecentTable>()
        snapshot.appendSections([0])
        snapshot.appendItems(recentPosts)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc func moreButtonClicked() {
        let vc = RecentViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
