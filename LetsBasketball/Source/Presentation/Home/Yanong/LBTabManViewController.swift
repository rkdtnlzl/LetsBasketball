//
//  LBTabManViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/19/24.
//

import UIKit

import SnapKit
import Tabman
import Pageboy

final class LBTabManViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    var containerView = UIView()
    let tabManVC = TabmanViewController()
    
    let categories = ["전체", "영등포구", "마포구", "용산구", "동작구"]
    
    private lazy var viewControllers: [UIViewController] = {
        return categories.map { YanongListViewController(region: $0) }
    }()
    
    let postButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "야농게시판"
        
        tabManVC.dataSource = self

        let barView = UIView()
        barView.backgroundColor = UIColor(hexCode: "F7F7F7")
        
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .custom(view: barView)
        bar.layout.transitionStyle = .snap
        bar.buttons.customize { button in
            button.tintColor = .gray
            button.selectedTintColor = UIColor(named: "BaseColor")
        }
        bar.indicator.tintColor = UIColor(named: "BaseColor")
        bar.layout.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 10)
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        tabManVC.addBar(bar, dataSource: self, at: .top)
    }
    
    override func configureHierarchy() {
        view.addSubview(containerView)
        containerView.addSubview(tabManVC.view)
        addChild(tabManVC)
        tabManVC.didMove(toParent: self)
        containerView.addSubview(postButton)
    }
    
    override func configureView() {
        postButton.setImage(UIImage(systemName: "plus"), for: .normal)
        postButton.tintColor = UIColor(named: "BaseColor")
        postButton.layer.cornerRadius = 25
        postButton.layer.borderWidth = 1.7
        postButton.layer.borderColor = UIColor(named: "BaseColor")?.cgColor
    }
    
    override func configureTarget() {
        postButton.addTarget(self, action: #selector(postButtonClicked), for: .touchUpInside)
    }
    
    override func configureConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tabManVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        postButton.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().inset(30)
            make.size.equalTo(50)
        }
    }
    
    @objc func postButtonClicked() {
        let vc = PostYanongViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LBTabManViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = categories[index]
        return TMBarItem(title: title)
    }
}
