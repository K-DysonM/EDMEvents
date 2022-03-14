//
//  FavoriteEmptyView.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/13/22.
//

import UIKit

class TableEmptyView: UIView {

	// MARK: - UI Setup
	
	var stack: UIStackView = {
		let stack = UIStackView()
		stack.alignment = .center
		stack.axis = .vertical
		stack.distribution = .equalSpacing
		stack.spacing = 10
		return stack
	}()
	
	var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Title"
		label.numberOfLines = 0
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
		label.textColor = .white
		return label
	}()
	
	var subtitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Subtitle"
		label.numberOfLines = 0
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 17, weight: .light)
		label.textColor = UIColor(named: AppUIColor.SecondaryLabel.rawValue)
		return label
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
		backgroundColor = .systemBackground
		[titleLabel, subtitleLabel].forEach { view in
			stack.addArrangedSubview(view)
		}
		addSubview(stack)
		stack.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate(
			[stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			 stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),
			 stack.centerYAnchor.constraint(equalTo: centerYAnchor),
			])
	}
	
	// MARK: - Configuraiton
	
	func configure(title: String, message: String) {
		titleLabel.text = title
		subtitleLabel.text = message
	}
}
