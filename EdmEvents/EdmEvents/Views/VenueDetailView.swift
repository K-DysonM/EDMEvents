//
//  VenueDetailView.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/8/22.
//

import UIKit
import Combine

class VenueDetailView: UIView {
	
	var viewModel: VenueViewModel?
	private var subscriptions = Set<AnyCancellable>()
	
	
	// MARK: - UI Setup
	
	var stack: UIStackView = {
		let stack = UIStackView()
		stack.alignment = .leading
		stack.axis = .vertical
		stack.distribution = .fillEqually
		return stack
	}()
	
	var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Title"
		label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
		label.textColor = .white
		label.textAlignment = .left
		return label
	}()
	
	var subtitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Subtitle"
		label.font = UIFont.systemFont(ofSize: 17, weight: .light)
		label.textColor = UIColor(named: AppUIColor.SecondaryLabel.rawValue)
		label.textAlignment = .left
		return label
	}()
	
	var secondarySubtitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Subtitle"
		label.font = UIFont.systemFont(ofSize: 17, weight: .light)
		label.textColor = UIColor(named: AppUIColor.SecondaryLabel.rawValue)
		label.textAlignment = .left
		return label
	}()
	
	var button: UIButton = {
		let button = UIButton()
		button.setTitle("View Map", for: .normal)
		button.setTitleColor(UIColor(named: AppUIColor.Button.rawValue), for: .normal)
		//button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
		return button
	}()
	
	var icon: UIImageView = {
		let imageview = UIImageView(image: UIImage(systemName: "mappin.circle"))
		imageview.tintColor = UIColor(named: AppUIColor.Accent.rawValue)
		return imageview
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
		backgroundColor = .black
		[titleLabel, subtitleLabel, secondarySubtitleLabel, button].forEach {
			stack.addArrangedSubview($0)
		}
		[icon, stack].forEach {
			addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
		let firstItem = stack.arrangedSubviews[0]
		
		NSLayoutConstraint.activate(
			[icon.heightAnchor.constraint(equalToConstant: 25),
			 icon.widthAnchor.constraint(equalToConstant: 25),
			// icon.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			 icon.centerYAnchor.constraint(equalTo: firstItem.centerYAnchor),
			 icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
			 stack.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10),
			 stack.trailingAnchor.constraint(equalTo: trailingAnchor),
			 stack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			 stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
			])
	}
	
	
	// MARK: - Configuration
	
	func configure(with venueViewModel: VenueViewModel) {
		self.viewModel = venueViewModel
		
		subscriptions = [
			venueViewModel.$name.assign(to: \.text!, on: titleLabel),
			venueViewModel.$primaryAddress.assign(to: \.text!, on: subtitleLabel),
			venueViewModel.$secondaryAddress.assign(to: \.text!, on: secondarySubtitleLabel),
		]
		
		venueViewModel.$isAddress.sink { [weak self] result in
			guard let self = self else { return }
			if result {
				self.button.setTitle("View Map", for: .normal)
				self.secondarySubtitleLabel.isHidden = false
			} else {
				self.button.setTitle("View Link", for: .normal)
				self.secondarySubtitleLabel.isHidden = true
			}
		}.store(in: &subscriptions)

	}
}

