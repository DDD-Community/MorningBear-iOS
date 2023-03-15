// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MorningBearAPI

public class User: MockObject {
  public static let objectType: Object = MorningBearAPI.Objects.User
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<User>>

  public struct MockFields {
    @Field<[BadgeDetail?]>("badgeList") public var badgeList
    @Field<[Category?]>("categoryList") public var categoryList
    @Field<String>("goal") public var goal
    @Field<String>("memo") public var memo
    @Field<String>("nickName") public var nickName
    @Field<[Photo?]>("photoInfo") public var photoInfo
    @Field<[PhotoByCategory?]>("photoInfoByCategory") public var photoInfoByCategory
    @Field<String>("photoLink") public var photoLink
    @Field<Report>("reportInfo") public var reportInfo
    @Field<Int>("takenLikeCnt") public var takenLikeCnt
    @Field<String>("wakeUpAt") public var wakeUpAt
  }
}

public extension Mock where O == User {
  convenience init(
    badgeList: [Mock<BadgeDetail>?]? = nil,
    categoryList: [Mock<Category>?]? = nil,
    goal: String? = nil,
    memo: String? = nil,
    nickName: String? = nil,
    photoInfo: [Mock<Photo>?]? = nil,
    photoInfoByCategory: [Mock<PhotoByCategory>?]? = nil,
    photoLink: String? = nil,
    reportInfo: Mock<Report>? = nil,
    takenLikeCnt: Int? = nil,
    wakeUpAt: String? = nil
  ) {
    self.init()
    self.badgeList = badgeList
    self.categoryList = categoryList
    self.goal = goal
    self.memo = memo
    self.nickName = nickName
    self.photoInfo = photoInfo
    self.photoInfoByCategory = photoInfoByCategory
    self.photoLink = photoLink
    self.reportInfo = reportInfo
    self.takenLikeCnt = takenLikeCnt
    self.wakeUpAt = wakeUpAt
  }
}
