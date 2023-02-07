// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class MyInfoForHomeQuery: GraphQLQuery {
  public static let operationName: String = "MyInfoForHome"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      """
      query MyInfoForHome {
        findMyInfo {
          __typename
          reportInfo {
            __typename
            totalTime
            countSucc
          }
          badgeList {
            __typename
            badgeId
          }
        }
      }
      """
    ))

  public init() {}

  public struct Data: MorningBearAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { MorningBearAPI.Objects.Query }
    public static var __selections: [Selection] { [
      .field("findMyInfo", FindMyInfo?.self),
    ] }

    ///  내정보 조회 (뱃지이벤트 발생) 
    public var findMyInfo: FindMyInfo? { __data["findMyInfo"] }

    /// FindMyInfo
    ///
    /// Parent Type: `User`
    public struct FindMyInfo: MorningBearAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ParentType { MorningBearAPI.Objects.User }
      public static var __selections: [Selection] { [
        .field("reportInfo", ReportInfo?.self),
        .field("badgeList", [BadgeList?]?.self),
      ] }

      ///  리포트정보 
      public var reportInfo: ReportInfo? { __data["reportInfo"] }
      ///  획득 뱃지 리스트 
      public var badgeList: [BadgeList?]? { __data["badgeList"] }

      /// FindMyInfo.ReportInfo
      ///
      /// Parent Type: `Report`
      public struct ReportInfo: MorningBearAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ParentType { MorningBearAPI.Objects.Report }
        public static var __selections: [Selection] { [
          .field("totalTime", Int?.self),
          .field("countSucc", Int?.self),
        ] }

        ///  전체 누적시간(분 단위) 
        public var totalTime: Int? { __data["totalTime"] }
        ///  성공횟수 
        public var countSucc: Int? { __data["countSucc"] }
      }

      /// FindMyInfo.BadgeList
      ///
      /// Parent Type: `BadgeDetail`
      public struct BadgeList: MorningBearAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ParentType { MorningBearAPI.Objects.BadgeDetail }
        public static var __selections: [Selection] { [
          .field("badgeId", String?.self),
        ] }

        ///  뱃지 ID 
        public var badgeId: String? { __data["badgeId"] }
      }
    }
  }
}
