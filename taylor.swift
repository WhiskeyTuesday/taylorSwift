import Foundation

func approximateExp(x: Double, nTerms: Int) -> Double {
    var approximation: Double = 0
    for n in 0..<nTerms {
        let term: Double = pow(x, Double(n)) / Double(factorial(n))
        approximation += term
    }
    return approximation
}

func factorial(_ n: Int) -> Int {
    if n == 0 {
        return 1
    }
    return (1...n).reduce(1, *)
}

func generateDataForGnuplot(xStart: Double, xEnd: Double, step: Double, nTerms: Int) {
    var dataActual = ""
    var dataApproximation = ""

    for x in stride(from: xStart, through: xEnd, by: step) {
        let actual = exp(x)
        let approximation = approximateExp(x: x, nTerms: nTerms)
        
        dataActual += "\(x) \(actual)\n"
        dataApproximation += "\(x) \(approximation)\n"
    }
    
    let tmpDir = "/tmp"
    let actualFilePath = "\(tmpDir)/actual.dat"
    let approximationFilePath = "\(tmpDir)/approximation.dat"

    do {
        try dataActual.write(to: URL(fileURLWithPath: actualFilePath), atomically: true, encoding: .utf8)
        try dataApproximation.write(to: URL(fileURLWithPath: approximationFilePath), atomically: true, encoding: .utf8)
        print("Data written to \(actualFilePath) and \(approximationFilePath)")
    } catch {
        print("Failed to write data to files: \(error)")
    }
}

// Call the function to generate data files
generateDataForGnuplot(xStart: -2.0, xEnd: 2.0, step: 0.1, nTerms: 10)

