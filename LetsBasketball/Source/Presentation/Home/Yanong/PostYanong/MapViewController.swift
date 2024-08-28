//
//  MapViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/27/24.
//

import UIKit
import SnapKit
import CoreLocation
import MapKit
import Alamofire

protocol MapViewControllerDelegate: AnyObject {
    func didSelectRegionName(_ regionName: String)
    func didSelectcoordinate(_ lat: Double, lon: Double)
}

final class MapViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var currentAnnotation: MKPointAnnotation?
    var selectedCoordinate: CLLocationCoordinate2D?
    let registerButton = UIButton()
    weak var delegate: MapViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MKMapView(frame: view.bounds)
        mapView.delegate = self
        
        view.addSubview(mapView)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
        
        view.addSubview(registerButton)
        
        registerButton.setTitle("등록하기", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = UIColor(named: "BaseColor")
        registerButton.layer.cornerRadius = 10
        
        registerButton.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(50)
        }
        
        registerButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
    }
    
    @objc func registerButtonClicked() {
        if let coordinate = selectedCoordinate {
            convertCoordinateToAddress(latitude: coordinate.latitude, longitude: coordinate.longitude)
        } else {
            showAlert(title: "좌표를 선택해주세요")
        }
    }
    
    func convertCoordinateToAddress(latitude: Double, longitude: Double) {
        let url = "https://dapi.kakao.com/v2/local/geo/coord2address.json"
        let parameters: [String: Any] = [
            "x": longitude,
            "y": latitude
        ]
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK \(APIKey.kakaoAPIKey)"
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: KakaoAddressResponse.self) { response in
                switch response.result {
                case .success(let data):
                    if let regionName = data.documents.first?.address?.region_2depth_name {
                        print("Region 2 Depth Name: \(regionName)")
                        self.delegate?.didSelectRegionName(regionName)
                        self.delegate?.didSelectcoordinate(latitude, lon: longitude)
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        print("No address found")
                    }
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }
}

extension MapViewController: MKMapViewDelegate {
    func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc func handleMapTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let locationInView = gestureRecognizer.location(in: mapView)
        let tappedCoordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
        
        if let annotation = currentAnnotation {
            mapView.removeAnnotation(annotation)
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = tappedCoordinate
        mapView.addAnnotation(annotation)
        
        currentAnnotation = annotation
        
        selectedCoordinate = tappedCoordinate
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.last {
            centerMapOnLocation(location: userLocation)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
