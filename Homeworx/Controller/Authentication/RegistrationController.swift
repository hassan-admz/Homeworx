//
//  RegistrationController.swift
//  Homeworx
//
//  Created by Hassan Mayers on 11/7/23.
//

import UIKit

class RegistrationController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // MARK: - UI Properties
    
    private let selectProfilePicButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 20, weight: .ultraLight))), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.8)
        btn.clipsToBounds = true
        btn.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        return btn
    }()
    
    private let fullNameTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Fullname")
        return tf
    }()
    
    private let emailTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Email")
        return tf
    }()
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        return tf
    }()
    
    private var signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setLoginOrSignUp(title: "Sign Up")
        btn.backgroundColor = .disabledButtonBlue
        btn.isEnabled = false
        return btn
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.attributedTitle(firstText: "Already have an account?", secondText: "Sign In")
        btn.addTarget(self, action: #selector(didTapGoToLogIn), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Actions
    
    @objc func didTapGoToLogIn() {
        let controller = LoginController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == fullNameTextField {
            viewModel.fullName = sender.text
        } else if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        checkFormValidation()
    }
    
    @objc func selectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        setupSelectProfilePicButton()
        setupFullNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignUpButton()
        setupAlreadyHaveAccountButton()
    }
    
    func setupSelectProfilePicButton() {
        view.addSubview(selectProfilePicButton)
        selectProfilePicButton.centerX(inView: view)
        selectProfilePicButton.setDimensions(width: 150, height: 150)
        selectProfilePicButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 18)
    }
    
    func setupFullNameTextField() {
        view.addSubview(fullNameTextField)
        fullNameTextField.centerX(inView: view)
        fullNameTextField.setDimensions(width: 320, height: 50)
        fullNameTextField.anchor(top: selectProfilePicButton.bottomAnchor, paddingTop: 15)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func setupEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.centerX(inView: view)
        emailTextField.setDimensions(width: 320, height: 50)
        emailTextField.anchor(top: fullNameTextField.bottomAnchor, paddingTop: 14)
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.centerX(inView: view)
        passwordTextField.setDimensions(width: 320, height: 50)
        passwordTextField.anchor(top: emailTextField.bottomAnchor, paddingTop: 14)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func setupSignUpButton() {
        view.addSubview(signUpButton)
        signUpButton.centerX(inView: view)
        signUpButton.setDimensions(width: 320, height: 50)
        signUpButton.anchor(top: passwordTextField.bottomAnchor, paddingTop: 14)
    }
    
    func setupAlreadyHaveAccountButton() {
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.setDimensions(width: 250, height: 50)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0)
    }
    
    // Usage of Form Validation View Model
    
    var viewModel = RegistrationViewModel()
    func checkFormValidation() {
        if viewModel.formIsValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .twitterBlue
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = .disabledButtonBlue
        }
    }
}

extension RegistrationController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        selectProfilePicButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        selectProfilePicButton.layer.cornerRadius = 150 / 2
        dismiss(animated: true)
    }
}
