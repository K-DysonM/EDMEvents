//
//  EventViewController.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/11/22.
//

import UIKit
import Combine

class EventViewController: UIViewController {
	var coordinator: HomeBaseCoordinating?
	var eventViewModel: EventViewModel?
	var subscriptions = Set<AnyCancellable>()
	
	// MARK: - UI Setup
	var stackBottomAnchor: NSLayoutConstraint? = nil
	
	var venueDetailView: VenueDetailView!
	
	lazy var stack: UIStackView = {
		let stack = UIStackView()
		stack.alignment = .leading
		stack.axis = .vertical
		stack.distribution = .equalSpacing
		stack.spacing = 15
		return stack
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Title"
		label.font = UIFont.systemFont(ofSize: 25, weight: .black)
		label.numberOfLines = 0
		label.textColor = UIColor(named: AppUIColor.Accent.rawValue)
		label.textAlignment = .left
		return label
	}()
	
	lazy var subtitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Subtitle"
		label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		label.numberOfLines = 0
		label.textColor = .white
		label.textAlignment = .left
		return label
	}()
	
	lazy var dateLabel: UILabel = {
		let label = UILabel()
		label.text = "Date"
		label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		label.numberOfLines = 0
		label.textColor = .white
		label.textAlignment = .left
		return label
	}()
	
	// MARK: - UI Layout
	
	override func loadView() {
		view = UIView()
		view.backgroundColor = .systemBackground
		venueDetailView = VenueDetailView()
		
		[titleLabel, subtitleLabel, dateLabel, venueDetailView].forEach {
			stack.addArrangedSubview($0)
		}
		stack.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(stack)
		
		stackBottomAnchor = stack.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
		NSLayoutConstraint.activate([
			stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
			stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 8),
			stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
			//venueDetailView!.heightAnchor.constraint(equalToConstant: 150.00)
		])
	}
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		if UIDevice.current.orientation.isLandscape {
			stackBottomAnchor?.isActive = true
		} else {
			stackBottomAnchor?.isActive = false
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		// Navigation bar setup
		let heartButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(heartVenue))
		navigationController?.navigationBar.tintColor = UIColor(named: AppUIColor.Button.rawValue)
		navigationItem.rightBarButtonItem = heartButton
		
		configure()
    }
	
	// MARK: - Configuration
	func configure() {
		guard let eventViewModel = eventViewModel else { return }
		venueDetailView?.configure(with: eventViewModel.venueViewModel)
		subscriptions = [
			eventViewModel.$name.assign(to: \.text!, on: titleLabel),
			eventViewModel.$lineup.assign(to: \.text!, on: subtitleLabel),
			eventViewModel.$dateWithDayOfWeek.assign(to: \.text!, on: dateLabel)
		]
		eventViewModel.$isFavorite.sink { isFavorite in
			if isFavorite {
				self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
			} else {
				self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
			}
		}.store(in: &subscriptions)
		venueDetailView.button.addTarget(self, action: #selector(openMap) , for: .touchUpInside)
	}
	
	@objc func openMap() {
		guard let venueViewModel = eventViewModel?.venueViewModel else { return }
		coordinator?.openMapForVenue(venueViewModel)
	}
	@objc func heartVenue() {
		eventViewModel?.saveFavorite()
	}
}
