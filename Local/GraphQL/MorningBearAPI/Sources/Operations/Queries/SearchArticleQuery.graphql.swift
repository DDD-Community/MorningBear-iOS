// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SearchArticleQuery: GraphQLQuery {
  public static let operationName: String = "SearchArticle"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      """
      query SearchArticle($input: Int) {
        searchArticle(sizeInput: $input) {
          __typename
          title
          link
          description
          bloggername
          bloggerlink
          postdate
        }
      }
      """
    ))

  public var input: GraphQLNullable<Int>

  public init(input: GraphQLNullable<Int>) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: MorningBearAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { MorningBearAPI.Objects.Query }
    public static var __selections: [Selection] { [
      .field("searchArticle", [SearchArticle?]?.self, arguments: ["sizeInput": .variable("input")]),
    ] }

    ///  아티클 조회하기 
    public var searchArticle: [SearchArticle?]? { __data["searchArticle"] }

    /// SearchArticle
    ///
    /// Parent Type: `Article`
    public struct SearchArticle: MorningBearAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ParentType { MorningBearAPI.Objects.Article }
      public static var __selections: [Selection] { [
        .field("title", String?.self),
        .field("link", String?.self),
        .field("description", String?.self),
        .field("bloggername", String?.self),
        .field("bloggerlink", String?.self),
        .field("postdate", String?.self),
      ] }

      ///  제목 
      public var title: String? { __data["title"] }
      ///  게시글 링크 
      public var link: String? { __data["link"] }
      ///  설명 
      public var description: String? { __data["description"] }
      ///  블로그명 
      public var bloggername: String? { __data["bloggername"] }
      ///  블로그 링크 
      public var bloggerlink: String? { __data["bloggerlink"] }
      ///  포스팅 날짜 
      public var postdate: String? { __data["postdate"] }
    }
  }
}
