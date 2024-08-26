import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

struct Endpoint
{
    static let registerUser = "https://api-dev-scus-demo.azurewebsites.net/api/User/RegisterUser"
    static let getUser = "https://api-dev-scus-demo.azurewebsites.net/api/User/GetUser"
}

struct User
{
//     Function to register a new user
    func registerUser()
    {
        // Setting the URLRequest with the register user endpoint
        var urlRequest = URLRequest(url: URL(string: Endpoint.registerUser)!)
        // Setting the HTTP method to POST as we are sending data to the server
        urlRequest.httpMethod = "post"
        // Data dictionary containing user details to be sent in the request body
        let dataDictionary = ["name":"zeeshan", "email":"zeeshan15@gmail.com","password":"1234"]
        
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
                print()
                print("This is the post data")
                debugPrint(response!)
            }
        }.resume()
    }


    // Function to get user data from the server
    func GetUserFromServer()
    {
        // Setting the URLRequest with the get user endpoint
        var urlRequest = URLRequest(url: URL(string: Endpoint.getUser)!)
        // Setting the HTTP method to GET as we are retrieving data from the server
        urlRequest.httpMethod = "get"

        // Creating a data task to perform the network request
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            if(data != nil && data?.count != 0)
            {
                // Parsing the JSON response received from the server
                let response = String(data: data!, encoding: .utf8)
                print()
                print("This is the get data")
                debugPrint(response!)
            }
        }.resume()
    }
}

let objUser = User()
objUser.registerUser()
objUser.GetUserFromServer()


