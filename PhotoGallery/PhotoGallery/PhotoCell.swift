//
//  PhotoCell.swift
//  PhotoGallery
//
//  Created by Tatiana Luzanova on 08.03.2022.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {
    
    static let reusedID = "PhotoCell"
    private var sizeLabel = UILabel()
    var photoImageView = UIImageView(frame: .zero)
    var index = Int()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUICell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Setup UI
    private func setupUICell() {
        setupImageView()
        setupSizeLabel()
        setupLayoutCell()
    }
    
    private func setupImageView() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(photoImageView)
    }
    
    private func setupSizeLabel() {
        sizeLabel.backgroundColor = UIColor.white
        sizeLabel.font = UIFont.systemFont(ofSize: 10)
        sizeLabel.textColor = UIColor.black
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sizeLabel)
    }
    
    //    MARK: - Layout
    private func setupLayoutCell() {
        NSLayoutConstraint.activate([
            sizeLabel.heightAnchor.constraint(equalToConstant: 15),
            sizeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            sizeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: sizeLabel.topAnchor),
            
        ])
    }
    
    func configure(model: UnsplashPhoto, indexPath: Int) {
        sizeLabel.text = "\(model.width) x \(model.height)"
        index = indexPath
    }
    
    func setImage(url: String) {
        guard let downLoadURL = URL(string: url) else { return }
        let resource = ImageResource(downloadURL: downLoadURL)
        photoImageView.kf.setImage(with: resource, placeholder: nil, options: nil, completionHandler: nil)
    }
}
