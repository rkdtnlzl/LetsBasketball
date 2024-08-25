//
//  BaseViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/14/24.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexCode: "F7F7F7")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "BaseColor") ?? ""]
        configureHierarchy()
        configureView()
        configureConstraints()
        configureTarget()
        configureNavigation()
    }
    
    func configureHierarchy() { }
    
    func configureView() { }
    
    func configureConstraints() { }
    
    func configureTarget() { }
    
    func configureNavigation() { }
}
