//
//  LayoutDemoUIView.swift
//  RoktDemo
//
//  Copyright 2020 Rokt Pte Ltd
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import UIKit
import SwiftUI
import CodeScanner
import Rokt_Widget
import AVFoundation
import Combine

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

class LayoutDemoUIView: UIViewController {
    private var viewModel: LayoutDemoViewModel
    private var cancellables = Set<AnyCancellable>()
    private let appState: AppState
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Layout Library"
        label.font = .defaultHeadingFont(.header1)
        label.textColor = .titleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scanButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Scan new Layout", for: .normal)
        button.titleLabel?.font = .defaultButtonFont()
        button.backgroundColor = .white
        button.setTitleColor(.uiappColor, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.uiappColor.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let roktEmbeddedView: RoktEmbeddedView = {
        let view = RoktEmbeddedView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var embeddedSize: CGFloat = 0
    
    init(viewModel: LayoutDemoViewModel, appState: AppState) {
        self.viewModel = viewModel
        self.appState = appState
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupObservers()
        
        scanButton.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)

        if (appState.previewParameterString != nil) {
            self.viewModel.parseQRcodeResult(appState.previewParameterString!)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .gray3
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(headerLabel)
        contentView.addSubview(scanButton)
        contentView.addSubview(roktEmbeddedView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            scanButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            scanButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            scanButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            scanButton.heightAnchor.constraint(equalToConstant: 50),
            
            roktEmbeddedView.topAnchor.constraint(equalTo: scanButton.bottomAnchor, constant: 20),
            roktEmbeddedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            roktEmbeddedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            roktEmbeddedView.heightAnchor.constraint(equalToConstant: 0),
            roktEmbeddedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupObservers() {
        viewModel.$uiState
            .sink { [weak self] state in
                self?.handleUIStateChange(state)
            }
            .store(in: &cancellables)
    }
    
    @objc private func scanButtonTapped() {
        viewModel.uiState = .loading
        let scannerVC = CodeScannerWrapper(
            codeTypes: [.qr],
            completion: handleScan
        )
        present(scannerVC, animated: true)
    }
    
    private func handleScan(result: Result<ScanResult, ScanError>) {
        dismiss(animated: true) { [weak self] in
            switch result {
            case .success(let result):
                self?.viewModel.parseQRcodeResult(result.string)
            case .failure(let error):
                self?.viewModel.uiState = .error(error: error.localizedDescription)
            }
        }
    }
    
    private func handleUIStateChange(_ state: LayoutDemoUIState) {
        switch state {
        case .hasData:
            showPlacement()
        case .loading:
            appState.previewParameterString = nil
        case .error(let error):
            showError(error)
        default:
            break
        }
    }
    
    private func showPlacement() {
        Rokt.execute(viewName: "",
                    attributes: viewModel.getAttributes(),
                    placements: ["#rokt-placeholder": roktEmbeddedView],
                    onLoad: { [weak self] in
            self?.viewModel.uiState = .done
        }, onUnLoad: { [weak self] in
            self?.viewModel.uiState = .done
        }, onEmbeddedSizeChange: { [weak self] selectedPlacement, widgetHeight in
            self?.updateEmbeddedViewHeight(widgetHeight)
        })
    }
    
    private func updateEmbeddedViewHeight(_ height: CGFloat) {
        embeddedSize = height
        roktEmbeddedView.constraints.first { $0.firstAttribute == .height }?.constant = height
        view.layoutIfNeeded()
    }
    
    class ErrorViewController: UIViewController {
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
    
    private func showError(_ error: String) {
        let errorVC = ErrorViewController(text: error)
        present(errorVC, animated: true)
    }
} 
