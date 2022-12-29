// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MorningBearAPI

public class Query: MockObject {
  public static let objectType: Object = MorningBearAPI.Objects.Query
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Query>>

  public struct MockFields {
    @Field<[Badge?]>("findAllBadge") public var findAllBadge
    @Field<[Login?]>("findLoginInfo") public var findLoginInfo
  }
}

public extension Mock where O == Query {
  convenience init(
    findAllBadge: [Mock<Badge>?]? = nil,
    findLoginInfo: [Mock<Login>?]? = nil
  ) {
    self.init()
    self.findAllBadge = findAllBadge
    self.findLoginInfo = findLoginInfo
  }
}
