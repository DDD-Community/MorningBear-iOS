// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == MorningBearAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == MorningBearAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == MorningBearAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == MorningBearAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> Object? {
    switch typename {
    case "Query": return MorningBearAPI.Objects.Query
    case "User": return MorningBearAPI.Objects.User
    case "Report": return MorningBearAPI.Objects.Report
    case "Login": return MorningBearAPI.Objects.Login
    case "Mutation": return MorningBearAPI.Objects.Mutation
    case "Photo": return MorningBearAPI.Objects.Photo
    case "Badge": return MorningBearAPI.Objects.Badge
    case "Article": return MorningBearAPI.Objects.Article
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
