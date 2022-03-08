//
//  LocationViewModel.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import Foundation
import CoreLocation

struct LocationViewModel {
	let location: Location
	
	private var city: String?
	private var state: String
	
	init(withLocation location: Location) {
		self.location = location
		self.city = location.city
		self.state = location.state
	}
	func getPrimary() -> String {
		return city ?? state
	}	
	func getSecondary() -> String {
		return state
	}
	
	func getCountryCode(completionHandler: @escaping (String) -> Void){
		var secondary = state
		let clLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
		print(CLGeocoder().isGeocoding)
		CLGeocoder().reverseGeocodeLocation(clLocation) { placemarks, error in
			print(error?.localizedDescription ?? "")
			if let countryCode = placemarks?.first?.isoCountryCode {
				secondary += ", \(countryCode)"
			}
			completionHandler(secondary)
		}
	}
}
