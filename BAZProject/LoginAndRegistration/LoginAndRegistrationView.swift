//
//  LoginAndRegistrationView.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 01/05/23.
// 

import UIKit

class LoginAndRegistrationView: UIViewController {
    
    // MARK: Variables
    var isUserNameEmpty = false
    var isPasswordEmpty = false
    private var defaults = UserDefaults.standard
    
    // MARK: UIElements
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialConfiguration()
    }
    
    // MARK: View configuration
    func initialConfiguration(){
        userNameTextField.addTarget(self, action: #selector(userNameFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordFieldDidChange(_:)), for: .editingChanged)
        userNameTextField.layer.borderWidth = 1.0
        userNameTextField.layer.borderColor = UIColor.systemYellow.cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor.systemYellow.cgColor
        loginButton.setTitleColor(.lightGray, for: .disabled)
        registerButton.setTitleColor(.lightGray, for: .disabled)
        
        if let previousUser = defaults.string(forKey: "lastLogged") {
            welcomeLabel.text = "Welcome back!"
            userNameTextField.text = previousUser
        }
    }
    
    // MARK: IBActions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        print("Login button pressed!")
        let user = userNameTextField.text
        let password = passwordTextField.text

        guard let data = KeychainHelper.retrieve(username: user!) else {
            showAlert("Error", "Incorrect username or password", .alert)
            print("Failed to read password")
            return
        }
        
        let retrievedPassword = String(decoding: data, as: UTF8.self)
        if retrievedPassword == password {
            print("Permitir el login")
//            TODO: (SDA) Erase next line
//            defaults.set(user, forKey: "lastLogged")
            
            let vc = HomeRouter.ensambleModule()
            if #available(iOS 15.0, *) {
                view.window?.windowScene?.keyWindow?.rootViewController = vc
            } else {
                // Fallback on earlier versions
            }
            if #available(iOS 15.0, *) {
                view.window?.windowScene?.keyWindow?.makeKeyAndVisible()
            } else {
                // Fallback on earlier versions
            }
        } else {
            showAlert("Error", "Incorrect username or password", .alert)
            print("Incorrect password")
        }
        //            TODO: (SDA) Erase next line
//        print("Retrieved password: \(retrievedPassword)")
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        print("Register button pressed!")
        let user = userNameTextField.text
        let password = passwordTextField.text
        
        do {
            try KeychainHelper.save(username: user!, password: password!)
            self.showAlert("Success!", "Your login data has been saved.", .alert)
        } catch {
            self.showAlert("Error", "An error occurred: \(error)", .alert)
            print(error)
        }
    }
    
    // MARK: TextFields management
    @objc func userNameFieldDidChange(_ textField: UITextField) {
        welcomeLabel.text =  "Welcome!"
        if textField.text?.isEmpty ?? false {
            isUserNameEmpty = true
            self.configureViewForEmptyFields(textField)
        } else {
            isUserNameEmpty = false
            configureViewForNonEmptyFields(textField)
        }
    }
    
    @objc func passwordFieldDidChange(_ textField: UITextField) {
        if textField.text?.isEmpty ?? false {
            isPasswordEmpty = true
            self.configureViewForEmptyFields(textField)
        } else {
            isPasswordEmpty = false
            configureViewForNonEmptyFields(textField)
        }
    }
    
    func configureViewForEmptyFields(_ textField: UITextField){
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemRed.cgColor
        registerButton.isEnabled = false
        loginButton.isEnabled = false
        self.showAlert("Ups", "There cannot be any empty fields.", .alert)
    }
    
    func configureViewForNonEmptyFields(_ textField: UITextField){
        textField.layer.borderColor = UIColor.systemYellow.cgColor
        if !isUserNameEmpty && !isPasswordEmpty {
            registerButton.isEnabled = true
            loginButton.isEnabled = true
        }
    }
    
    func showAlert(_ title: String, _ message: String, _ style: UIAlertController.Style){
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            print("Something went wrong")
        }))
        present(alert, animated: true)
    }
}

final class KeychainHelper {
    
    enum KeychainError:  Error {
        case duplicateEntry
        case unknown(OSStatus)
    }

    static func save(username: String, password: String) throws {
        let query: [String : Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecValueData as String: password.data(using: .utf8)!
        ]
         
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            throw KeychainError.duplicateEntry
        }
        
        if status != errSecSuccess {
            throw KeychainError.unknown(status)
        }
        
        // TODO: Show a success alert
        print("Log in data saved...")
    }
    
    static func retrieve(username: String) -> Data? {
        let query: [String : Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status != errSecSuccess {
            print("Error: \(KeychainError.unknown(status))")
        } else {
            print("Read status: \(status )")
        }

        return result as? Data
    }
}
