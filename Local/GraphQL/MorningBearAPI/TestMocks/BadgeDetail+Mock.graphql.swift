// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MorningBearAPI

public class BadgeDetail: MockObject {
  public static let objectType: Object = MorningBearAPI.Objects.BadgeDetail
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<BadgeDetail>>

  public struct MockFields {
    @Field<String>("badgeId") public var badgeId
  }
}

public extension Mock where O == BadgeDetail {
  convenience init(
    badgeId: String? = nil
  ) {
    self.init()
    self.badgeId = badgeId
  }
}
