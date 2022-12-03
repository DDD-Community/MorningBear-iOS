// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import StarWarsAPI

public class Film: MockObject {
  public static let objectType: Object = StarWarsAPI.Objects.Film
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Film>>

  public struct MockFields {
    @Field<String>("title") public var title
  }
}

public extension Mock where O == Film {
  convenience init(
    title: String? = nil
  ) {
    self.init()
    self.title = title
  }
}
