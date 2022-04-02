//
//  ProductCard.swift
//  EggsChange
//
//  Created by Андрей Жуков on 20.03.2022.
//

import Foundation
import UIKit

final class ProductCard: UIView {
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    
    init() {
        super.init(frame: .zero)
        self.configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ProductCardViewModel) {
        self.titleLabel.text = viewModel.title
        self.imageView.image = viewModel.image
    }
    
    private func configureUI() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 16.0
        self.addImageView()
        self.addTitleLabel()
    }
    
    private func addImageView() {
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imageView)
        
        NSLayoutConstraint.activate([
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func addTitleLabel() {
        self.titleLabel.textColor = .black
        self.titleLabel.numberOfLines = 2
        self.titleLabel.isUserInteractionEnabled = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.insertSubview(self.titleLabel, aboveSubview: self.imageView)
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20.0),
            self.titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20.0)
        ])
    }
}
