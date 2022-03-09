//
//  SampleData.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/8/22.
//

import Foundation

struct SampleData {
	static let venue = Venue(id: 1, name: "Quantum Brooklyn", location: "Brooklyn, NY", address: "177 2nd Ave, Brooklyn, NY 11215, USA", state: "New York", latitude: 40.67, longitude: -73.996)
	static let artists = [Artist(id: 1232, name: "The Black Amigo", link: nil, b2bInd: false), Artist(id: 1232, name: "The Black Amigo", link: nil, b2bInd: false), Artist(id: 1232, name: "The Black Amigo", link: nil, b2bInd: false), Artist(id: 1232, name: "The Black Amigo", link: nil, b2bInd: false)]
	static let event = Event(id: 1, link: "", name: "Takeovr Tuesday", ages: nil, livestreamInd: false, date: "2022-03-08", startTime: nil, endTime: nil, venue: venue, artistList: artists)
}

