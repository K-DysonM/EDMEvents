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
	@Published var favorites: [EventViewModel] = []
	@Published var defaultLocationModel: LocationViewModel? = nil
	
	@Published var eventsDict: [String: [EventViewModel]] = [:] {
		didSet{
			eventDates = eventsDict.keys.sorted()
		}
	}
	@Published var eventDates: [String]  = []
	
	private var defaultLocation: Location? = nil {
		didSet {
			guard let defaultLocation = defaultLocation else { return }
			defaultLocationModel = LocationViewModel(withLocation: defaultLocation)
			getNearbyEvents(at: defaultLocation)
		}
	}
	
	// Converts events into a dictionary where the key is the date
	// and the value is the array of events at that date
	private func organizeEvents(_ events: [EventViewModel]) {
		events.forEach { vm in
			if eventsDict[vm.event.date] == nil {
				eventsDict[vm.event.date] = [vm]
			} else {
				eventsDict[vm.event.date]?.append(vm)
			}
		}
	}
	
	init() {
		fetchSavedInformation()
		fetchAvailableLocations()
	}
	
	// MARK: - Loading User Saved information
	func fetchSavedInformation() {
		fetchSavedLocation()
		fetchFavorites()
	}
	func saveUserInformation() {
		saveDefaultLocation()
		saveFavorites()
	}
	
	func setDefaultLocation(_ location: Location) {
		eventDates.removeAll(keepingCapacity: true)
		eventsDict.removeAll(keepingCapacity: true)
		defaultLocation = location
	}
	
	private func saveDefaultLocation () {
		guard let defaultLocation = defaultLocation else { return }

		let encoder = JSONEncoder()
		if let data = try? encoder.encode(defaultLocation) {
			let defaults = UserDefaults.standard
			defaults.set(data, forKey: K.UserDefaults_Location)
		}
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
	
	// MARK: - EmdTrain Api Query functions
	
	func getEventById(favorite: Favorite) {
		let url = EdmTrainUrl().formatEventsQuery(artstId: favorite.artistId, venueId: favorite.venueId, startDate: favorite.startDate)
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
		let url = EdmTrainUrl().formatNearbyEventsUrl(for: location)
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
			self.organizeEvents(viewModels)
		}
	}
	func fetchAvailableLocations() {
		let url = EdmTrainUrl().formatLocationsUrl()
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
	
}
extension EventsViewModel: EventViewModelDelegate {
	func onFavorited(_ eventViewModel: EventViewModel) {
		print(#function)
		let index = favorites.firstIndex { vm in
			vm.event.id == eventViewModel.event.id
		}
		if let index = index {
			favorites.remove(at: index)
		} else {
			favorites.append(eventViewModel)
		}
	}
}
