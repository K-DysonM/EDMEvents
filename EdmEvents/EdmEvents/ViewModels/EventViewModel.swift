//
//  EventViewModel.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import Foundation

class EventViewModel {
	let event: Event
	let venueViewModel: VenueViewModel
	var delegate: EventViewModelDelegate?
	
	@Published var name: String = ""
	@Published var lineup: String = ""
	@Published var date: String = ""
	@Published var venueInformation: String = ""
	@Published var isFavorite: Bool = false
	@Published var dateWithDayOfWeek: String = ""
	
	init(withEvent myEvent: Event) {
		self.event = myEvent
		self.venueViewModel = VenueViewModel(withVenue: event.venue)
		configureOutput()
	}
	func saveFavorite() {
		isFavorite.toggle()
		delegate?.onFavorited(self)
	}
	private func configureOutput() {
		self.lineup = formatLineupString(event.artistList)
		self.venueInformation = formatVenueString(event.venue)
		self.date = formatDate(event.date)
		self.dateWithDayOfWeek = formatDateWithDayOfWeek(event.date)
		self.name = event.name ?? event.artistList.first?.name ?? event.venue.name
	}
	private func formatDate(_ dateString: String) -> String {
		// Convert string to Date object then convert Date object to proper format
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		let date = dateFormatter.date(from:dateString)!
		dateFormatter.dateFormat = "MM-dd-yyyy"
		let newString = dateFormatter.string(from: date)
		return newString
	}
	private func formatDateWithDayOfWeek (_ dateString: String) -> String {
		// Convert string to Date object then convert Date object to proper format
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		let date = dateFormatter.date(from:dateString)!
		dateFormatter.dateFormat = "EEE, MMM d"
		let newString = dateFormatter.string(from: date)
		return newString
	}
	
	private func formatVenueString(_ venue: Venue) -> String {
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
