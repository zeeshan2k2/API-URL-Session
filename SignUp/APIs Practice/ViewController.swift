//
//  ViewController.swift
//  APIs Practice
//
//  Created by ali on 26/08/2024.
//

import UIKit


struct Endpoint
{
    static let registerUser = "https://api-dev-scus-demo.azurewebsites.net/api/User/RegisterUser"
    static let getUser = "https://api-dev-scus-demo.azurewebsites.net/api/User/GetUser"
}


class ViewController: UIViewController {

    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    
    @IBOutlet weak var togglePasswordVisibilityBtn: UIButton! // Add this IBOutlet for the button
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        passwordTxtField.isSecureTextEntry = true
        
        // Set up the toggle button
        togglePasswordVisibilityBtn.setTitle("Show", for: .normal) // Initial button title
        togglePasswordVisibilityBtn.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        // Add Done button to keyboard for text fields
        addDoneButtonOnKeyboard()
        
    }
    
    
    @objc func togglePasswordVisibility() {
        // Toggle the secure text entry property of the password text field
        passwordTxtField.isSecureTextEntry.toggle()
        
        // Update the button title based on the current visibility state
        let buttonTitle = passwordTxtField.isSecureTextEntry ? "Show" : "Hide"
        togglePasswordVisibilityBtn.setTitle(buttonTitle, for: .normal)
        }

    func postingData() {
        let name = nameTxtField.text ?? " "
        let email = emailTxtField.text ?? " "
        let password = passwordTxtField.text ?? " "
        
        // Validate email
        if !isValidEmail(email) {
            // Show an alert if email is invalid
            showAlert(withTitle: "Invalid Email", message: "Please enter a valid email address.")
            return
        }
        
        registerUser(name: name, email: email, password: password)
        
    }
    
    @IBAction func onClick() {
        print("Button clicked!")
        
        postingData()
//        objUser.GetUserFromServer()
    }

    // Function to register a new user
    func registerUser(name: String, email: String, password: String)
    {
        
        // Setting the URLRequest with the register user endpoint
        var urlRequest = URLRequest(url: URL(string: Endpoint.registerUser)!)
        // Setting the HTTP method to POST as we are sending data to the server
        urlRequest.httpMethod = "post"
        // Data dictionary containing user details to be sent in the request body
        let dataDictionary = ["name":name, "email":email,"password":password]
        
        // Using do-catch for error handling when converting the data dictionary to JSON
        do {
            // Converting the data dictionary to JSON format
            let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)
            
            // Setting the HTTP body of the request
            urlRequest.httpBody = requestBody
            // Adding the content-type header field to specify JSON data
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")

        } catch let error {
            // Handling any errors that occur during JSON serialization
            debugPrint(error.localizedDescription)
        }

        // Creating a data task to perform the network request
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            if(data != nil && data?.count != 0)
            {
                // Parsing the JSON response received from the server
                let response = String(data: data!, encoding: .utf8)
                print("This is the post data")
                debugPrint(response!)
            }
        }.resume()
    }

    private func addDoneButtonOnKeyboard() {
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            toolbar.items = [flexibleSpace, doneButton]
            
            nameTxtField.inputAccessoryView = toolbar
            emailTxtField.inputAccessoryView = toolbar
            passwordTxtField.inputAccessoryView = toolbar
        }
        
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    private func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailPredicate.evaluate(with: email)
        }

    private func showAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
        
}


