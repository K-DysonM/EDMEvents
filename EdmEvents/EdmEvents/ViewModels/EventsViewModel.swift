//
//  EventsViewModel.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import Foundation
import Combine
import CoreLocation

///100% need to refractor this view model because its getting massive and also doing way more than a single task

class EventsViewModel: ObservableObject, Identifiable {
	@Published var locations: [LocationViewModel] = []
	@Published var events: [EventViewModel] = []
	@Published var favorites: [EventViewModel] = []
	@Published var defaultLocationModel: LocationViewModel? = nil
	
	@Published var eventsDict: [String: [EventViewModel]] = [:] {
		didSet{
			eventDates = eventsDict.keys.sorted()
		}
	}
	@Published var eventDates: [String]  = []
	
	private func organizeEvents() {
		events.forEach { vm in
			if eventsDict[vm.event.date] == nil {
				eventsDict[vm.event.date] = [vm]
			} else {
				eventsDict[vm.event.date]?.append(vm)
			}
		}
	}
	
	private var defaultLocation: Location? = nil {
		didSet {
			guard let defaultLocation = defaultLocation else { return }
			defaultLocationModel = LocationViewModel(withLocation: defaultLocation)
			getNearbyEvents(at: defaultLocation)
		}
	}
	
	init() {
		fetchSavedInformation()
		fetchAvailableLocations()
		//fetchFavorites()
	}
	
	func fetchSavedInformation() {
		fetchSavedLocation()
		fetchFavorites()
	}
	
	private func fetchSavedLocation() {
		let defaults = UserDefaults.standard
		if let data = defaults.data(forKey: K.UserDefaults_Location) {
			let decoder = JSONDecoder()
			if let location = try? decoder.decode(Location.self, from: data) {
				defaultLocation = location
			}
		}
	}
	func setDefaultLocation(_ location: Location) {
		eventDates.removeAll(keepingCapacity: true)
		eventsDict.removeAll(keepingCapacity: true)
		defaultLocation = location
	}
	func saveUserInformation() {
		saveDefaultLocation()
		saveFavorites()
	}
	
	private func saveDefaultLocation () {
		guard let defaultLocation = defaultLocation else { return }

		let encoder = JSONEncoder()
		if let data = try? encoder.encode(defaultLocation) {
			let defaults = UserDefaults.standard
			defaults.set(data, forKey: K.UserDefaults_Location)
		}
	}
	
	private func saveFavorites () {
		let encoder = JSONEncoder()
		let events = favorites.compactMap { eventViewModel in
			eventViewModel.event
		}
		if let data = try? encoder.encode(events) {
			let defaults = UserDefaults.standard
			defaults.set(data, forKey: K.UserDefaults_Favorites)
		}
	}
	
	private func fetchFavorites() {
		let defaults = UserDefaults.standard
		if let data = defaults.data(forKey: K.UserDefaults_Favorites) {
			let decoder = JSONDecoder()
			if let events = try? decoder.decode([Event].self, from: data) {
				let eventViewModels = events.compactMap { event -> EventViewModel in
					let viewModel = EventViewModel(withEvent: event)
					viewModel.isFavorite = true
					return viewModel
				}
				
				favorites = eventViewModels
			}
		}
	}
	func getEventById(favorite: Favorite) {
		let url = formatEventsQuery(artstId: favorite.artistId, venueId: favorite.venueId, startDate: favorite.startDate)
		let request = EdmTrainAPIRequest(url: url)
		request.perform { [weak self] (events: Events?, error) in
			guard let self = self else { return }
			if events?.success == false {
				fatalError(events?.message ?? "Api failed")
			}
			guard let event = events?.data.first else { return }
			let vm = EventViewModel(withEvent: event)
			self.favorites.append(vm)
		}
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
			self.organizeEvents()
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
		let trimmedState = location.state.replacingOccurrences(of: " ", with: "")
		let urlString =
			"""
			https://edmtrain.com/api/events?latitude=\(location.latitude)\
			&longitude=\(location.longitude)\
			&state=\(trimmedState)\
			&client=\(EDMTRAIN_API_KEY)
			"""
		guard let url = URL(string: urlString) else { fatalError(AppError.URLImproperFormat.rawValue) }
		return url
	}
	
	private func formatEventsQuery(artstId: Int, venueId: Int, startDate: String ) -> URL {
		let urlString =
		 """
		 https://edmtrain.com/api/events?artistIds=\(artstId)\
		 &venueIds=\(venueId)\
		 &startDate=\(startDate)\
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
extension EventsViewModel: EventViewModelDelegate {
	func onFavorited(_ eventViewModel: EventViewModel) {
		print(#function)
		let index = favorites.firstIndex { vm in
			vm.event.id == eventViewModel.event.id
		}
		if let index = index {
			//eventViewModel.isFavorite = false
			favorites.remove(at: index)
		} else {
			//eventViewModel.isFavorite = true
			favorites.append(eventViewModel)
		}
	}
}
