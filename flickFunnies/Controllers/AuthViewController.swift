//
//  AuthViewController.swift
//  flickFunnies
//
//  Created by Batista Tone on 19/05/23.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var authSegmentControl: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonSubmitAuth: UIButton!
    @IBOutlet weak var errorMsgLabel: UILabel!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    let userDefaults = UserDefaults()
    var fetcherController = FetcherController(apiUrl: API_URL)
    
    var authSegmentTexts = [0: "Sign in", 1: "Sign up"]
    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = Constants.colors.background
        
        
        
        fetcherController.delegate = self
        
        setupForm(textField: emailTextField); setupForm(textField: passwordTextField)
        
        errorMsgLabel.isHidden = true
        
        authSegmentControl.addTarget(self, action: #selector(self.segmentValueChanged(_:)), for: .valueChanged)
        
        buttonSubmitAuth.layer.cornerRadius = 5
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        let token = userDefaults.string(forKey: "accessToken")
       
        if(token != nil){
            self.performSegue(withIdentifier: "FeedView", sender: self)
        }
        
    }
    
    func clearForm(){
        errorMsgLabel.isHidden = true
        emailTextField.text = ""
        passwordTextField.text = ""
        loadingIndicator.stopAnimating()
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl){
        
        let text  = authSegmentTexts[authSegmentControl.selectedSegmentIndex]
      
        buttonSubmitAuth.setTitle(text, for: .normal)
        
        clearForm()
    }
    
    
    func setupForm(textField: UITextField){
        textField.layer.cornerRadius = 5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
    }
    

    @IBAction func authSubmitPressed(_ sender: UIButton) {
        
        loadingIndicator.startAnimating()
        
        if(authSegmentControl.selectedSegmentIndex == 0){
            authSignIn()
        }else{
            authSignUp()
        }
        
    }
    
    func authSignIn(){
       if let email = emailTextField.text,
          let pwd = passwordTextField.text {
           fetcherController.makeRequest(endpoint: "signin", method: "POST", params: ["email": email, "password":pwd], model: AuthResponseModal.self)
       }
    }
    
    func authSignUp(){
        if let email = emailTextField.text,
           let pwd = passwordTextField.text {
            fetcherController.makeRequest(endpoint: "signup", method: "POST", params: ["email": email, "password":pwd], model: AuthResponseModal.self)
           
        }
    }
    
}


extension AuthViewController: FetcherDelegate {

    func handleSuccess(data: Any) {
        let response = data as! AuthResponseModal
       
        DispatchQueue.main.async {
            self.userDefaults.set(response.accessToken, forKey: "accessToken")
            self.loadingIndicator.stopAnimating()
            self.errorMsgLabel.isHidden = true
            self.performSegue(withIdentifier: "FeedView", sender: self)
        }
    }

    func handleError(data: Any) {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.errorMsgLabel.isHidden = false
            self.errorMsgLabel.text = (data as! String)
        }
    }
    
}


