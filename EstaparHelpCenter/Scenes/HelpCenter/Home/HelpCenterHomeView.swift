//
//  HelpCenterHomeView.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import Combine
import SnapKit
import UIKit

class HelpCenterHomeView: UIView, CodeView {
    
    lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var line1Label: UILabel = {
        let label = UILabel()
        label.font = UIFont.estaparSemiBold(size: .font24)
        label.textColor = .estaparSecondary
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    lazy var line2Label: UILabel = {
        let label = UILabel()
        label.font = UIFont.estaparSemiBold(size: .font24)
        label.textColor = .estaparWhite
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var centerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .size20
        view.backgroundColor = .estaparWhite
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = .size15
        flowLayout.minimumInteritemSpacing = .size15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(HelpCenterHomeCategoryCell.self)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let minimumHeaderHeight: CGFloat = .size100
    private let maximumHeaderHeight: CGFloat = .size200
    private var currentHeaderHeight: CGFloat = .size200
    private var previousScrollOffset: CGFloat = .zero
    
    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(headerImageView)
        addSubview(line1Label)
        addSubview(line2Label)
        addSubview(centerView)
        
        centerView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        headerImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(currentHeaderHeight)
        }
        
        line1Label.snp.makeConstraints { (make) -> Void in
            make.horizontalEdges.equalToSuperview().inset(CGFloat.size20)
            make.bottom.equalTo(line2Label.snp.top)
        }
        
        line2Label.snp.makeConstraints { (make) -> Void in
            make.horizontalEdges.equalToSuperview().inset(CGFloat.size20)
            make.bottom.equalTo(headerImageView.snp.bottom).inset(CGFloat.size20)
        }
        
        centerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(headerImageView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(CGFloat.size20)
        }
        
        collectionView.snp.makeConstraints { (make) -> Void in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(CGFloat.size20)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .estaparPrimary
    }
    
    func updateHeaderScroll(offset: CGFloat) -> CGFloat {
        var newOffset: CGFloat = .zero
        let scrollDifference = offset - previousScrollOffset
        
        // If it is scrolling up (hiding the header)
        if scrollDifference > 0 {
            // If the header is hide, propagate the offset
            if currentHeaderHeight == minimumHeaderHeight {
                newOffset = offset
            } else { // If the header is being showed
                // Compute a possible value
                let potentialNewHeight = currentHeaderHeight - scrollDifference
                // If this value is inside the limit, update the height
                if potentialNewHeight > minimumHeaderHeight {
                    currentHeaderHeight = potentialNewHeight
                } else {
                    // If not, the new height will be the limit and the offset will be the extra
                    // difference from this new height
                    newOffset = minimumHeaderHeight - potentialNewHeight
                    currentHeaderHeight = minimumHeaderHeight
                }
            }
        } else { // If it is scrolling down (showing the header)
            // If the header is hide and the offset positive, propagate the same offset
            if currentHeaderHeight == minimumHeaderHeight && offset >= 0 {
                newOffset = offset
            } else { // if the header is being showed or the offset is negative, update the height
                currentHeaderHeight = min(
                    currentHeaderHeight - scrollDifference,
                    maximumHeaderHeight
                )
            }
        }
        
        // Update height
        headerImageView.snp.updateConstraints { (make) -> Void in
            make.height.equalTo(currentHeaderHeight)
        }
        
        // Update alpha
        headerImageView.alpha = (currentHeaderHeight - minimumHeaderHeight) /
                                (maximumHeaderHeight - minimumHeaderHeight)
        
        layoutIfNeeded()
        
        previousScrollOffset = newOffset
        return newOffset
    }
}
