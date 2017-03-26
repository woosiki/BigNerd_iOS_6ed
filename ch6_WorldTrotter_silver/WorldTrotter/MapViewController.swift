//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by NAVER on 2017. 3. 23..
//  Copyright © 2017년 NAVER. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var mapView: MKMapView!
    
    var zoomLevels: [CLLocationDegrees] = [3, 1, 0.5, 0.3, 0.1]
    var currentZoomLevel = 0
    
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
        
        let zoomButton = UIButton()
        zoomButton.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        zoomButton.setTitle("ZOOM", for: .normal)
        zoomButton.addTarget(self, action: #selector(zoomTapped(_:)), for: .touchUpInside)
        zoomButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(zoomButton)
        
        let zoomTopConstraint = zoomButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -10)
        let zoomTrailingConstraint = zoomButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        zoomTopConstraint.isActive = true
        zoomTrailingConstraint.isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
        mapView.showsUserLocation = true
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
    
    func zoomTapped(_ button: UIButton) {
        var region = MKCoordinateRegion()
        region.center = mapView.centerCoordinate
        region.span = MKCoordinateSpan(latitudeDelta: zoomLevels[currentZoomLevel], longitudeDelta: zoomLevels[currentZoomLevel])
        
        mapView.setRegion(region, animated: true)
        
        currentZoomLevel = currentZoomLevel + 1 < zoomLevels.count ? currentZoomLevel + 1 : currentZoomLevel
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.coordinate
    }
}
