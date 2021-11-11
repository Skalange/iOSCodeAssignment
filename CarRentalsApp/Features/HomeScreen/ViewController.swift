//
//  ViewController.swift
//  CarRentalsApp
//
//  Created by Sonali Kalange on 10/11/21.
//

import UIKit
import MapKit

protocol CarReservationDelegate: AnyObject {
    func reserveCar()
}

class ViewController: UIViewController {
    @IBOutlet fileprivate weak var carInfoCollectionView: CarDetailCollectionView!
    @IBOutlet fileprivate weak var carMapView: MKMapView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    var carList: [CarDetailsCellModel]?
    
    var viewModel: MainViewModel?
    var mainViewConfigurator: MainViewConfigurator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewConfigurator = MainViewConfigurator()
        mainViewConfigurator?.bindElementsFor(viewController: self)
        carMapView.delegate = self
        carMapView.isZoomEnabled = true
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupUI() {
        titleLabel.text = "RideCell"
        carList = viewModel?.getCarTypes()
        carInfoCollectionView.cellModel = carList
        carInfoCollectionView.carViewDelegate = self
        carInfoCollectionView.carReservationDelegate = self
        focusOnLocation(model: viewModel?.getCoordinatesOfAllVehicles(cellModels: carList))
        
    }
}

extension ViewController: MKMapViewDelegate {
    func focusOnLocation(model: [AnnotationModel]?) {
        guard let annotationModel = model else {
            return
        }
        
        // Zoom to first vehicle location
        if let firstVehicleCoords = annotationModel.first?.locationCoordinate {
            let regionRadius: CLLocationDistance = 100
            let coordinateRegion = MKCoordinateRegion(center: firstVehicleCoords,
                                                      latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
            carMapView.setRegion(coordinateRegion, animated: true)
        }

        var annotationArray = [MKAnnotation]()
        
        for model in annotationModel {
            let annotation = CustomPointAnnotation()
            if model.locationCoordinate.latitude != 0.0, model.locationCoordinate.longitude != 0.0 {
                annotation.coordinate = model.locationCoordinate
                annotation.vehicleId = model.carId
                annotation.title = model.carModel
                annotationArray.append(annotation)
                carMapView.addAnnotation(annotation)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationIdentifier = "AnnotationIdentifier"

        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView = av
        }

        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "carAnnotation")
            annotationView.frame.size = CGSize(width: 80, height: 80)
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        displayLoader()
        if let annotationView = view.annotation as? CustomPointAnnotation {
            self.getLocationDetails(location: annotationView.coordinate) { addressString in
                self.dismiss(animated: false, completion: nil)
                if let postalAddrString = addressString {
                    annotationView.subtitle = postalAddrString
                }

                let correspondingObject = self.carList?.firstIndex(where: { model in
                    return model.vehicleId == annotationView.vehicleId
                })
                if self.carInfoCollectionView?.dataSource?.collectionView(self.carInfoCollectionView!, cellForItemAt: IndexPath(row: 0, section: 0)) != nil {
                    let rect = self.carInfoCollectionView.layoutAttributesForItem(at: IndexPath(item: correspondingObject ?? 0, section: 0))?.frame
                        self.carInfoCollectionView.scrollRectToVisible(rect!, animated: true)
                    }
            }
        }
    }
    
    func getLocationDetails(location: CLLocationCoordinate2D, completion: @escaping (String?) -> (Void)) {
        let carLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        viewModel?.getAddress(location: carLocation, completion: { addressString in
            if let addrVal = addressString, !addrVal.isEmpty {
                completion(addrVal)
            }
            completion(nil)
        })
    }
    
    func zoomOntoAnnotation(location: CLLocationCoordinate2D?) {
        if let vehicleCoords = location {
            let regionRadius: CLLocationDistance = 100
            let coordinateRegion = MKCoordinateRegion(center: vehicleCoords,
                                                      latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
            carMapView.setRegion(coordinateRegion, animated: true)
        }
    }
    
    private func displayLoader() {
        let alert = UIAlertController(title: nil, message: NSLocalizedString("location_details_loader_message", comment: ""), preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        //loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    
}

extension ViewController: CarViewDelegate {
    func updateMapAnnotation(index: Int) {
        let scrolledCellItem = carList?[index]
        let coordinate = CLLocationCoordinate2D(latitude: scrolledCellItem?.lat ?? 0.0, longitude: scrolledCellItem?.lon ?? 0.0)
        if coordinate.latitude == 0.0, coordinate.longitude == 0.0 {
            let errorPopUp = PopUpView().displayPopUp(title: NSLocalizedString("error_coordinate_popup_title", comment: ""), message: NSLocalizedString("error_coordinate_popup_message", comment: ""), buttonTitle1: NSLocalizedString("ok_title", comment: ""), buttonTitle2: nil)
            self.present(errorPopUp, animated: true, completion: nil)
        }
        zoomOntoAnnotation(location: coordinate)
    }
}

extension ViewController: CarReservationDelegate {
    func reserveCar() {
        let popup = PopUpView().displayPopUp(title: NSLocalizedString("reserve_car_popup_title", comment: ""), message: NSLocalizedString("reserve_car_popup_message", comment: ""), buttonTitle1: NSLocalizedString("ok_title", comment: ""), buttonTitle2: nil)
        self.present(popup, animated: true, completion: nil)
    }
}
