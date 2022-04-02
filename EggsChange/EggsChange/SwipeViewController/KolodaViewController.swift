//
//  KolodaViewController.swift
//  EggsChange
//
//  Created by Андрей Жуков on 20.03.2022.
//

import Foundation
import UIKit
import Koloda

protocol KolodaViewOutput: AnyObject {
    
    func testFunc()
}

final class KolodaViewController: UIViewController {
    
    private let output: KolodaViewOutput
    
    private let kolodaView = KolodaView()
    
    private var productCards: [ProductCardViewModel] = [] {
        didSet { self.kolodaView.reloadData() }
    }
    
    init(output: KolodaViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.output.testFunc()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.configureKolodaView()
        self.addKolodaView()
        self.requestProductCards()
    }
    
    private func configureKolodaView() {
        self.kolodaView.delegate = self
        self.kolodaView.dataSource = self
    }
    
    private func addKolodaView() {
        self.kolodaView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.kolodaView)
        
        NSLayoutConstraint.activate([
            self.kolodaView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.kolodaView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.kolodaView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.kolodaView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func requestProductCards() {
        #warning("Stub, replace with actual request")
        self.requestData { self.productCards = $0 }
    }
    
    private func requestData(completion: @escaping ([ProductCardViewModel]) -> Void) {
        let urls: [URL] = [
            "https://62.img.avito.st/image/1/1.t5_9Z7axG3bL0Jl7nzn_mXDEG3JBxhF0.AxSZ9UjwdHXg-IeI6inTxZKcfb4KsUrwL9C3idKTpNs",
            "https://80.img.avito.st/image/1/1.oZssFraxDXIaoY9_YkSR6YC1DXaQtwdw.CRogUOMfEGPC5SqveWBQmcxMobQCJEP5XSbLbuTmbsE",
            "https://16.img.avito.st/image/1/1.9cRGb7axWS1w2NsgICzegbPMWSn6zlMv.L1Q2oxaODSGmOa60vZx247s5133Cl99edym_JvrC7X8"
        ].compactMap { URL(string: $0) }
        
        var images: [UIImage] = []
        
        let dispatchGroup = DispatchGroup()
        
        urls.forEach {
            dispatchGroup.enter()
            self.requestImages(from: $0) { image in
                images.append(image)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            let models = images.map { ProductCardViewModel(image: $0, title: "Продукт") }
            completion(models)
        }
    }

    private func requestImages(from url: URL, then completion: @escaping (UIImage) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil
                  , let imageData = data
                  , let image = UIImage(data: imageData)
                  , image.size.height > 0 else {
                return
            }
            DispatchQueue.main.async { completion(image) }
        }
        task.resume()
    }
}

// MARK: - KolodaViewDelegate

extension KolodaViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        self.requestProductCards()
    }

}

// MARK: - KolodaViewDataSource

extension KolodaViewController: KolodaViewDataSource {
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let viewModel = self.productCards[index]
        
        let view = ProductCard()
        view.configure(with: viewModel)
        return view
    }
    
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        self.productCards.count
    }
}
