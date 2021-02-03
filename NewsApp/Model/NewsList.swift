import Foundation

struct Article: Codable {
    let title: String?
    let description: String?
}
struct NewsList: Codable {
    let articles: [Article]
}

extension NewsList: Equatable {
    static func == (lhs: NewsList, rhs: NewsList) -> Bool {
      return lhs.articles == rhs.articles
    }
}

extension Article: Equatable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.title == rhs.title && lhs.description == rhs.description
    }
}

