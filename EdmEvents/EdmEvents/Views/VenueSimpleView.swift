//
//  VenueSimpleView.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/8/22.
//

import UIKit
import CoreLocation

class VenueSimpleView: UIView {

	// MARK: - UI Setup
	
	var icon: UIImageView = {
		let imageView = UIImageView(image: UIImage(systemName: "mappin.circle"))
		imageView.contentMode = .scaleAspectFit
		imageView.tintColor = UIColor(named: AppUIColor.Accent.rawValue)
		return imageView
	}()
	
	var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "title"
		label.textAlignment = .left
		label.textColor = UIColor(named: AppUIColor.SecondaryLabel.rawValue)
		label.font = UIFont.systemFont(ofSize: 14, weight: .light)
		return label
	}()
	
	var stack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		//stack.spacing = 8
		stack.distribution = .fill
		return stack
	}()
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		layoutUI()
	}
	override init(frame: CGRect) {
		super.init(frame: frame)
		layoutUI()
	}
	
	// MARK: - Layout UI
	
	func layoutUI() {
		[icon, titleLabel].forEach {
			//stack.addArrangedSubview($0)
			addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
		//addSubview(stack)
		//stack.translatesAutoresizingMaskIntoConstraints = false
		stack.backgroundColor = .red
		NSLayoutConstraint.activate(
			[icon.leadingAnchor.constraint(equalTo: leadingAnchor),
			 icon.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
			 icon.centerYAnchor.constraint(equalTo: centerYAnchor),
			 icon.widthAnchor.constraint(equalTo: icon.heightAnchor),
			 titleLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10),
			 titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			 titleLabel.topAnchor.constraint(equalTo: topAnchor),
			 titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
			])
	}
	
	// MARK: - Configuration
	
	func configure(with venueViewModel: VenueViewModel) {
		titleLabel.text = venueViewModel.simpleAddress
	}

}
