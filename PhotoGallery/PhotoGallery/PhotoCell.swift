//
//  PhotoCell.swift
//  PhotoGallery
//
//  Created by Tatiana Luzanova on 08.03.2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    static let reusedID = "PhotoCell"
    
    var photoImageView = UIImageView(frame: .zero)
    var index = Int()
    private var activityIndicator = UIActivityIndicatorView()
  
    
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
       // backgroundColor = UIColor.blue
        setupImageView()
        setupActivityIndicator()
        setupLayoutCell()
    }
    
    private func setupImageView() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(photoImageView)
    }
    
    private func setupActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
    }
    
    //    MARK: - Layout
    private func setupLayoutCell() {
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func configure(indexPath: Int) {
        index = indexPath
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = UIImage()
    }
}
