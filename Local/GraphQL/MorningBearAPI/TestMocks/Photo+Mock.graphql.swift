// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MorningBearAPI

public class Photo: MockObject {
  public static let objectType: Object = MorningBearAPI.Objects.Photo
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Photo>>

  public struct MockFields {
    @Field<String>("photoDesc") public var photoDesc
    @Field<String>("photoId") public var photoId
    @Field<String>("photoLink") public var photoLink
    @Field<[Badge?]>("updatedBadge") public var updatedBadge
  }
}

public extension Mock where O == Photo {
  convenience init(
    photoDesc: String? = nil,
    photoId: String? = nil,
    photoLink: String? = nil,
    updatedBadge: [Mock<Badge>?]? = nil
  ) {
    self.init()
    self.photoDesc = photoDesc
    self.photoId = photoId
    self.photoLink = photoLink
    self.updatedBadge = updatedBadge
  }
}
