// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MorningBearAPI

public class Report: MockObject {
  public static let objectType: Object = MorningBearAPI.Objects.Report
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Report>>

  public struct MockFields {
    @Field<Int>("countSucc") public var countSucc
    @Field<Int>("totalTime") public var totalTime
  }
}

public extension Mock where O == Report {
  convenience init(
    countSucc: Int? = nil,
    totalTime: Int? = nil
  ) {
    self.init()
    self.countSucc = countSucc
    self.totalTime = totalTime
  }
}
