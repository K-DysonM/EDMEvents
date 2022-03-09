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
	var primaryAddress: String {
		get {
			return formatPrimaryAddress(venue: venue)
		}
	}
	var subAddress: String {
		get {
			return formatSecondaryAddress(venue: venue)
		}
	}
	
	var isAddress: Bool {
		get {
			return venue.address != nil
		}
	}
	var simpleAddress: String {
		get {
			return "\(venue.name) - \(venue.location)"
		}
	}
	
	init(withVenue venue: Venue) {
		self.venue = venue
	}
	
	func formatPrimaryAddress(venue: Venue) -> String{
		guard let address = venue.address else { return venue.location}
		let separated = address.split(separator: ",", maxSplits: 1)
		let addressString = separated.first!.trimmingCharacters(in: .whitespaces)
		return addressString
	}
	
	func formatSecondaryAddress(venue: Venue) -> String{
		guard let address = venue.address else { return venue.location}
		let separated = address.split(separator: ",", maxSplits: 1)
		
		guard separated.count >= 2 else { return venue.location }
		let addressString = separated[1].trimmingCharacters(in: .whitespaces)
		return addressString
	}
}
