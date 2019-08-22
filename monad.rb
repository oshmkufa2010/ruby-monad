require './for_syntax/statements_parser'
require './for_syntax/syntax'

module Monad
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def for(&for_proc)
      statements = ForSyntax::StatementsParser.new.parse(for_proc)
      ForSyntax::Syntax.new(self, statements)
    end
  end
end
