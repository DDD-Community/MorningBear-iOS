// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MorningBearAPI

public class Badge: MockObject {
  public static let objectType: Object = MorningBearAPI.Objects.Badge
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Badge>>

  public struct MockFields {
    @Field<String>("badgeDesc") public var badgeDesc
    @Field<String>("badgeId") public var badgeId
    @Field<String>("badgeTitle") public var badgeTitle
  }
}

public extension Mock where O == Badge {
  convenience init(
    badgeDesc: String? = nil,
    badgeId: String? = nil,
    badgeTitle: String? = nil
  ) {
    self.init()
    self.badgeDesc = badgeDesc
    self.badgeId = badgeId
    self.badgeTitle = badgeTitle
  }
}
