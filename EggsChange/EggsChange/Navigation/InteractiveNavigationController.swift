//
//  TabbarNavigationController.swift
//  EggsChange
//
//  Created by Андрей Жуков on 13.03.2022.
//

import Foundation
import UIKit

final class InteractiveNavigationController: UINavigationController {
    
    private weak var popRecognizer: UIScreenEdgePanGestureRecognizer?
    private var interactivePopTransition: UIPercentDrivenInteractiveTransition?
    
    // MARK: - Lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.isNavigationBarHidden = true
        self.delegate = self
        self.interactivePopGestureRecognizer?.delegate = self
        let popRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePopRecognizer(_:)))
        popRecognizer.edges = .left
        self.view.addGestureRecognizer(popRecognizer)
        self.popRecognizer = popRecognizer
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationBar.layoutSubviews()
    }
    
    // MARK: - Orientation

    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        self.viewControllers.first?.supportedInterfaceOrientations ?? .all
    }
    
    override public var shouldAutorotate: Bool {
        self.viewControllers.first?.shouldAutorotate ?? true
    }
    
   // MARK: - Gestures
    
    @objc
    private func handlePopRecognizer(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        var progress = recognizer.translation(in: self.view).x / self.view.bounds.size.width
        progress = min(1.0, max(progress, 0.0))
        let velocity = recognizer.view >>- { recognizer.velocity(in: $0) } ?? .zero
        switch recognizer.state {
        case .began:
            self.interactivePopTransition = UIPercentDrivenInteractiveTransition()
            self.interactivePopTransition?.completionCurve = .linear
            self.popViewController(animated: true)
        case .changed:
            self.interactivePopTransition?.update(progress)
        case .ended, .cancelled:
            if progress > 0.5 || velocity.x > 400.0 {
                self.interactivePopTransition?.finish()
            } else {
                self.interactivePopTransition?.cancel()
            }
            self.interactivePopTransition = nil
        default:
            return
        }
    }
}

// MARK: - UINavigationControllerDelegate

extension InteractiveNavigationController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController,
                                     interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactivePopTransition
    }
    
}

// MARK: - UIGestureRecognizerDelegate

extension InteractiveNavigationController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
    
}
