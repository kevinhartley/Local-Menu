//
//  ViewController.swift
//  My First GL App
//
//  Created by Kevin Hartley on 7/29/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {

    @IBOutlet var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 45.52258, longitude: -122.6732)
        point.title = "Voodoo Doughnut"
        point.subtitle = "22 SW 3rd Avenue Portland Oregon, U.S.A."
        mapView.addAnnotation(point)
        
        let newPoint = MGLPointAnnotation()
        newPoint.coordinate = CLLocationCoordinate2D(latitude: 45.52269, longitude: -122.6712)
        newPoint.title = "Hey I'm new here!"
        newPoint.subtitle = "123 I'm so fake"
        mapView.addAnnotation(newPoint)
//        mapView.annotations = UIColor.darkGrayColor()
        
        /////
//        let mapView = MGLMapView(frame: view.bounds)
//        mapView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
//        mapView.styleURL = MGLStyle.darkStyleURLWithVersion(9)
//        mapView.tintColor = .lightGrayColor()
//        mapView.centerCoordinate = CLLocationCoordinate2DMake(0, 66)
//        mapView.zoomLevel = 2
//        mapView.delegate = self
//        view.addSubview(mapView)
//        
//        // Specify coordinates for our annotations.
//        let coordinates = [
//            CLLocationCoordinate2DMake(0, 33),
//            CLLocationCoordinate2DMake(0, 66),
//            CLLocationCoordinate2DMake(0, 99),
//            ]
//        
//        // Fill an array with point annotations and add it to the map.
//        var pointAnnotations = [MGLPointAnnotation]()
//        for coordinate in coordinates {
//            let point = MGLPointAnnotation()
//            point.coordinate = coordinate
//            point.title = "\(coordinate.latitude), \(coordinate.longitude)"
//            pointAnnotations.append(point)
//        }
//        
//        mapView.addAnnotations(pointAnnotations)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always try to show a callout when an annotation is tapped.
        return true
    }
    //------------------------------------------------------------
    
    // MARK: - MGLMapViewDelegate methods
    
    // This delegate method is where you tell the map to load a view for a specific annotation. To load a static MGLAnnotationImage, you would use `-mapView:imageForAnnotation:`.
    func mapView(mapView: MGLMapView, viewForAnnotation annotation: MGLAnnotation) -> MGLAnnotationView? {
        // This example is only concerned with point annotations.
        guard annotation is MGLPointAnnotation else {
            return nil
        }
        
        // Use the point annotation’s longitude value (as a string) as the reuse identifier for its view.
        let reuseIdentifier = "\(annotation.coordinate.longitude)"
        
        // For better performance, always try to reuse existing annotations.
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
        
        
        // If there’s no reusable annotation view available, initialize a new one.
        if annotationView == nil {
            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier)
            annotationView!.frame = CGRectMake(0, 40, 40, 40)
            
            // Set the annotation view’s background color to a value determined by its longitude.
            let hue = CGFloat(annotation.coordinate.longitude) / 100
            annotationView!.backgroundColor = UIColor(hue: 0.02, saturation: 0.93, brightness: 0.53, alpha: 1)
        }

        return annotationView
    }
    
//    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
//        return true
//    }
}

//
// MGLAnnotationView subclass
class CustomAnnotationView: MGLAnnotationView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Force the annotation view to maintain a constant size when the map is tilted.
        scalesWithViewingDistance = false
        
        // Use CALayer’s corner radius to turn this view into a circle.
        layer.cornerRadius = frame.width / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Animate the border width in/out, creating an iris effect.
        let animation = CABasicAnimation(keyPath: "borderWidth")
        animation.duration = 0.1
        layer.borderWidth = selected ? frame.width / 4 : 2
        layer.addAnimation(animation, forKey: "borderWidth")
    }
    
    
    
//    func findRestaurants() {
//        let mapView = MGLMapView()
//        let request = MKLocalSearchRequest()
//        request.naturalLanguageQuery = "Restaurants"
//        request.region = mapView.region
//        
//        let search = MKLocalSearch(request: request)
//        search.startWithCompletionHandler { response, error in
//            guard let response = response else {
//                print("There was an error searching for: \(request.naturalLanguageQuery) error: \(error)")
//                return
//            }
//            
//            for item in response.mapItems {
//                print(item)
//            }
//        }
    
}

