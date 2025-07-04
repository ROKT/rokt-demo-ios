import SwiftUI
import UIKit

// This is the SwiftUI wrapper that makes the UIKit view controller available to SwiftUI
struct SimpleTextViewControllerWrapper: UIViewControllerRepresentable {
    let text: String
    
    func makeUIViewController(context: Context) -> SimpleTextViewController {
        return SimpleTextViewController(text: text)
    }
    
    func updateUIViewController(_ uiViewController: SimpleTextViewController, context: Context) {
        // Update the view controller if needed
    }
}

// Example usage in a SwiftUI view:
struct ExampleView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SimpleTextViewControllerWrapper(text: "Hello from SwiftUI!")) {
                    Text("Show UIKit View Controller")
                }
                
                // You can also use it with a custom title
                NavigationLink(destination: SimpleTextViewControllerWrapper(text: "Custom Title")
                    .navigationTitle("UIKit View")
                    .navigationBarTitleDisplayMode(.inline)
                ) {
                    Text("Show UIKit View with Custom Title")
                }
            }
            .navigationTitle("UIKit in SwiftUI")
        }
    }
}

// Example of how to use it with a custom navigation bar appearance:
struct CustomNavigationExample: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SimpleTextViewControllerWrapper(text: "Custom Navigation")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                // Handle done action
                            }
                        }
                    }
                ) {
                    Text("Show UIKit View with Custom Navigation")
                }
            }
            .navigationTitle("Custom Navigation")
        }
    }
}

// Example of how to use it with a custom presentation style:
struct ModalPresentationExample: View {
    @State private var isPresented = false
    
    var body: some View {
        Button("Show UIKit View") {
            isPresented = true
        }
        .sheet(isPresented: $isPresented) {
            NavigationView {
                SimpleTextViewControllerWrapper(text: "Presented Modally")
                    .navigationTitle("Modal Presentation")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                isPresented = false
                            }
                        }
                    }
            }
        }
    }
} 