//
//  SetProfileViewController.swift
//  MorningBear
//
//  Created by 이건우 on 2023/01/20.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit
import PhotosUI
import MorningBearUI

import RxSwift
import RxCocoa

class SetProfileViewController: UIViewController {
    
    private let bag = DisposeBag()
    private var imageIsSelected: Bool = false
    var viewModel: InitialInfoViewModel!
    
    private lazy var photoPicker: PHPickerViewController = {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        return PHPickerViewController(configuration: configuration)
    }()
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 24)
            titleLabel.textColor = .white
            titleLabel.text = "프로필을 설정해 주세요"
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 16)
            descriptionLabel.textColor = MorningBearUIAsset.Colors.disabledText.color
            descriptionLabel.text = "나를 잘 보여주는 사진과 닉네임을 작성해 주세요"
        }
    }
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.layer.masksToBounds = true
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
            profileImageView.image = MorningBearUIAsset.Images.profilePlaceholder.image
        }
    }
    @IBOutlet weak var cameraImageView: UIImageView! {
        didSet {
            cameraImageView.contentMode = .scaleAspectFit
            cameraImageView.image = MorningBearUIAsset.Images.camera.image
        }
    }
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var nicknameTextField: UITextField! {
        didSet {
            nicknameTextField.borderStyle = .none
            nicknameTextField.textAlignment = .center
            nicknameTextField.tintColor = .white
            nicknameTextField.font = MorningBearUIFontFamily.Pretendard.Typography.bodyLarge.font
            nicknameTextField.placeholder = "닉네임을 입력해주세요"
            nicknameTextField.addTarget(self, action: #selector(self.textFieldIsEditing(_:)), for: .editingChanged)
        }
    }
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cameraImageView.contentMode = .scaleAspectFit
            cancelButton.setImage(MorningBearUIAsset.Images.cancelCircle.image, for: .normal)
            cancelButton.isHidden = true
        }
    }
    @IBOutlet weak var underLine: UIView! {
        didSet {
            underLine.backgroundColor = MorningBearUIAsset.Colors.disabledText.color
        }
    }
    @IBOutlet weak var warningIcon: UIImageView! {
        didSet {
            warningIcon.contentMode = .scaleAspectFit
            warningIcon.image = MorningBearUIAsset.Images.errorWarning.image
            warningIcon.isHidden = true
        }
    }
    @IBOutlet weak var warningLabel: UILabel! {
        didSet {
            warningLabel.font = MorningBearUIFontFamily.Pretendard.Typography.bodySmall.font
            warningLabel.textAlignment = .center
            warningLabel.textColor = MorningBearUIAsset.Colors.canceledDark.color
            warningLabel.isHidden = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        bindButtons()
        
        self.view.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
    }
    
    private func setDelegate() {
        photoPicker.delegate = self
        nicknameTextField.delegate = self
    }
    
    private func bindButtons() {
        takePhotoButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.present(owner.photoPicker, animated: true)
            }
            .disposed(by: bag)
        
        cancelButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.nicknameTextField.text?.removeAll()
                owner.cancelButton.isHidden = true
            }
            .disposed(by: bag)
    }
    
    private func isValidNickName(_ nickname: String?) -> Bool {
        guard nickname != nil else { return false }
        
        let nickRegEx = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]*$"
        let pred = NSPredicate(format:"SELF MATCHES %@", nickRegEx)
        print(pred.evaluate(with: nickname))
        return pred.evaluate(with: nickname)
    }
    
    private func showWarningLabel() {
        warningLabel.isHidden = false
        warningIcon.isHidden = false
    }
    
    private func hideWarningLabel() {
        warningLabel.isHidden = true
        warningIcon.isHidden = true
    }
    
    private func checkStateAndAvailiableNextButton() {
        var value = viewModel.canGoNext.value
        hideWarningLabel()
        
        if nicknameTextField.text == "" {
            hideWarningLabel()
            
            value[viewModel.currentIndex.value] = false
            viewModel.canGoNext.accept(value)
        } else if nicknameTextField.text?.count ?? 0 < 2 {
            warningLabel.text = "최소 2자, 최대 8자 이내로 입력해주세요"
            showWarningLabel()
            
            value[viewModel.currentIndex.value] = false
            viewModel.canGoNext.accept(value)
        } else if !isValidNickName(nicknameTextField.text) {
            warningLabel.text = "올바른 형식의 닉네임을 입력해주세요"
            showWarningLabel()
            
            value[viewModel.currentIndex.value] = false
            viewModel.canGoNext.accept(value)
        } else if !imageIsSelected {
            value[viewModel.currentIndex.value] = false
            viewModel.canGoNext.accept(value)
        } else {
            value[viewModel.currentIndex.value] = true
            viewModel.canGoNext.accept(value)
        }
    }
    
    @objc func textFieldIsEditing(_ sender: Any?) {
        if nicknameTextField.text == "" {
            cancelButton.isHidden = true
        } else {
            cancelButton.isHidden = false
        }
        
        DispatchQueue.main.async {
            self.checkStateAndAvailiableNextButton()
        }
    }
}

extension SetProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        photoPicker.dismiss(animated: true)
        
        if let itemProvider = results.first?.itemProvider,
            itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                DispatchQueue.main.async {
                    self.profileImageView.image = image as? UIImage
                    self.imageIsSelected = true
                    self.checkStateAndAvailiableNextButton()
                }
            }
        } else {
            print("empty results or item provider not being able load UIImage")
        }
    }
}

extension SetProfileViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let maxLength = 8
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textField.text!.count < maxLength else {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
}
