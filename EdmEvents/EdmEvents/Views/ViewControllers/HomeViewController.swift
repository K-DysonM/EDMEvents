//
//  ViewController.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import UIKit
import Combine


class HomeViewController: UITableViewController {
	var coordinator: HomeBaseCoordinating
	var eventsViewModel: EventsViewModel
	private var cancellables: Set<AnyCancellable> = []
	
	init(coordinator: HomeBaseCoordinating, viewModel: EventsViewModel) {
		self.coordinator = coordinator
		self.eventsViewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		title = "Home"
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		testUI()
		let rightBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(openLocations))
		navigationItem.rightBarButtonItem = rightBarButton
		navigationItem.rightBarButtonItem?.tintColor = UIColor(named: AppUIColor.Button.rawValue)
		// Do any additional setup after loading the view.
		tableView.register(CustomEventHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
		
		eventsViewModel.$eventsDict.sink { [weak self] _ in
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}.store(in: &cancellables)
		eventsViewModel.$eventDates.sink { [weak self] _ in
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}.store(in: &cancellables)
		
		eventsViewModel.$defaultLocationModel.sink { [weak self] locationViewModel in
			guard let self = self else { return }
			if let locationViewModel = locationViewModel {
				self.navigationItem.rightBarButtonItem?.title = locationViewModel.primary
			} else {
				self.navigationItem.rightBarButtonItem?.title = "Set Location"
			}
		}.store(in: &cancellables)
		
		tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.rowHeight = 150
		tableView.separatorColor = UIColor(named: "Background")
		tableView.sectionHeaderHeight = 50
		tableView.sectionHeaderTopPadding = 50
		//tableView.directionalLayoutMargins = NSDirectionalEdgeInsets.zero
		//tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
	}
	
	// MARK: - Simple Tests
	
	func testUI() {
		//sample data
		let _ = VenueViewModel(withVenue: SampleData.venue)
	}
	func testFavorites() {
		let timer = Timer.init(fire: .now + 2, interval: 1.0, repeats: false) { _ in
			print("In here ")
			let eventViewModel = EventViewModel(withEvent: Event.fake())
			eventViewModel.saveFavorite()
		}
		timer.fire()
	}
	
	// MARK: - TableView Datasource & Delegate
	override func numberOfSections(in tableView: UITableView) -> Int {
		eventsViewModel.eventDates.count
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let key = eventsViewModel.eventDates[section]
		return eventsViewModel.eventsDict[key]?.count ?? 0
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! EventTableViewCell
		cell.selectionStyle = .default
		let key = eventsViewModel.eventDates[indexPath.section]
		if let eventViewModel = eventsViewModel.eventsDict[key]?[indexPath.row] {
			cell.configure(with: eventViewModel)
		}
		cell.accessoryType = .disclosureIndicator
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
		DispatchQueue.main.async {
			let key = self.eventsViewModel.eventDates[indexPath.section]
			if let eventViewModel = self.eventsViewModel.eventsDict[key]?[indexPath.row] {
				eventViewModel.delegate = self.eventsViewModel
				self.coordinator.openEvent(eventViewModel)
			}
		}
	}
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! CustomEventHeader
		let key = self.eventsViewModel.eventDates[section]
		if let dateString = eventsViewModel.eventsDict[key]?.first?.dateWithDayOfWeek {
			header.titleLabel.text = dateString
		}
		return header
	}
	
	// MARK: - Coordinator Communication
	
	@objc func openLocations() {
		coordinator.openLocationChoices()
	}

}

