//
//  OpenViewController.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/13/22.
//

import UIKit

class OpenViewController: UIViewController {
	var coordinator: HomeBaseCoordinating?
	
	var stackTopAnchor: NSLayoutConstraint? = nil
	var stackBottomAnchor: NSLayoutConstraint? = nil
	
	init(coordinator: HomeBaseCoordinating) {
		self.coordinator = coordinator
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	lazy var stack: UIStackView = {
		let stack = UIStackView()
		stack.alignment = .leading
		stack.axis = .vertical
		stack.distribution = .equalSpacing
		stack.spacing = 5
		return stack
	}()
	
	
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Title"
		label.font = UIFont.systemFont(ofSize: 40, weight: .black)
		label.numberOfLines = 0
		label.textColor = UIColor(named: AppUIColor.OpenScreenText.rawValue)
		label.textAlignment = .left
		return label
	}()
	
	lazy var subtitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Subtitle"
		label.font = UIFont.systemFont(ofSize: 18, weight: .thin)
		label.numberOfLines = 0
		label.textColor = .white
		label.textAlignment = .left
		return label
	}()
	
	lazy var image: UIImageView = {
		let image = UIImageView(image: UIImage(named: "DanceLogo"))
		image.contentMode = .scaleAspectFit
		image.setContentHuggingPriority(.init(rawValue: 249), for: .vertical)
		image.setContentCompressionResistancePriority(.init(rawValue: 749), for: .vertical)
		return image
	}()
	
	lazy var button: UIButton = {
		let button = UIButton()
		button.setTitle("Pick a city", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.backgroundColor =  UIColor(named: AppUIColor.Button.rawValue)?.withAlphaComponent(0.30)
		button.layer.cornerRadius = 20
		button.layer.borderColor = UIColor(named: AppUIColor.Button.rawValue)?.cgColor
		button.layer.borderWidth = 2.0
		return button
	}()
	
	override func loadView() {
		view = UIView()
		view.backgroundColor = .systemBackground
		[titleLabel, subtitleLabel, image, button].forEach {
			stack.addArrangedSubview($0)
		}
		view.addSubview(stack)
		stack.translatesAutoresizingMaskIntoConstraints = false
		
		stackTopAnchor = stack.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
		stackBottomAnchor = stack.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
		
		NSLayoutConstraint.activate(
			[stack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 8),
			 stack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 8),
			 stack.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
			 image.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
			 button.heightAnchor.constraint(equalToConstant: 60),
			 button.widthAnchor.constraint(equalTo: stack.widthAnchor, constant: -20)
			]
		)
	}
	override func viewWillLayoutSubviews() {
		print(#function)
		super.viewWillLayoutSubviews()
		if UIDevice.current.orientation.isLandscape {
			print("is Landscape")
			stackTopAnchor?.isActive = true
			stackBottomAnchor?.isActive = true
		} else {
			print("is Portrait")
			stackTopAnchor?.isActive = false
			stackBottomAnchor?.isActive = false
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		titleLabel.text = "Lets Party"
		subtitleLabel.text = "Find the next event near you"
		button.addTarget(self, action: #selector(openLocations), for: .touchUpInside)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: false)
	}
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(false, animated: false)
	}
	
	@objc func openLocations() {
		coordinator?.openLocationChoices()
	}

}
