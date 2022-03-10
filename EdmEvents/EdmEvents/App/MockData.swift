//
//  SampleData.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/8/22.
//

import Foundation

protocol MockData {
	static func fake() -> Self
}

struct SampleData {
	static let location = Location(id: 69, city: "Las Vegas", state: "Nevada", stateCode: "NV", latitude: 36.17, longitude: -115.14, link: "https://edmtrain.com/las-vegas-nv")
	static let nil_city_location = Location(id: 69, city: nil, state: "British Columbia", stateCode: "BC", latitude: 53.727, longitude: -127.648, link: "https://edmtrain.com/british-columbia?utm_source=131&;amp;utm_medium=api")
	static let venue = Venue(id: 1, name: "Quantum Brooklyn", location: "Brooklyn, NY", address: "177 2nd Ave, Brooklyn, NY 11215, USA", state: "New York", latitude: 40.67, longitude: -73.996)
	static let artists = [Artist(id: 1232, name: "The Black Amigo", link: nil, b2bInd: false), Artist(id: 1232, name: "The Black Amigo", link: nil, b2bInd: false), Artist(id: 1232, name: "The Black Amigo", link: nil, b2bInd: false), Artist(id: 1232, name: "The Black Amigo", link: nil, b2bInd: false)]
	static let event = Event(id: 1, link: "", name: "Takeovr Tuesday", ages: nil, date: "2022-03-08", venue: venue, artistList: artists)
}

