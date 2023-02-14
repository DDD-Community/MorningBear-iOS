// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MorningBearAPI

public class Category: MockObject {
  public static let objectType: Object = MorningBearAPI.Objects.Category
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Category>>

  public struct MockFields {
    @Field<String>("categoryDesc") public var categoryDesc
    @Field<String>("categoryId") public var categoryId
  }
}

public extension Mock where O == Category {
  convenience init(
    categoryDesc: String? = nil,
    categoryId: String? = nil
  ) {
    self.init()
    self.categoryDesc = categoryDesc
    self.categoryId = categoryId
  }
}
