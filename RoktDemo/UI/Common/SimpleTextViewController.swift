import UIKit

class SimpleTextViewController: UIViewController {
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    init(text: String) {
        super.init(nibName: nil, bundle: nil)
        textLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add label to view
        view.addSubview(textLabel)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// Example usage:
/*
let viewController = SimpleTextViewController(text: "Hello, World!")
present(viewController, animated: true)

// Or in a navigation controller:
let viewController = SimpleTextViewController(text: "Hello, World!")
navigationController?.pushViewController(viewController, animated: true)
*/ 