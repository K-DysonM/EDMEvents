//
//  FavoriteCoordinator.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/12/22.
//

import Foundation
import UIKit

class FavoriteCoordinator: HomeBaseCoordinating {

	var parentCoordinator: MainCoordinator
	var children = [Coordinator]()
	
	var nav: UINavigationController = UINavigationController()
	
	init(main: MainCoordinator){
		self.parentCoordinator = main
	}
	
	func start() -> UIViewController {
		let vc = FavoriteViewController(coordinator: self, viewModel: parentCoordinator.eventsViewModel)
		let navVC = UINavigationController(rootViewController: vc)
		nav = navVC
		return navVC
	}
	func openLocationChoices() {
		//parentCoordinator.openLocationChoices()
	}
}
