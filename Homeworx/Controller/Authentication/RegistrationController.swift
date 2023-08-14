//
//  RegistrationController.swift
//  Homeworx
//
//  Created by Hassan Mayers on 11/7/23.
//

import UIKit
import Firebase

class RegistrationController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // MARK: - UI Properties
    
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    
    private let selectProfilePicButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 20, weight: .ultraLight))), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.8)
        btn.clipsToBounds = true
        btn.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        return btn
    }()
    
    private let usernameTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Username")
        
        return tf
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
        
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private var signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setLoginOrSignUp(title: "Sign Up")
        btn.backgroundColor = .disabledButtonBlue
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(userDidSignUp), for: .touchUpInside)
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
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else {
            viewModel.username = sender.text
        }
        checkFormValidation()
    }
    
    @objc func selectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    @objc func userDidSignUp() {
        guard let profileImage = profileImage else { return }
        guard let username = usernameTextField.text?.lowercased() else { return }
        guard let fullname = fullNameTextField.text else { return }
        guard let email    = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) {(meta, error) in
            if let error = error {
                print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let profileImageURL = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let data = ["email": email,
                                "fullname": fullname,
                                "profileImageURL": profileImageURL,
                                "uid": uid,
                                "username": username] as [String: Any]
                    
                    Firestore.firestore().collection("users").document(uid).setData(data) { error in
                        
                        if let error = error {
                            print("DEBUG: Failed to upload user data with error: \(error.localizedDescription)")
                            return
                        }
                        self.dismiss(animated: true)
                        print("DEBUG: Did create user...")
                    }
                }
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - UI AutoLayout Functions
    
    func configureUI() {
        view.backgroundColor = .white
        setupSelectProfilePicButton()
        setupUsernameTextField()
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
    
    func setupUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.centerX(inView: view)
        usernameTextField.setDimensions(width: 320, height: 50)
        usernameTextField.anchor(top: selectProfilePicButton.bottomAnchor, paddingTop: 15)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func setupFullNameTextField() {
        view.addSubview(fullNameTextField)
        fullNameTextField.centerX(inView: view)
        fullNameTextField.setDimensions(width: 320, height: 50)
        fullNameTextField.anchor(top: usernameTextField.bottomAnchor, paddingTop: 14)
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
    
    // MARK: - Helper Functions
    
    
    
    // Usage of Form Validation View Model
    
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
        profileImage = image
        selectProfilePicButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        selectProfilePicButton.layer.cornerRadius = 150 / 2
        dismiss(animated: true)
    }
}
