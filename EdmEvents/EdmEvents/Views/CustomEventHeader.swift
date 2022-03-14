//
//  CustomEventHeader.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/13/22.
//

import UIKit

class CustomEventHeader: UITableViewHeaderFooterView {
	 let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Title"
		label.font = UIFont.systemFont(ofSize: 25, weight: .black)
		label.textColor = UIColor(named: AppUIColor.Accent.rawValue)
		label.textAlignment = .left
		return label
	}()
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		configureContents()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configureContents() {
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(titleLabel)

		NSLayoutConstraint.activate([
			//titleLabel.heightAnchor.constraint(equalToConstant: 30),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
			titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
		])
	}
}
