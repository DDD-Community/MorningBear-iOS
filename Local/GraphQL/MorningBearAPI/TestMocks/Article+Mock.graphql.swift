// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MorningBearAPI

public class Article: MockObject {
  public static let objectType: Object = MorningBearAPI.Objects.Article
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Article>>

  public struct MockFields {
    @Field<String>("bloggerlink") public var bloggerlink
    @Field<String>("description") public var description
    @Field<String>("link") public var link
    @Field<String>("title") public var title
  }
}

public extension Mock where O == Article {
  convenience init(
    bloggerlink: String? = nil,
    description: String? = nil,
    link: String? = nil,
    title: String? = nil
  ) {
    self.init()
    self.bloggerlink = bloggerlink
    self.description = description
    self.link = link
    self.title = title
  }
}
