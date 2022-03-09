//
//  EventTableViewCell.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/8/22.
//

import UIKit

class EventTableViewCell: UITableViewCell {

	// MARK: - UI Setup
	
	var titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
		label.textColor = .white
		label.text = "Title"
		return label
	}()
	
	var subtitleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
		label.textColor = .white
		label.numberOfLines = 2
		label.text = "Subtitle"
		return label
	}()
	
	var stack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.alignment = .leading
		stack.spacing = 8
		stack.distribution = .fillEqually
		return stack 
	}()
	
	var venueSimpleView: VenueSimpleView = {
		let venueSimpleView = VenueSimpleView()
		return venueSimpleView
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		layoutUI()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		layoutUI()
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	// MARK: - Layout UI
	
	func layoutUI() {
		[titleLabel, subtitleLabel, venueSimpleView].forEach {
			stack.addArrangedSubview($0)
		}
		
		contentView.addSubview(stack)
		stack.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(
			[stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			 stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			 stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			 stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
			])
	}
	
	// MARK: - Configuration
	
	func configure(with eventViewModel: EventViewModel) {
		titleLabel.text = eventViewModel.name
		subtitleLabel.text = eventViewModel.lineup
		venueSimpleView.configure(with: eventViewModel.venueViewModel)
	}

}
