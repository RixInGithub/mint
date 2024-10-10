module Mint
  class TestRunner
    class Message
      include JSON::Serializable

      property location : Ast::Node::Location?
      property result : String?
      property suite : String?
      property name : String?
      property type : String
    end
  end
end
