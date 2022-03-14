//
//  FavoriteViewController.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/12/22.
//
import UIKit
import Combine


class FavoriteViewController: UITableViewController {
	var coordinator: HomeBaseCoordinating
	var eventsViewModel: EventsViewModel
	private var cancellables: Set<AnyCancellable> = []
	
	init(coordinator: HomeBaseCoordinating, viewModel: EventsViewModel) {
		self.coordinator = coordinator
		self.eventsViewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		title = "Favorites"
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		eventsViewModel.$favorites.sink { [weak self] events in
			guard let self = self else { return }
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}.store(in: &cancellables)
		
		tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.rowHeight = 150
		tableView.separatorColor = UIColor(named: "Background")
		
		tableView.directionalLayoutMargins = NSDirectionalEdgeInsets.zero
		tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
	}
	
	// MARK: - TableView Datasource & Delegate
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print(#function)
		if eventsViewModel.favorites.isEmpty {
			let emptyView = TableEmptyView(frame: tableView.safeAreaLayoutGuide.layoutFrame)
			emptyView.configure(title: "Favorites", message: "You don't have any favorites yet. All your favorites will show up here")
			tableView.backgroundView = emptyView
			tableView.separatorStyle = .none
		} else {
			tableView.backgroundView = nil
			tableView.separatorStyle = .singleLine
		}
		return eventsViewModel.favorites.count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! EventTableViewCell
		cell.selectionStyle = .default
		let eventViewModel = eventsViewModel.favorites[indexPath.row]
		cell.configure(with: eventViewModel)
		cell.accessoryType = .disclosureIndicator
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
		DispatchQueue.main.async {
			let eventViewModel = self.eventsViewModel.favorites[indexPath.row]
			eventViewModel.delegate = self.eventsViewModel
			self.coordinator.openEvent(eventViewModel)
		}
	}
}

