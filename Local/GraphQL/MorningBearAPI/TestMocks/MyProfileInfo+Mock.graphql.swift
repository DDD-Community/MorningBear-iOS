// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MorningBearAPI

public class MyProfileInfo: MockObject {
  public static let objectType: Object = MorningBearAPI.Objects.MyProfileInfo
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<MyProfileInfo>>

  public struct MockFields {
    @Field<String>("accountId") public var accountId
    @Field<String>("memo") public var memo
    @Field<String>("nickName") public var nickName
    @Field<String>("photoLink") public var photoLink
    @Field<String>("wakeUpAt") public var wakeUpAt
  }
}

public extension Mock where O == MyProfileInfo {
  convenience init(
    accountId: String? = nil,
    memo: String? = nil,
    nickName: String? = nil,
    photoLink: String? = nil,
    wakeUpAt: String? = nil
  ) {
    self.init()
    self.accountId = accountId
    self.memo = memo
    self.nickName = nickName
    self.photoLink = photoLink
    self.wakeUpAt = wakeUpAt
  }
}
