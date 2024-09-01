//
//  RecentViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/31/24.
//

import UIKit
import SnapKit
import RealmSwift

final class RecentViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let tableView = UITableView()
    var recentPosts: Results<RecentTable>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        loadRecentPosts()
    }
    
    override func configureNavigation() {
        navigationItem.title = "최근 본 게시글"
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecentTableViewCell.self, forCellReuseIdentifier: RecentTableViewCell.id)
        tableView.rowHeight = 120
        
        view.addSubview(tableView)
    }
    
    func loadRecentPosts() {
        recentPosts = realm.objects(RecentTable.self).sorted(byKeyPath: "viewDate", ascending: false)
        tableView.reloadData()
    }
}

extension RecentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentPosts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let post = recentPosts?[indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: RecentTableViewCell.id, for: indexPath) as? RecentTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let post = recentPosts?[indexPath.row] {
            let detailVC = DetailYanongViewController()
            detailVC.detailYanongView.titleLabel.text = post.title
            detailVC.detailYanongView.contentLabel.text = post.content
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
