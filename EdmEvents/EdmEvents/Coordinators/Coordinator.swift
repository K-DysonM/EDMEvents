//
//  Coordinator.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/11/22.
//

import Foundation
import UIKit
import MapKit


protocol Coordinator {
	var children: [Coordinator] { get set }
	var nav: UINavigationController { get set }
	//Called when coordinator is taking control over the app
	func start() -> UIViewController
}
protocol HomeBaseCoordinating: Coordinator {
	func openEvent(_ eventViewModel: EventViewModel)
	func openMapForVenue(_ venueViewModel: VenueViewModel)
	func openLocationChoices()
}

// MARK: - Default Implementations
extension HomeBaseCoordinating {
	func openEvent(_ eventViewModel: EventViewModel) {
		// open view controller that shows event information
		let vc = EventViewController()
		vc.coordinator = self
		vc.eventViewModel = eventViewModel
		nav.pushViewController(vc, animated: true)
	}
	func openMapForVenue(_ venueViewModel: VenueViewModel) {
		guard let coordinate = venueViewModel.getCoordinates() else { return }
		let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
		mapItem.name = venueViewModel.name
		mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
		print(#function)
	}
}
