//
//  Events.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import Foundation

struct Events: Codable {
	var data: [Event]
	var success: Bool
	var message: String?
}
