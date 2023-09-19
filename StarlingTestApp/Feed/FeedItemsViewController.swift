//
//  FeedItemsViewController.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import UIKit

typealias DataSource = UICollectionViewDiffableDataSource<Section, FeedItem>
typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, FeedItem>

enum Section: Int, CaseIterable {
    case feed
}

final class FeedItemsViewController: UIViewController {
    
    private enum Const {
        static let cellId = "cellId"
    }
    
    private let presenter: FeedPresenter
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.register(
            FeedItemCollectionViewCell.self,
            forCellWithReuseIdentifier: Const.cellId
        )
        return collectionView
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Transfer money", for: .normal)
        button.addTarget(self, action: #selector(didTapTransfer), for: .touchUpInside)
        return button
    }()
    
    init(presenter: FeedPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        configureRefresh()
        configureDataSource()
        presenter.fetchFeedItems(animatingDifferences: false)
    }
    
    private func setupUI() {
        view.addSubviews([collectionView, actionButton])
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configureRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = .gray
        collectionView.refreshControl = refreshControl
    }
    
    private func configureDataSource() {
        presenter.dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, feedItem) -> FeedItemCollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: Const.cellId, for: indexPath
                ) as? FeedItemCollectionViewCell
                cell?.configure(feedItem)
                return cell
            }
        )
    }
    
    @objc
    private func didTapTransfer() {
        presenter.transferToSavings()
    }
    
    @objc
    private func handleRefresh() {
        presenter.fetchFeedItems(animatingDifferences: true)
    }

}

extension FeedItemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: collectionView.contentSize.width - collectionView.contentInset.left - collectionView.contentInset.right,
            height: 64
        )
    }
}
