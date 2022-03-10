//
//  VenueViewModel.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import Foundation

class VenueViewModel {
	private let venue: Venue
	
	@Published var name: String = ""
	@Published var primaryAddress: String = ""
	@Published var secondaryAddress: String = ""
	@Published var isAddress: Bool = false
	@Published var simpleAddress: String = ""
	
	init(withVenue venue: Venue) {
		self.venue = venue
		configureOutput()
	}
	private func configureOutput() {
		self.name = venue.name
		self.primaryAddress = formatPrimaryAddress(venue: venue)
		self.secondaryAddress = formatSecondaryAddress(venue: venue)
		self.isAddress = venue.address != nil
		self.simpleAddress = "\(venue.name) - \(venue.location)"
	}
	
	private func formatPrimaryAddress(venue: Venue) -> String{
		guard let address = venue.address else { return venue.location}
		let separated = address.split(separator: ",", maxSplits: 1)
		let addressString = separated.first!.trimmingCharacters(in: .whitespaces)
		return addressString
	}
	
	private func formatSecondaryAddress(venue: Venue) -> String{
		guard let address = venue.address else { return venue.location}
		let separated = address.split(separator: ",", maxSplits: 1)
		
		guard separated.count >= 2 else { return venue.location }
		let addressString = separated[1].trimmingCharacters(in: .whitespaces)
		return addressString
	}
}
