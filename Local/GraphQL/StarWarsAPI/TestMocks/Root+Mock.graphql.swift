// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import StarWarsAPI

public class Root: MockObject {
  public static let objectType: Object = StarWarsAPI.Objects.Root
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Root>>

  public struct MockFields {
    @Field<FilmsConnection>("allFilms") public var allFilms
  }
}

public extension Mock where O == Root {
  convenience init(
    allFilms: Mock<FilmsConnection>? = nil
  ) {
    self.init()
    self.allFilms = allFilms
  }
}
