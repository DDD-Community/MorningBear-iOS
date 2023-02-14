// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MorningBearAPI

public class PhotoByCategory: MockObject {
  public static let objectType: Object = MorningBearAPI.Objects.PhotoByCategory
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<PhotoByCategory>>

  public struct MockFields {
    @Field<[Photo?]>("photoInfo") public var photoInfo
  }
}

public extension Mock where O == PhotoByCategory {
  convenience init(
    photoInfo: [Mock<Photo>?]? = nil
  ) {
    self.init()
    self.photoInfo = photoInfo
  }
}
