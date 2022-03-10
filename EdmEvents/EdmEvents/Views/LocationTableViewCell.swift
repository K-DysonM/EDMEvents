//
//  LocationTableViewCell.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/8/22.
//

import UIKit
import Combine

class LocationTableViewCell: UITableViewCell {
	private var subscriptions = Set<AnyCancellable>()
	var locationViewModel: LocationViewModel?
	
	// MARK: - UI Setup
	
	var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Title"
		label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
		label.textColor = .white
		label.textAlignment = .left
		return label
	}()
	
	var subtitleLabel: UILabel = {
		let label = UILabel()
		label.text = "subTitle"
		label.font = UIFont.systemFont(ofSize: 14, weight: .light)
		label.textColor = UIColor(named: AppUIColor.SecondaryLabel.rawValue)
		label.textAlignment = .left
		return label
	}()
	
	var stack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.distribution = .fillEqually
		return stack
	}()
	
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		layoutUI()
		
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		layoutUI()
	}
	
	// MARK: - UI Layout
	
	func layoutUI() {
		[titleLabel, subtitleLabel].forEach {
			stack.addArrangedSubview($0)
		}
		contentView.addSubview(stack)
		stack.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate(
			[
			stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			stack.topAnchor.constraint(equalTo: contentView.topAnchor),
			stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
			])
	}
	
	
	// MARK: - Configuration
	
	func configure(with locationViewModel: LocationViewModel) {
		self.locationViewModel = locationViewModel
		subscriptions = [
			self.locationViewModel!.$primary.assign(to: \.text!, on: titleLabel),
			self.locationViewModel!.$secondary.assign(to: \.text!, on: subtitleLabel)
		]
	}

   

}
