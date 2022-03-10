//
//  EventsViewModel.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import Foundation
import Combine
import CoreLocation

class EventsViewModel: ObservableObject, Identifiable {
	@Published var locations: [LocationViewModel] = []
	@Published var events: [EventViewModel] = []
	
	
	init() {
		fetchAvailableLocations()
	}
	
	func getNearbyEvents(at location: Location) {
		let url = formatNearbyEventsUrl(for: location)
		let request = EdmTrainAPIRequest(url: url)
		request.perform { [weak self] (events: Events?, error) in
			guard let self = self else { return }
			guard let events = events else { return }
			if events.success == false {
				fatalError(events.message!)
			}
			let viewModels = events.data.compactMap { (event: Event) -> EventViewModel in
				let vm = EventViewModel(withEvent: event)
				return vm
			}
			self.events = viewModels
		}
	}
	func fetchAvailableLocations() {
		let url = formatLocationsUrl()
		let request = EdmTrainAPIRequest(url: url)
		request.perform { [weak self] (locations: Locations?, error)  in
			guard let self = self else { return }
			guard let locations = locations else { return }
			if locations.success == false {
				fatalError(locations.message!)
			}
			let viewModels = locations.data.compactMap { (location: Location) -> LocationViewModel in
				let vm = LocationViewModel(withLocation: location)
				return vm
			}
			self.locations = viewModels
		}

	}
	
	private func formatNearbyEventsUrl(for location: Location) -> URL {
		let urlString =
		   """
		   https://edmtrain.com/api/events?latitude=\(location.latitude)\
		   &longitude=\(location.longitude)\
		   &state=\(location.state)\
		   &client=\(EDMTRAIN_API_KEY)
		   """
		guard let url = URL(string: urlString) else { fatalError(AppError.URLImproperFormat.rawValue) }
		return url
	}
	
	private func formatLocationsUrl() -> URL {
		let urlString = "https://edmtrain.com/api/locations?client=\(EDMTRAIN_API_KEY)"
		guard let url = URL(string: urlString) else { fatalError(AppError.URLImproperFormat.rawValue) }
		return url
	}
	
	
	
}
