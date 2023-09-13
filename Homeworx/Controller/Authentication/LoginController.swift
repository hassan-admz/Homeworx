//
//  LoginController.swift
//  Homeworx
//
//  Created by Hassan Mayers on 11/7/23.
//

import UIKit
import Firebase
import JGProgressHUD

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private let logoImg: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "HomeworxLogo-noBg")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let emailTxtFld: CustomTextField = {
        let tf = CustomTextField(placeholder: "Email")
        return tf
    }()
    
    private let passwordTxtFld: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setLoginOrSignUp(title: "Log In")
        btn.backgroundColor = .disabledButtonBlue
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(logUserIn), for: .touchUpInside)
        return btn
    }()
    
    private let forgotPwBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.attributedTitle(firstText: "Forgot your password?", secondText: "Get help signing in.")
        return btn
    }()
    
    private let signUpBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.attributedTitle(firstText: "Don't have an account?", secondText: "Sign Up")
        btn.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Actions
    
    
    @objc func logUserIn() {
        guard let email = emailTxtFld.text else { return }
        guard let password = passwordTxtFld.text else { return }
        
        showLoader(true, withText: "Logging in")
        
        AuthService.shared.logInUser(withEmail: email, password: password) { result, error in
            
            guard error == nil else {
                self.showLoader(false)
                self.resetLoginScreen()
                self.showLoginErrorAlert()
//                self.presentRegistrationScreen()
                print("Error creating user")
                return
            }
            self.showLoader(false)
            self.dismiss(animated: true)
//            let user = theResult.user
            print("Logged in user")
        }
    }
    
    @objc func didTapSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTxtFld {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupLogo()
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupForgotPasswordButton()
        setupSignUpButton()
    }
    
    func setupLogo() {
        view.addSubview(logoImg)
        logoImg.centerX(inView: view)
        logoImg.setDimensions(width: 360, height: 240)
        logoImg.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: -40)
    }
    
    func setupEmailTextField() {
        view.addSubview(emailTxtFld)
        emailTxtFld.centerX(inView: view)
        emailTxtFld.setDimensions(width: 320, height: 50)
        emailTxtFld.anchor(top: logoImg.bottomAnchor, paddingTop: -50)
    }
    
    func setupPasswordTextField() {
        view.addSubview(passwordTxtFld)
        passwordTxtFld.centerX(inView: view)
        passwordTxtFld.setDimensions(width: 320, height: 50)
        passwordTxtFld.anchor(top: emailTxtFld.bottomAnchor, paddingTop: 14)
        passwordTxtFld.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func setupLoginButton() {
        view.addSubview(loginBtn)
        loginBtn.centerX(inView: view)
        loginBtn.setDimensions(width: 320, height: 50)
        loginBtn.anchor(top: passwordTxtFld.bottomAnchor, paddingTop: 14)
        emailTxtFld.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func setupForgotPasswordButton() {
        view.addSubview(forgotPwBtn)
        forgotPwBtn.centerX(inView: view)
        forgotPwBtn.setDimensions(width: 300, height: 50)
        forgotPwBtn.anchor(top: loginBtn.bottomAnchor, paddingTop: 19)
    }
    
    func setupSignUpButton() {
        view.addSubview(signUpBtn)
        signUpBtn.centerX(inView: view)
        signUpBtn.setDimensions(width: 250, height: 50)
        signUpBtn.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 0)
    }
    
    func presentRegistrationScreen() {
            DispatchQueue.main.async {
                let controller = RegistrationController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }
    
    func resetLoginScreen() {
        emailTxtFld.text = ""
        passwordTxtFld.text = ""
        loginBtn.backgroundColor = .disabledButtonBlue
        loginBtn.isEnabled = false
    }
    
    func showLoginErrorAlert() {
        let alert = UIAlertController(title: "Sign In Error", message: "Unable to sign in. Please verify your email and/or password and try again", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        self.present(alert, animated: true)
    }
    
    var viewModel = LoginViewModel()
    func checkFormStatus() {
        if viewModel.formIsValid {
            loginBtn.isEnabled = true
            loginBtn.backgroundColor = .twitterBlue
        } else {
            loginBtn.isEnabled = false
            loginBtn.backgroundColor = .disabledButtonBlue
        }
    }
}



