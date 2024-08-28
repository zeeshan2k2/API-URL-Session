import Foundation

// Define a function that performs an asynchronous operation
func performAsyncOperation(completion: @escaping (String) -> Void) {
    
    let result = "Performed @escaping closure"

    DispatchQueue.main.async {
        completion(result)
    }
    
    print("Performed Main Function")
}

// Usage example
performAsyncOperation { result in
    print(result)  // Prints: Operation Completed
}

