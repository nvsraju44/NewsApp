import Foundation

struct Article: Codable {
    let title: String?
    let description: String?
}
struct NewsList: Codable {
    let articles: [Article]
}
