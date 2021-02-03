import XCTest
@testable import NewsApp

final class ApiClientTests: XCTestCase {
    
    var apiClient:ApiClient!
    let urlSessionStub = URLSessionStub()
    
    // MARK: - Set up
    
    override func setUp() {
        super.setUp()
        apiClient = ApiClient(urlSession: urlSessionStub)
    }
    
    func test_execute_successful_httpresponse_parse_ok_utf8StringResponse() {
        
        let expectedUtf8StringResponse = "{\"Property\":\"Value\"}"
        let expectedData = expectedUtf8StringResponse.data(using: .utf8)
        let expected2xxResponse = HTTPURLResponse(statusCode: 200)
        
        urlSessionStub.addToQueue(response: (data: expectedData, response: expected2xxResponse, error: nil))
        
        let executeCompletionHandlerExpectation = expectation(description: "expectation")
        
        apiClient.execute(request: TestRequest()) { (result: Result<ApiParseResponse<TestApi>>) in
            guard let response = try? result.get() else {
                XCTFail("successfull response should've be returned, some thing went wrong with the test")
                return
            }
            XCTAssertEqual(expectedUtf8StringResponse, response.source.utf8String, "The string is the expected one")
            
            executeCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_execute_successful_httpresponse_parse_ok_shouldgive_expectedData() {
        
        let expectedUtf8StringResponse = "{\"Property\":\"Value\"}"
        let expectedData = expectedUtf8StringResponse.data(using: .utf8)
        let expected2xxResponse = HTTPURLResponse(statusCode: 200)
        
        urlSessionStub.addToQueue(response: (data: expectedData, response: expected2xxResponse, error: nil))
        
        let executeCompletionHandlerExpectation = expectation(description: "expectation")
        
        apiClient.execute(request: TestRequest()) { (result: Result<ApiParseResponse<TestApi>>) in
            guard let response = try? result.get() else {
                XCTFail("successfull response should've be returned, some thing went wrong with the test")
                return
            }
            XCTAssertEqual(expectedData?.base64EncodedString(), response.data?.base64EncodedString(), "Data match")
            
            executeCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    
    func test_execute_successful_httpresponse_parse_ok_shouldgive_200Response() {
        
        let expectedUtf8StringResponse = "{\"Property\":\"Value\"}"
        let expectedData = expectedUtf8StringResponse.data(using: .utf8)
        let expected2xxResponse = HTTPURLResponse(statusCode: 200)
        
        urlSessionStub.addToQueue(response: (data: expectedData, response: expected2xxResponse, error: nil))
        
        let executeCompletionHandlerExpectation = expectation(description: "expectation")
        
        apiClient.execute(request: TestRequest()) { (result: Result<ApiParseResponse<TestApi>>) in
            guard let response = try? result.get() else {
                XCTFail("successfull response should've be returned, some thing went wrong with the test")
                return
            }
            XCTAssertTrue(expected2xxResponse == response.httpUrlResponse, "The http response is the expected one")
            
            executeCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_should_return_non_2xx_response_code() {
        let expectedUtf8StringResponse = "{ \"SomeProperty\" : \"SomeValue\" }"
        let expectedData = expectedUtf8StringResponse.data(using: .utf8)
        let expected4xxReponse = HTTPURLResponse(statusCode: 400)
        
        urlSessionStub.addToQueue(response: (data: expectedData, response: expected4xxReponse, error: nil))
        
        let executeCompletionHandlerExpectation = expectation(description: "expectation")
        
        apiClient.execute(request: TestRequest()) { (result: Result<ApiParseResponse<TestApi>>) in
            do {
                let _ = try result.get()
                XCTFail("Expected api error thrown")
            } catch let error as ApiError {
                XCTAssertTrue(expected4xxReponse === error.httpUrlResponse, "The http response is the expected one")
            } catch {
                XCTFail("Expected api error thrown")
            }
            
            executeCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_should_return_expected_encodedString() {
        let expectedUtf8StringResponse = "{ \"SomeProperty\" : \"SomeValue\" }"
        let expectedData = expectedUtf8StringResponse.data(using: .utf8)
        let expected4xxReponse = HTTPURLResponse(statusCode: 401)
        
        urlSessionStub.addToQueue(response: (data: expectedData, response: expected4xxReponse, error: nil))
        
        let executeCompletionHandlerExpectation = expectation(description: "expectation")
        
        apiClient.execute(request: TestRequest()) { (result: Result<ApiParseResponse<TestApi>>) in
            do {
                let _ = try result.get()
                XCTFail("Expected api error thrown")
            } catch let error as ApiError {
                XCTAssertEqual(expectedData?.base64EncodedString(), error.data?.base64EncodedString(), "Data match")
            } catch {
                XCTFail("Expected api error to be thrown")
            }
            
            executeCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_httpurlresponse_when_responseAndData_nil() {
        
        let expectedErrorMessage = "Some random network error"
        let expectedError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: expectedErrorMessage])
        
        urlSessionStub.addToQueue(response: (data: nil, response: nil, error: expectedError))
        
        let executeCompletionHandlerExpectation = expectation(description: "expectation")
        
        apiClient.execute(request: TestRequest()) { (result: Result<ApiParseResponse<TestApi>>) in
            do {
                let _ = try result.get()
                XCTFail("Expected network error to be thrown")
            } catch let error as NetworkRequestError {
                XCTAssertEqual(expectedErrorMessage, error.localizedDescription, "Error message match")
            } catch {
                XCTFail("Expected network error to be thrown")
            }
            
            executeCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}

private struct TestRequest: ApiRequest {
    var urlRequest: URLRequest {
        return URLRequest(url: URL.googleUrl)
    }
}

private struct TestApi: Codable {
    var Property: String
    
    var utf8String: String {
        let data = try? JSONEncoder().encode(self)
        return String(data: data!, encoding: .utf8)!
    }
}
