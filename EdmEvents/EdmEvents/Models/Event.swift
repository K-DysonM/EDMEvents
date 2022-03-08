//
//  Event.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import Foundation

struct Event: Codable {
	var id: Int
	var link: String
	var name: String?
	var ages: String?
	var livestreamInd: Bool
	var date: String
	var startTime: String?
	var endTime: String?
	var venue: Venue
	var artistList: [Artist]
}
