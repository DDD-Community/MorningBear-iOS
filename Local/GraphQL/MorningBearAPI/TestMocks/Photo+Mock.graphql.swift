// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MorningBearAPI

public class Photo: MockObject {
  public static let objectType: Object = MorningBearAPI.Objects.Photo
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Photo>>

  public struct MockFields {
    @Field<String>("accountId") public var accountId
    @Field<String>("categoryId") public var categoryId
    @Field<String>("createdAt") public var createdAt
    @Field<String>("endAt") public var endAt
    @Field<String>("photoDesc") public var photoDesc
    @Field<String>("photoId") public var photoId
    @Field<String>("photoLink") public var photoLink
    @Field<String>("startAt") public var startAt
    @Field<String>("updatedAt") public var updatedAt
    @Field<[Badge?]>("updatedBadge") public var updatedBadge
  }
}

public extension Mock where O == Photo {
  convenience init(
    accountId: String? = nil,
    categoryId: String? = nil,
    createdAt: String? = nil,
    endAt: String? = nil,
    photoDesc: String? = nil,
    photoId: String? = nil,
    photoLink: String? = nil,
    startAt: String? = nil,
    updatedAt: String? = nil,
    updatedBadge: [Mock<Badge>?]? = nil
  ) {
    self.init()
    self.accountId = accountId
    self.categoryId = categoryId
    self.createdAt = createdAt
    self.endAt = endAt
    self.photoDesc = photoDesc
    self.photoId = photoId
    self.photoLink = photoLink
    self.startAt = startAt
    self.updatedAt = updatedAt
    self.updatedBadge = updatedBadge
  }
}
