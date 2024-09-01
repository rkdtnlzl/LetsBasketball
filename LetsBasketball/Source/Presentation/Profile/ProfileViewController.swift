//
//  ProfileViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/19/24.
//

import UIKit

final class ProfileViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    
    private let tableView = UITableView()
    private let list = ["자주 묻는 질문",
                        "1:1 문의",
                        "로그아웃",
                        "탈퇴하기"
    ]
    
    override func configureNavigation() {
        navigationItem.title = "프로필"
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 2:
            print("로그아웃 선택됨")
        case 3:
            print("탈퇴하기 선택됨")
        default:
            break
        }
    }
}
