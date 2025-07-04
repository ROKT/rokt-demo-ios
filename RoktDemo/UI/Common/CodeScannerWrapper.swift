import UIKit
import SwiftUI
import CodeScanner

// This is the SwiftUI view that will be wrapped
struct CodeScannerSwiftUIView: View {
    let codeTypes: [AVMetadataObject.ObjectType]
    let completion: (Result<ScanResult, ScanError>) -> Void
    
    var body: some View {
        CodeScannerView(
            codeTypes: codeTypes,
            completion: completion
        )
    }
}

// This is the UIKit wrapper that makes the CodeScanner view available to UIKit
class CodeScannerWrapper: UIHostingController<CodeScannerSwiftUIView> {
    private let completion: (Result<ScanResult, ScanError>) -> Void
    
    init(codeTypes: [AVMetadataObject.ObjectType], completion: @escaping (Result<ScanResult, ScanError>) -> Void) {
        self.completion = completion
        
        let swiftUIView = CodeScannerSwiftUIView(
            codeTypes: codeTypes,
            completion: completion
        )
        
        super.init(rootView: swiftUIView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Example usage in a UIKit view controller:
class ExampleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a button to trigger the scanner
        let scanButton = UIButton(type: .system)
        scanButton.setTitle("Scan QR Code", for: .normal)
        scanButton.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)
        scanButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scanButton)
        
        NSLayoutConstraint.activate([
            scanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scanButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func scanButtonTapped() {
        // Create and present the scanner
        let scannerVC = CodeScannerWrapper(
            codeTypes: [.qr],
            completion: handleScan
        )
        
        // Present modally
        present(scannerVC, animated: true)
    }
    
    private func handleScan(result: Result<ScanResult, ScanError>) {
        // Dismiss the scanner
        dismiss(animated: true)
        
        switch result {
        case .success(let result):
            // Handle successful scan
            print("Found code: \(result.string)")
            
            // Show the result in an alert
            let alert = UIAlertController(
                title: "Scan successful",
                message: "Found code: \(result.string)",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            
        case .failure(let error):
            // Handle scan error
            print("Scan failed: \(error.localizedDescription)")
            
            // Show error in an alert
            let alert = UIAlertController(
                title: "Scan failed",
                message: error.localizedDescription,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}

// Example of how to use it in a navigation controller:
class NavigationExampleViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scannerVC = CodeScannerWrapper(
            codeTypes: [.qr, .ean8, .ean13, .pdf417],
            completion: { result in
                switch result {
                case .success(let result):
                    print("Found code: \(result.string)")
                case .failure(let error):
                    print("Scan failed: \(error.localizedDescription)")
                }
            }
        )
        
        setViewControllers([scannerVC], animated: false)
    }
}

// Example of how to use it with custom options:
class CustomScannerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scannerVC = CodeScannerWrapper(
            codeTypes: [.qr],
            completion: handleScan
        )
        
        // Customize the scanner view controller
        scannerVC.modalPresentationStyle = .fullScreen
        scannerVC.view.backgroundColor = .black
        
        present(scannerVC, animated: true)
    }
    
    private func handleScan(result: Result<ScanResult, ScanError>) {
        dismiss(animated: true)
        
        switch result {
        case .success(let result):
            // Handle successful scan
            print("Found code: \(result.string)")
            
        case .failure(let error):
            // Handle scan error
            print("Scan failed: \(error.localizedDescription)")
        }
    }
} 