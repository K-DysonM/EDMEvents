//
//  EventViewModel.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import Foundation

class EventViewModel {
	private let event: Event
	let venueViewModel: VenueViewModel
	
	@Published var name: String = ""
	@Published var lineup: String = ""
	@Published var date: String = ""
	@Published var venueInformation: String = ""
	
	init(withEvent myEvent: Event) {
		self.event = myEvent
		self.venueViewModel = VenueViewModel(withVenue: event.venue)
		configureOutput()
	}
	private func configureOutput() {
		self.lineup = formatLineupString(event.artistList)
		self.venueInformation = formatVenueString(event.venue)
		self.date = formatDate(event.date)
		self.name = event.name ?? event.artistList.first?.name ?? event.venue.name
	}
	private func formatDate(_ dateString: String) -> String{
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		let date = dateFormatter.date(from:dateString)!
		dateFormatter.dateFormat = "MM-dd-yyyy"
		let newString = dateFormatter.string(from: date)
		return newString
	}
	
	private func formatVenueString(_ venue: Venue) -> String{
		let formatString = "\(venue.name) - \(venue.location)"
		return formatString.trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	private func formatLineupString(_ artistList: [Artist]) -> String {
		guard !artistList.isEmpty else { return "No known lineup" }
		var artistsString = artistList[0].name
		artistList[1...].forEach { artist in
			artistsString += ", \(artist.name)"
		}

		return artistsString
	}
	
	
}
