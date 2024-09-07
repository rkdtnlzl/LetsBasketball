//
//  DetailYanongViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/25/24.
//

import UIKit
import RxSwift
import RealmSwift
import iamport_ios
import WebKit

final class DetailYanongViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let viewModel = DetailYanongViewModel()
    let detailYanongView = DetailYanongView()
    
    var latitude: String = ""
    var longitude: String = ""
    
    lazy var wkWebView: WKWebView = {
        var view = WKWebView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    override func loadView() {
        self.view = detailYanongView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        saveRecentPost()
    }
    
    override func configureNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: nil)
    }
    
    override func configureTarget() {
        detailYanongView.mapButton.addTarget(self, action: #selector(mapButtonClicked), for: .touchUpInside)
        detailYanongView.payButton.addTarget(self, action: #selector(payButtonClicked), for: .touchUpInside)
    }
    
    @objc func payButtonClicked() {
        let payment = IamportPayment(
            pg: PG.html5_inicis.makePgRawName(pgId: "INIpayTest"),
            merchant_uid: "ios_\(APIKey.key)_\(Int(Date().timeIntervalSince1970))",
            amount: "100").then {
                $0.pay_method = PayMethod.card.rawValue
                $0.name = "농구 매칭 결제"
                $0.buyer_name = "강석호"
                $0.app_scheme = "sesac"
            }
        
        createAndLoadWebView()
        
        Iamport.shared.paymentWebView(
            webViewMode: wkWebView,
            userCode: APIKey.iamportUserCode,
            payment: payment) { [weak self] response in
                print(String(describing: response))
                
                let uid = response?.imp_uid ?? ""
                let post_id = self?.viewModel.post_id ?? ""
                
                NetworkManager.shared.payValidation(imp_uid: uid, post_id: post_id)
                    .subscribe(onNext: { valid in
                        self?.showAlert(title: "결제 성공")
                    }, onError: { error in
                        self?.showAlert(title: "결제 실패")
                    })
                    .disposed(by: self!.disposeBag)
            }
    }
    
    private func createAndLoadWebView() {
        view.addSubview(wkWebView)
        wkWebView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bind() {
        let input = DetailYanongViewModel.Input(heartButtonClicked: navigationItem.rightBarButtonItem!.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.isLiked
            .observe(on: MainScheduler.instance)
            .bind(with: self, onNext: { owner, isLiked in
                let imageName = isLiked ? "heart.fill" : "heart"
                owner.navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
            })
            .disposed(by: disposeBag)
        
        output.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                if let error = error {
                    print(error)
                }
            })
            .disposed(by: disposeBag)
    }
    
    @objc func mapButtonClicked() {
        let vc = DetailMapViewController()
        vc.latitude = latitude
        vc.longitude = longitude
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func saveRecentPost() {
        guard let postTitle = detailYanongView.titleLabel.text, let postContent = detailYanongView.contentLabel.text else {
            return
        }
        
        let recentPost = RecentTable(title: postTitle, content: postContent, viewDate: Date())
        
        let realm = try! Realm()
        
        print(postTitle, postContent)
        
        if let existingPost = realm.objects(RecentTable.self).filter("title = %@ AND content = %@", postTitle, postContent).first {
            try! realm.write {
                existingPost.viewDate = Date()
            }
        } else {
            try! realm.write {
                realm.add(recentPost)
            }
        }
    }
}
