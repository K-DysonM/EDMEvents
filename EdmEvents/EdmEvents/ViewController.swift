//
//  ViewController.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import UIKit
import Combine

class ViewController: UITableViewController {
	private var cancellables: Set<AnyCancellable> = []
	let eventsViewModel = EventsViewModel()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//view.backgroundColor = UIColor(named: "Background")
		testUI()
		
		// Do any additional setup after loading the view.
		eventsViewModel.fetchAvailableLocations()
		eventsViewModel.$locations.sink { [weak self] locations in
			guard let self = self else { return }
			guard let first = locations.first else { return }
			self.eventsViewModel.getNearbyEvents(at: first.location)
			DispatchQueue.main.async {
				
			}
		}.store(in: &cancellables)
		
		eventsViewModel.$events.sink { [weak self] events in
			//print(events.count)
		}.store(in: &cancellables)
		
		tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.rowHeight = 150
		tableView.separatorColor = UIColor(named: "Background")
		
		tableView.directionalLayoutMargins = NSDirectionalEdgeInsets.zero
		tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
		
		
	}
	
	func testUI() {
		//sample data
		let _ = VenueViewModel(withVenue: SampleData.venue)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		3
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! EventTableViewCell
		
		let eventViewModel = EventViewModel(withEvent: SampleData.event)
		cell.configure(with: eventViewModel)
		cell.accessoryType = .disclosureIndicator
		cell.layoutMargins = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 0)
		
		return cell
	}
	
	


}

