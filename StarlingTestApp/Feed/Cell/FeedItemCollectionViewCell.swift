//
//  FeedItemCollectionViewCell.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import UIKit

final class FeedItemCollectionViewCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(
            descriptor: .preferredFontDescriptor(withTextStyle: .subheadline),
            size: 14
        )
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(
            descriptor: .preferredFontDescriptor(withTextStyle: .body),
            size: 12
        )
        label.textColor = .gray
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(
            descriptor: .preferredFontDescriptor(withTextStyle: .body),
            size: 14
        )
        label.textColor = .red
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews([titleLabel, categoryLabel, priceLabel])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
        ])
        
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 4),
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ model: FeedItemCellModel) {
        titleLabel.text = model.title
        priceLabel.text = model.price
        categoryLabel.text = model.category
    }
}
