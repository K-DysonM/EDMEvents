//
//  VenueViewModel.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import Foundation

struct VenueViewModel {
	private let venue: Venue
	
	var name: String {
		get {
			return venue.name
		}
	}
	var address: String {
		get {
			return formatPrimaryAddress(venue: venue)
		}
	}
	
	init(withVenue venue: Venue) {
		self.venue = venue
	}
	
	func formatPrimaryAddress(venue: Venue) -> String{
		guard let address = venue.address else { return venue.location}
		let separated = address.split(separator: ",", maxSplits: 1)
		guard separated.count < 2 else { return String(separated.first!) }
		let addressString =
		"""
		\(separated.first!)
		\(separated[1])
		"""
		return addressString
	}
}
