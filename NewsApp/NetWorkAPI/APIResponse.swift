import Foundation

struct NetworkRequestError: Error {
    let error: Error?
    
    var localizedDescription: String {
        return error?.localizedDescription ?? "Network error"
    }
}

struct ApiError: Error {
    let data: Data?
    let httpUrlResponse: HTTPURLResponse
}

struct ApiParseError: Error {
    
    let error: Error
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    var description: String {
        return error.localizedDescription
    }
}

struct ApiParseResponse<T: Decodable> {
    let source: T
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse) throws {
        do {
            self.source = try JSONDecoder().decode(T.self, from: data ?? Data())
            self.httpUrlResponse = httpUrlResponse
            self.data = data
        } catch {
            throw ApiParseError(error: error, httpUrlResponse: httpUrlResponse, data: data)
        }
    }
}
