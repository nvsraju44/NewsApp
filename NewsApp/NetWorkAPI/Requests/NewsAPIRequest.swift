import Foundation

struct NewsAPIRequest: ApiRequest {

    var urlRequest: URLRequest {
        let url: URL! = URL(string: "http://newsapi.org/v2/everything?q=tesla&from=2021-01-04&sortBy=publishedAt&apiKey=bc5f123404744699ad7f6a4d8e3197b3")
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "GET"
        
        return request
    }
}
