//
//  HomeCoordinator.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/12/22.
//

import UIKit

class HomeCoordinator: HomeBaseCoordinating {
	
	var parentCoordinator: MainCoordinator
	var children = [Coordinator]()
	
	var nav: UINavigationController = UINavigationController()
	
	init(main: MainCoordinator){
		self.parentCoordinator = main
	}
	
	func start() -> UIViewController {
		let homeVC = HomeViewController(coordinator: self, viewModel: parentCoordinator.eventsViewModel)
		let navVC = UINavigationController(rootViewController: homeVC)
		nav = navVC
		
		if parentCoordinator.eventsViewModel.defaultLocationModel == nil {
			let openVC = OpenViewController(coordinator: self)
			nav.viewControllers.append(openVC)
		}
		return nav
	}
	func openLocationChoices() {
		// open view controller that allows user to pick a city
		let locationViewController = LocationViewController(coordinator: self, viewModel: parentCoordinator.eventsViewModel)
		nav.pushViewController(locationViewController, animated: true)
	}
	func openHomeController() {
		nav.setNavigationBarHidden(false, animated: true)
		nav.popToRootViewController(animated: true)
	}
}
