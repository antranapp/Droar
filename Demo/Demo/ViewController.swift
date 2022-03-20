//
// Copyright © 2022 An Tran. All rights reserved.
//

import UIKit
import Combine

final class ViewController: UIViewController {
    
    private var appService: AppService
    
    private var bag = Set<AnyCancellable>()
    
    private lazy var label = UILabel()
    
    init(appService: AppService) {
        self.appService = appService
        super.init(nibName: nil, bundle: nil)
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        label.text = "\(appService.boolVar)"
        label.textAlignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [label])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: stackView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: stackView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
        ])
    }
    
    private func setupBindings() {
        appService.$boolVar
            .sink { [weak self] value in
                self?.label.text = "\(value)"
            }
            .store(in: &bag)
    }
}

