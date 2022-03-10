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
	var date: String
	var venue: Venue
	var artistList: [Artist]
}
extension Event {
	static func fake() -> Self {
		return Event(id: 1,
					 link: "",
					 name: "The Event name",
					 ages: nil,
					 date: "2022-03-08",
					 venue: Venue.fake(),
					 artistList: [Artist.fake()])
	}
}
