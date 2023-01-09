//
//  RegisterMorningViewController.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/04.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import MorningBearUI
import MorningBearKit
import MorningBearImage

class RegisterMorningViewController: UIViewController {
    // MARK: - Instance properties
    private let viewModel = RegisterMorningViewModel()
    private let bag = DisposeBag()
    
    // For category collection view
    var datasource: UICollectionViewDataSource?
    var delegate: UICollectionViewDelegate?
    
    // MARK: - View components
    /// 이미지와 라벨을 포함한 래퍼 뷰
    @IBOutlet weak var imageWrapperView: UIView!
    
    private var morningImage: UIImage?
    @IBOutlet weak var morningImageView: UIImageView! {
        didSet {
            morningImageView.layer.cornerRadius = 8
            
            let overlayView = UIView(frame: morningImageView.frame)
            overlayView.backgroundColor = .black.withAlphaComponent(0.5)
            
            morningImageView.addSubview(overlayView)
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 24)
            dateLabel.text = viewModel.currdntDayString
        }
    }
    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            timeLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 40)
            timeLabel.text = viewModel.currentTimeString
        }
    }
    
    // MARK: Category collection view
    @IBOutlet weak var categoryCollectionView: UICollectionView! {
        didSet {
            configureCompositionalCollectionView()
        }
    }
    
    // MARK: Lables
    @IBOutlet weak var categoryLabel: UILabel! {
        didSet {
            categoryLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    @IBOutlet weak var startMorningLabel: UILabel!{
        didSet {
            startMorningLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    @IBOutlet weak var endMorningLabel: UILabel!{
        didSet {
            endMorningLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    @IBOutlet weak var commentLabel: UILabel!{
        didSet {
            commentLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    
    // MARK: Text field
    @IBOutlet weak var startTimeTextField: MorningBearUITextField! {
        didSet {
            startTimeTextField.text = "오전 12시 1분"
            startTimeTextField.isUserInteractionEnabled = false
        }
    }
    @IBOutlet weak var endTimeTextField: MorningBearUITextField!{
        didSet {
            endTimeTextField.text = viewModel.currentTimeString
            endTimeTextField.isUserInteractionEnabled = false

        }
    }
    @IBOutlet weak var commentTextView: MorningBearUITextView! {
        didSet {
            commentTextView.textContainer.maximumNumberOfLines = 6
        }
    }
    
    // MARK: Buttons
    @IBOutlet weak var categoryHelpButton: MorningBearUIIconButton! {
        didSet {
            categoryHelpButton.shape(icon: .questionMark)
        }
    }
    @IBOutlet weak var commentWriteButton: MorningBearUIIconButton! {
        didSet {
            commentWriteButton.shape(icon: .pencil)
        }
    }
    @IBOutlet weak var registerButton: LargeButton!
    
    // MARK: - View controller methods
    override func viewDidLoad() {
        super.viewDidLoad()

        designNavigationBar()
        
        
        if let morningImage {
            self.morningImageView.image = morningImage
        } else {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 85, weight: .regular, scale: .large)

            let placeholderImage = UIImage(systemName: "xmark.circle", withConfiguration: largeConfig)!
                .withTintColor(.white, renderingMode: .alwaysOriginal)
            
            self.morningImageView.image = placeholderImage
            self.morningImageView.contentMode = .center
        }
        
        bindButtons()
    }
}

extension RegisterMorningViewController {
    func prepare(_ image: UIImage) {
        self.morningImage = image
    }
}

private extension RegisterMorningViewController {
    func designNavigationBar() {
        navigationItem.title = "오늘의 미라클모닝"
    }
    
    func bindButtons() {
        registerButton.rx.tap.bind { [weak self] in
            guard let self else { return }
            
            do {
                guard let startTimeText = self.startTimeTextField.text,
                      let endTimeText = self.endTimeTextField.text
                else {
                    throw RegisterMorningViewModel.DataError.emptyData
                }
                
                guard let image = self.imageWrapperView.toUIImage else {
                    throw RegisterMorningViewModel.DataError.emptyData
                }
                
                let commentText = self.commentTextView.text ?? ""
                
                let info = try self.viewModel.convertViewContentToInformation(image,
                                                                              startTimeText,
                                                                              endTimeText,
                                                                              commentText)
                
                self.viewModel.registerMorningInformation(info: info)
            } catch let error {
                self.showAlert(error)
            }
        }
        .disposed(by: bag)
    }
}

// MARK: Set category collection view
extension RegisterMorningViewController: CollectionViewCompositionable {
    func layoutCollectionView() {
        let provider = CompositionalLayoutProvider()
        let layout = UICollectionViewCompositionalLayout(section: provider.horizontalScrollLayoutSection(showItemCount: 5))
        
        categoryCollectionView.collectionViewLayout = layout
    }
    
    func designCollectionView() {
        categoryCollectionView.alwaysBounceHorizontal = true
        categoryCollectionView.alwaysBounceVertical = false
    }
    
    func connectCollectionViewWithDelegates() {
        let reuseId = "CapsuleCell"
        let common = HorizontalScrollCollectionViewDataSource<CapsuleCell, String>(
            reuseIndentifier: reuseId,
            items: viewModel.categories,
            configure: { cell, item in
                cell.prepare(title: item)
            }
        )
        
        datasource = common
        delegate = common
        
        categoryCollectionView.dataSource = datasource
        categoryCollectionView.delegate = delegate
    }
    
    func registerCells() {
        let bundle = MorningBearUIResources.bundle
        let cellNib = UINib(nibName: "CapsuleCell", bundle: bundle)
        categoryCollectionView.register(cellNib, forCellWithReuseIdentifier: "CapsuleCell")
    }
}
