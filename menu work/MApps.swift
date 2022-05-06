//
//  Maps.swift
//  menu work
//
//  Created by cmStudent on 2021/10/25.
//
import SwiftUI
// 以下の行を追加
import CoreLocation
import MapKit
struct MappsView : UIViewRepresentable {
    typealias UIViewType = MKMapView

    @Binding var manager : CLLocationManager
    @Binding var alert : Bool

    let map = MKMapView()

    func makeCoordinator() -> MappsView.Coordinator {

        return MappsView.Coordinator(parent1: self)
    }

    func  makeUIView(context: UIViewRepresentableContext<MappsView>) -> MKMapView {
        // Tokyo 35.6804° N, 139.7690° E
        let center = CLLocationCoordinate2D(latitude: 35.6804, longitude: 139.7690)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
        map.region = region

        manager.delegate = context.coordinator
        manager.startUpdatingLocation()
        map.showsUserLocation = true
        manager.requestWhenInUseAuthorization()
        return map
    }

    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MappsView>) {

    }

    class Coordinator: NSObject, CLLocationManagerDelegate {

        var parent : MappsView

        init(parent1 : MappsView) {

            parent = parent1
        }

        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

            if status == .denied{

                parent.alert.toggle()
                print("denied")
            }
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

            let location = locations.last

            let point = MKPointAnnotation()

            let georeader = CLGeocoder()
            georeader.reverseGeocodeLocation(location!) { (places, err) in

                if err != nil {

                    print((err?.localizedDescription)!)
                    return
                }

                let place = places?.first?.locality
                point.title = place
                point.subtitle = "Current Place"
                point.coordinate = location!.coordinate
                self.parent.map.removeAnnotations(self.parent.map.annotations)
                self.parent.map.addAnnotation(point)

                let region = MKCoordinateRegion(center: location!.coordinate, latitudinalMeters: 10000, longitudinalMeters: 100000)
                print(region)
                self.parent.map.region = region

            }
        }
    }
}
