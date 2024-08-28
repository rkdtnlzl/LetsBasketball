//
//  DetailMapViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/28/24.
//

import UIKit
import MapKit

final class DetailMapViewController: BaseViewController {
    
    var latitude: String = ""
    var longitude: String = ""
    
    private var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        showLocationOnMap()
    }
    
    private func setupMapView() {
        mapView = MKMapView()
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func showLocationOnMap() {
        guard let lat = Double(latitude), let lon = Double(longitude) else {
            print("Invalid coordinates")
            return
        }

        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        mapView.setCenter(coordinate, animated: true)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}
