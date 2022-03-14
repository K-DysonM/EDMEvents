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
		return Event(id: 167913,
					 link: "https://edmtrain.com/columbus-oh/baynk-167913?utm_source=131&;amp;utm_medium=api",
					 name: nil,
					 ages: "18+",
					 date: "2022-03-10",
					 venue: Venue.fake(),
					 artistList: [Artist.fake()])
	}
}
