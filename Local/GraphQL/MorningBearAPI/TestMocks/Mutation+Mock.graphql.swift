// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MorningBearAPI

public class Mutation: MockObject {
  public static let objectType: Object = MorningBearAPI.Objects.Mutation
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Mutation>>

  public struct MockFields {
    @Field<MyProfileInfo>("saveMyInfo") public var saveMyInfo
  }
}

public extension Mock where O == Mutation {
  convenience init(
    saveMyInfo: Mock<MyProfileInfo>? = nil
  ) {
    self.init()
    self.saveMyInfo = saveMyInfo
  }
}
