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

final class LBTabManViewController: BaseViewController, PageboyViewControllerDataSource, TMBarDataSource {
    deinit {
        print("deinit \(self)")
    }
    
    var containerView = UIView()
    let tabManVC = TabmanViewController()
    
    let categories = ["전체", "영등포구", "마포구", "용산구", "동작구"]
    
    private lazy var viewControllers: [UIViewController] = {
        return categories.map { RegionViewController(region: $0) }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "야농게시판"
        
        tabManVC.dataSource = self

        let bar = TMBar.ButtonBar()
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
    }
    
    override func configureConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tabManVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
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
