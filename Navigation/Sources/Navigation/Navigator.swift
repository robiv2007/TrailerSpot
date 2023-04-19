//
//  Navigator.swift
//  TrailerSpot
//
//  Created by Robert Vatran on 2023-04-19.
//

import SwiftUI

/// Protocol conforming to Codable and Hashable.
/// To use generic type as a path on the NavigationStack
public protocol NavigationStackable: Codable, Hashable {}

/// An object responsible  for converting `NavigationStackable` into a View.
/// The class should be inherited for the app-specific implementation with the app-specific entity specified as generic parameter.
///
/// An example of the app-specific implementation:
/// ```
/// class AppDestinationViewer: DestinationViewer<Destination> {
///    @ViewBuilder
///    override func view(for destination: Destination) -> any View {
///        switch destination {
///        case .onboarding:
///            OnboardingView()
///
///        case .authentication:
///            AuthenticationView()
///        }
///    }
/// }
/// ```
///
/// Using an open class instead of a protocol because when a protocol is used as a property you can't pass a generic type to it (`DestinationViewer<SomeType>`),
/// you need to make the entity where you use the protocol as a property generic with the type of the protocol. Because of the current architecture, the Navigation and Presentation
/// don't know anything about the `DestinationViewer` implementation but we need to create a typealias to be used in the `Presentation` where we would have to specify
/// the implementation of the generic `DestinationViewer`. But using a class allows us to specify our viewer as `DestinationViewer<T>` in the `Navigator` property.
///
open class DestinationViewer<T: NavigationStackable> {
    /// Initializes an instance of DestinationViewer.
    public init() { }

    /// Returns view associated with the passed destination. Should be overridden by the subclass with the concrete implementation for the `NavigationStackable` entity.
    /// - Parameter destination: The destination view entity.
    /// - Returns: A view associated with the passed destination.
    @ViewBuilder
    open func view(for destination: T) -> any View {
        EmptyView()
    }
}

/// Entity responsible for navigation between views in the app.
public class Navigator<T: NavigationStackable>: ObservableObject {
    @Published private var root: T
    @Published private var path: [T] = []

    private let viewer: DestinationViewer<T>

    private var pathBinding: Binding<[T]> {
        Binding {
            self.path
        } set: { newValue, _ in
            self.path = newValue
        }
    }

    /// Root view in the navigation hierarchy.
    public var rootView: some View {
        NavigationStack(path: pathBinding) {
            AnyView(viewer.view(for: root))
                .navigationDestination(for: T.self) { destination in
                    AnyView(self.viewer.view(for: destination))
                }
        }
    }

    /// - Parameter root: Initial root view. First view to be displayed
    /// - Parameter viewer: Object responsible for converting Destination into View
    public required init(root: T, viewer: DestinationViewer<T>) {
        self.root = root
        self.viewer = viewer
    }

    /// Changes root view. Won't affect anything if the new root is same as was before.
    /// - Parameter newRoot: View to change the root view to.
    public func setRoot(_ newRoot: T) {
        path.removeAll()
        root = newRoot
    }

    /// Navigates to another view
    /// - Parameter destination: View to navigate to.
    public func push(_ destination: T) {
        path.append(destination)
    }

    /// Releases the current view and goes to previous one.
    public func pop() {
        path.removeLast()
    }

    /// Releases all the views and goes to the root view.
    public func popToRoot() {
        path.removeAll()
    }
}
