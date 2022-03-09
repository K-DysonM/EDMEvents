//
//  EventViewModel.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import Foundation

struct EventViewModel {
	private let event: Event
	let venueViewModel: VenueViewModel
	var name: String
	
	var lineup: String {
		get {
			return formatLineupString(event.artistList)
		}
	}
	var date: Date {
		get {
			return formatDate(event.date)
		}
	}
	var venueInformation: String {
		get {
			return formatVenueString(event.venue)
		}
	}
	
	init(withEvent myEvent: Event) {
		self.event = myEvent
		self.name = myEvent.name ?? myEvent.artistList.first?.name ?? myEvent.venue.name
		self.venueViewModel = VenueViewModel(withVenue: myEvent.venue)
	}
	
	private func formatDate(_ dateString: String) -> Date{
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		let date = dateFormatter.date(from:dateString)!
		return date
	}
	
	private func formatVenueString(_ venue: Venue) -> String{
		return "\(venue.name) - \(venue.location)"
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
