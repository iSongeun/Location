//
//  ViewController.swift
//  Location
//
//  Created by 이송은 on 2023/03/23.
//

import UIKit
import MapKit

class MainViewController: UIViewController {

    var searchController : UISearchController!
    var resultsController : SearchResultTableViewController!
    var filteredLandmarks = [PinLandmark]()
    let locationmanager = LocationManager()
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        setPin()
        setResult()
        setSearch()
        
        
        locationmanager.getMyLocation { location in
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            self.mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
            
        }
         
    }

    private func setPin(){
            PinLandmark.allCases.forEach { landmark in
            let pin = MyPointAnnotation()
            pin.title = landmark.title
            pin.coordinate = landmark.coordinate
            pin.id = landmark.id
            self.mapView.addAnnotation(pin)
        }
        
    }
    
    private func setSearch(){
        searchController = UISearchController(searchResultsController: resultsController)
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.searchController = searchController
        
    }
    
    private func setResult(){
        resultsController = self.storyboard?.instantiateViewController(withIdentifier: "SearchResultTableViewController") as? SearchResultTableViewController
        resultsController.tableView.delegate = self
        resultsController.tableView.dataSource = self
    }
}

extension MainViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let hasView = view.annotation as? MyPointAnnotation else { return}
        let selectedPin = PinLandmark(rawValue: hasView.id)
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        VC.url = selectedPin?.url
        
        self.navigationController?.pushViewController(VC, animated: true)
        self.mapView.deselectAnnotation(view.annotation, animated: true)
    }
}

class MyPointAnnotation : MKPointAnnotation {
    var id = 0
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredLandmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath) as! ResultsCell
        cell.titleLabel.text = filteredLandmarks[indexPath.row].title
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedPin = PinLandmark(rawValue: filteredLandmarks[indexPath.row].id) else {return}
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let regian = MKCoordinateRegion(center: selectedPin.coordinate, span: span)
        self.mapView.setRegion(regian, animated: true)
        searchController.searchBar.text = ""
        searchController.isActive = false
    }
    
    
}

extension MainViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        let pinAllList = PinLandmark.allCases
        
        filteredLandmarks = pinAllList.filter{ landmark in
            landmark.title.lowercased().contains(searchText.lowercased())
        }
        resultsController.tableView.reloadData()
    }
}
