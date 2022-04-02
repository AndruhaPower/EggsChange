//
//  SwipeViewController.swift
//  EggsChange
//
//  Created by Андрей Жуков on 20.03.2022.
//

import Foundation
import UIKit

fileprivate let _productCardWidth = UIScreen.main.bounds.width * 0.75
fileprivate let _productCardHeight = UIScreen.main.bounds.height * 0.7
fileprivate let _productCardSize = CGSize(width: _productCardWidth, height: _productCardHeight)


final class SwipeViewController: UIViewController {
    
    private lazy var kolodaViewController = KolodaViewController(output: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addKolodaViewController()
    }
    
    private func addKolodaViewController() {
        self.kolodaViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(self.kolodaViewController)
        self.view.addSubview(self.kolodaViewController.view)
        NSLayoutConstraint.activate([
            self.kolodaViewController.view.widthAnchor.constraint(equalToConstant: _productCardWidth),
            self.kolodaViewController.view.heightAnchor.constraint(equalToConstant: _productCardHeight),
            self.kolodaViewController.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.kolodaViewController.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        self.kolodaViewController.didMove(toParent: self)
    }
}

extension SwipeViewController: KolodaViewOutput {
    
    func testFunc() {
        print("koloda view loaded")
    }
}
