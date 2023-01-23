// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MorningBearAPI

public class Query: MockObject {
  public static let objectType: Object = MorningBearAPI.Objects.Query
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Query>>

  public struct MockFields {
    @Field<String>("encode") public var encode
    @Field<[Login?]>("findLoginInfo") public var findLoginInfo
    @Field<User>("findMyInfo") public var findMyInfo
    @Field<[Article?]>("searchArticle") public var searchArticle
  }
}

public extension Mock where O == Query {
  convenience init(
    encode: String? = nil,
    findLoginInfo: [Mock<Login>?]? = nil,
    findMyInfo: Mock<User>? = nil,
    searchArticle: [Mock<Article>?]? = nil
  ) {
    self.init()
    self.encode = encode
    self.findLoginInfo = findLoginInfo
    self.findMyInfo = findMyInfo
    self.searchArticle = searchArticle
  }
}
