//
//  LocationViewController.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/12/22.
//

import UIKit
import Combine

class LocationViewController: UIViewController {

	var coordinator: HomeCoordinator
	var eventsViewModel: EventsViewModel
	var cancellables = Set<AnyCancellable>()
	
	var locations: [LocationViewModel] = []
	
	init(coordinator: HomeCoordinator, viewModel: EventsViewModel) {
		self.coordinator = coordinator
		self.eventsViewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - UI Setup
	var tableView: UITableView!
	var searchBar: UISearchBar!
	
	override func loadView() {
		view = UIView()
		view.backgroundColor = .systemBackground
		
		tableView = UITableView()
		searchBar = UISearchBar()
		searchBar.showsCancelButton = true
		searchBar.placeholder = "Find a party in..."
		view.addSubview(searchBar)
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		searchBar.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		tableView.dataSource = self
		tableView.delegate = self
		eventsViewModel.$locations.sink(receiveValue: { [weak self] locations in
			self?.locations = locations
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}).store(in: &cancellables)
		tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: K.Location_Cell_Identifier)
		tableView.rowHeight = 50
		
		searchBar.delegate = self
		searchBar.tintColor = UIColor(named: AppUIColor.Button.rawValue)
    }
	func queryLocations(with text: String) {
		let newLocations = eventsViewModel.locations.filter{ locationViewModel in
			locationViewModel.primary.lowercased().hasPrefix(text.lowercased()) ||
			locationViewModel.secondary.lowercased().hasPrefix(text.lowercased())
		}
		locations = newLocations
		tableView.reloadData()
	}
	func setLocation(with viewModel: LocationViewModel) {
		eventsViewModel.setDefaultLocation(viewModel.location)
		coordinator.openHomeController()
		dismiss(animated: true)
	}

}
// MARK: - UITableViewDataSource

extension LocationViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		locations.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: K.Location_Cell_Identifier, for: indexPath) as! LocationTableViewCell
		let locationViewModel = locations[indexPath.row]
		cell.configure(with: locationViewModel)
		
		return cell
	}
}

extension LocationViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
		setLocation(with: locations[indexPath.row])
	}
}

extension LocationViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText.isEmpty {
			locations = eventsViewModel.locations
			tableView.reloadData()
		} else {
			queryLocations(with: searchText)
		}
	}
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}
}
