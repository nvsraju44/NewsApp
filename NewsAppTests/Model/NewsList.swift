import Foundation

@testable import NewsApp

extension NewsList {
    static func createNewsArray(numberOfElements: Int = 2) -> [Article] {
        var articles = [Article]()
        
        for i in 0..<numberOfElements {
            let article = createArticle(index: i)
            articles.append(article)
        }
        
        return articles
    }
    
    static func createArticle(index: Int = 0) -> Article {
        
        return Article(title: "title \(index)", description: "description \(index)")

    }
}
