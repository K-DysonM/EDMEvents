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
		
		// Do any additional setup after loading the view.
		eventsViewModel.fetchAvailableLocations()
		eventsViewModel.$locations.sink { [weak self] locations in
			guard let self = self else { return }
			guard let first = locations.first else { return }
			self.eventsViewModel.getNearbyEvents(at: first.location)
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}.store(in: &cancellables)
		
		eventsViewModel.$events.sink { [weak self] events in
			//print(events.count)
		}.store(in: &cancellables)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		eventsViewModel.locations.count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = eventsViewModel.locations[indexPath.row].getPrimary()
		return cell
	}


}

