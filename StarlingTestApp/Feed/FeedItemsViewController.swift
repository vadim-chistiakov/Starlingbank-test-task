//
//  FeedItemsViewController.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import UIKit

typealias DataSource = UICollectionViewDiffableDataSource<Section, FeedItemCellModel>
typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, FeedItemCellModel>

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
        collectionView.register(
            FeedItemCollectionViewCell.self,
            forCellWithReuseIdentifier: Const.cellId
        )
        return collectionView
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.contentInset = .init(
            top: 0, left: 16, bottom: view.safeAreaInsets.bottom + 64, right: 16
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureDataSource()
        presenter.applySnapshotCompletion = { [weak self] in
            guard let self else { return }
            self.actionButton.setTitle(
                "Transfer money \(self.presenter.moneyToSavingsGoalsFormatted)",
                for: .normal
            )
        }
        presenter.fetchFeedItems(animatingDifferences: false)
        
    }
    
    //MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Feed"
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
    
    private func configureDataSource() {
        presenter.dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, model) -> FeedItemCollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: Const.cellId, for: indexPath
                ) as? FeedItemCollectionViewCell
                cell?.configure(model)
                return cell
            }
        )
    }
    
    @objc
    private func didTapTransfer() {
        presenter.transferToSavings()
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
