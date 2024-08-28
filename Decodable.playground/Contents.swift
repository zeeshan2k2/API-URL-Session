import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


// Define a struct to represent the structure of an employee response from the API.
struct EmployeeResponse: Decodable {
    // Properties of the employee
    let employeeId, depid: Int
    let salary: Double
    let name, role, joining, workPhone: String

    // Define coding keys to map JSON keys to struct properties
    enum CodingKeys: String, CodingKey {
        case depid = "dep_id" // Map "dep_id" in JSON to depid
        case joining = "joining_date" // Map "joining_date" in JSON to joining
        case employeeId = "id" // Map "id" in JSON to employeeId
        case salary // Map "salary" in JSON to salary
        case name, role, workPhone // Map "name", "role", and "workPhone" in JSON to corresponding properties
    }
}

// Define a struct for managing employee-related operations
struct Employee {
    // Method to fetch and decode employee data from the API
    func getEmployeeData() {
        // URL of the API endpoint
        let employeeApiUrl = "http://demo0333988.mockable.io/Employees"

        // Create a URLSession data task to fetch data from the API
        URLSession.shared.dataTask(with: URL(string: employeeApiUrl)!) { (responseData, httpUrlResponse, error) in
            
            // Check if there was no error and data is present
            if(error == nil && responseData != nil && responseData?.count != 0) {
                // Create a JSON decoder to decode the data
                let decoder = JSONDecoder()
                do {
                    // Decode the response data into an array of EmployeeResponse objects
                    let result = try decoder.decode([EmployeeResponse].self, from: responseData!)

                    // Loop through each employee in the result and print their name
                    for employee in result {
                        debugPrint(employee.name)
                    }
                } catch let error {
                    // Print any errors that occur during decoding
                    debugPrint("Error occurred while decoding = \(error.localizedDescription)")
                }
            }

        }.resume() // Start the data task
    }
}

// Create an instance of the Employee struct and fetch employee data
let objEmployee = Employee()
objEmployee.getEmployeeData()
