import UIKit
import PlaygroundSupport


PlaygroundPage.current.needsIndefiniteExecution = true


// API
// What are API/REST API/WebService
// Why are they used in mobile applications
// How to get data from API using Swift


// Function to fetch data from a given URL and parse it
func getData() {
    // Create a URLSession shared instance
    let session = URLSession.shared
    
    // Define the URL to fetch data from
    let serviceUrl = URL(string: "https://jsonplaceholder.typicode.com/todos/1")
    
    // Create a data task to fetch data from the URL
    let task = session.dataTask(with: serviceUrl!) { (serviceData, serviceResponse, error) in
        
        // Check if there was no error
        if error == nil {
            // Safely cast the response to HTTPURLResponse
            let httpResponse = serviceResponse as! HTTPURLResponse
            
            // Check if the status code indicates success (200 OK)
            if httpResponse.statusCode == 200 {
                // Attempt to parse the JSON data
                do {
                    // Convert the data into a JSON object with mutable containers
                    let jsonData = try JSONSerialization.jsonObject(with: serviceData!, options: .mutableContainers)
                    
                    // Cast the JSON object to a Dictionary
                    let result = jsonData as! Dictionary<String, Any>
                    
                    // Print the value associated with the "id" key
                    print("id = \(result["id"]!)")
                } catch {
                    // Handle JSON parsing error
                    print("Error parsing JSON: \(error.localizedDescription)")
                }
            } else {
                // Handle HTTP response status code error
                print("HTTP Error: Status code \(httpResponse.statusCode)")
            }
        } else {
            // Handle error in fetching data
            print("Network Error: \(error!.localizedDescription)")
        }
    }
    
    // Start the data task
    task.resume()
}

// Call the function to execute the network request
getData()



