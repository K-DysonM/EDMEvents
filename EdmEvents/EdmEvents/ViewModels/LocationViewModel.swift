//
//  LocationViewModel.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import Foundation
import CoreLocation

class LocationViewModel {
	private var location: Location
	
	@Published private(set) var primary: String = ""
	@Published private(set) var secondary: String = ""
	
	init(withLocation location: Location) {
		self.location = location
		configureOutput()
	}
	
	func changeLocation(to location: Location) {
		self.location = location
		self.primary = location.city ?? "Empty"
		self.secondary = location.state
	}
	
	private func configureOutput() {
		primary = location.city ?? location.state
		if location.city != nil {
			secondary = location.state
		} else {
			secondary = location.stateCode
		}
	}
}

