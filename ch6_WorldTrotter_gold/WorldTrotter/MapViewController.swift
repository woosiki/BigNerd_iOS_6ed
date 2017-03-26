//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by NAVER on 2017. 3. 23..
//  Copyright © 2017년 NAVER. All rights reserved.
//

import UIKit
import MapKit

class MyPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(c: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = c
        self.title = title
        self.subtitle = subtitle
    }
}

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    var annotations = [MyPin]()
    var selectedIndex = 0
    
    override func loadView() {
        mapView = MKMapView()
        
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        let changeLocatationButton = UIButton()
        changeLocatationButton.setTitle("change", for: .normal)
        changeLocatationButton.addTarget(self, action: #selector(changeLocation(sender:)), for: .touchUpInside)
        changeLocatationButton.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        changeLocatationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(changeLocatationButton)
        
        let zoomTop = changeLocatationButton.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 60)
        let zoomTrailing = changeLocatationButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        zoomTop.isActive = true
        zoomTrailing.isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
        
        annotations.append(MyPin(c: CLLocationCoordinate2D(latitude: 10, longitude: 10), title: "aaa1", subtitle: "bbb1"))
        annotations.append(MyPin(c: CLLocationCoordinate2D(latitude: 20, longitude: 20), title: "aaa2", subtitle: "bbb2"))
        annotations.append(MyPin(c: CLLocationCoordinate2D(latitude: 30, longitude: 30), title: "aaa3", subtitle: "bbb3"))
        
        mapView.addAnnotations(annotations)
    }
    
    func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    func changeLocation(sender: UIButton) {
        mapView.selectAnnotation(annotations[selectedIndex], animated: true)
        selectedIndex = selectedIndex + 1 < annotations.count ? selectedIndex + 1 : 0
    }
}
