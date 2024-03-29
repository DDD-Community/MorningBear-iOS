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
    // MARK: Instance properties
    private let viewModel = RegisterMorningViewModel()
    private let bag = DisposeBag()
    
    // For category collection view
    var categoryCollectionViewProvider: HorizontalScrollCollectionViewProvider<CapsuleCell, String>?
    
    private var popAction: (() -> Void)!
    
    // MARK: View components
    @IBOutlet weak var scrollView: UIScrollView!
    
    /// 이미지와 라벨을 포함한 래퍼 뷰
    @IBOutlet weak var imageWrapperView: UIView!
    
    private var morningImage: UIImage?
    @IBOutlet weak var morningImageView: UIImageView! {
        didSet {
            morningImageView.layer.cornerRadius = 8
            
            let frame = CGRect(x: 0,
                               y: 0,
                               width: morningImageView.frame.width + 10,
                               height: morningImageView.frame.height + 10)
            
            let overlayView = UIView(frame: frame)
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
    private var startTimeText: String?
    @IBOutlet weak var startTimeTextField: MorningBearUITextField! {
        didSet {
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
            commentTextView.placeholder(text: "오늘 실천한 미라클 모닝에 관하여 입력해주세요")
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
        
        setKeyboardObserver()
        
        // 등록 뷰에서 보이는 이미지 초기화
        if let morningImage {
            // 밖에서 받았으면 그걸로 초기화
            self.morningImageView.image = morningImage
        } else {
            // 없으면 기본 이미지로 초기화
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 85, weight: .regular, scale: .large)

            let placeholderImage = UIImage(systemName: "xmark.circle", withConfiguration: largeConfig)!
                .withTintColor(.white, renderingMode: .alwaysOriginal)
            
            self.morningImageView.image = placeholderImage
            self.morningImageView.contentMode = .center
        }
        
        if let startTimeText {
            self.startTimeTextField.text = startTimeText
        } else {
            fatalError("시작 시간은 반드시 존재해야 함")
        }
        
        bindButtons()
        bindObservables()
    }
}

// MARK: - Public tools
extension RegisterMorningViewController {
    /// 기록이 이상하면 에러 튕김
    ///
    /// 지금은 1분 미만이면 튕김
    func prepare(startTime: Date, image: UIImage?, popAction: @escaping () -> Void) {
        startTimeText = viewModel.timeFormatter.string(from: startTime)
        
        if let image {
            morningImage = image
        }
        
        self.popAction = popAction
    }
}

// MARK: - Internal tools
private extension RegisterMorningViewController {
    func designNavigationBar() {
        navigationItem.title = "오늘의 미라클모닝"
    }
    
    func bindObservables() {
        viewModel.isNetworking
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] value in
                guard let self else { return }
                
                self.registerButton.isEnabled = value ? false : true
                self.registerButton.alpha = value ? 0.5 : 1.0
            })
            .disposed(by: bag)
    }
    
    func bindButtons() {
        registerButton.rx.tap.bind { [weak self] in
            guard let self else { return }
            
            do {
                // 고른 카테고리 텍스트 가져오고(선택 안하면 에러)
                let category = try self.getCategoryTextInsideCell()
                
                // 시간 파싱 가능한지 체크
                guard let startTimeText = self.startTimeTextField.text,
                      let endTimeText = self.endTimeTextField.text
                else {
                    throw RegisterMorningViewError.emptyData
                }
                
                // 이미지 정상인지 체크
                guard let image = self.imageWrapperView.toUIImage else {
                    throw RegisterMorningViewError.emptyData
                }
                
                let commentText = self.commentTextView.text ?? ""
                
                // 정보 등록
                self.viewModel
                    .registerMorningInformation(image, category, startTimeText, endTimeText, commentText)
                    .subscribe(
                        onSuccess: { _ in
                            self.navigationController?.popViewController(animated: true)
                            self.popAction()
                        },
                        onFailure: { error in
                            self.showAlert(error)
                        })
                    .disposed(by: self.bag)
                
            } catch let error {
                self.showAlert(error)
            }
        }
        .disposed(by: bag)
    }
    
    func getCategoryTextInsideCell() throws -> Int {
        guard let categoryCollectionViewProvider else {
            fatalError("카테고리 콜렉션 뷰가 설정되지 않음")
        }
        
        guard let selectedCategoryIndexPath = categoryCollectionViewProvider.currentSelectedIndexPath else {
            throw RegisterMorningViewError.emptyCategory
        }
        
        return selectedCategoryIndexPath.row
    }
    
    /// 시간 정상적인지 체크
    func canSubmitDate(date: Date) -> Bool {
        if date.timeIntervalSinceNow > -60 {
            return false
        } else {
            return true
        }
    }
}

// MARK: - Set category collection view
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
        categoryCollectionViewProvider = HorizontalScrollCollectionViewProvider<CapsuleCell, String>(
            reuseIndentifier: reuseId,
            items: viewModel.categories,
            configure: { cell, item in
                cell.prepare(title: item)
            }
        )
        
        categoryCollectionView.dataSource = categoryCollectionViewProvider?.datasource
        categoryCollectionView.delegate = categoryCollectionViewProvider?.delegate
    }
    
    func registerCells() {
        let bundle = MorningBearUIResources.bundle
        let cellNib = UINib(nibName: "CapsuleCell", bundle: bundle)
        categoryCollectionView.register(cellNib, forCellWithReuseIdentifier: "CapsuleCell")
    }
}

// MARK: - Keyboard avoidance 설정
extension RegisterMorningViewController {
    func setKeyboardObserver() {

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object:nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        

        var contentInset: UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
//        scrollView.contentOffset.y += keyboardFrame.size.height
    }

    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}
