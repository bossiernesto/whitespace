require "test/unit"
require_relative "../lib/utils/utils"

class Test1
  include WS_debug_print,VarInitialize

  attr_accessor :name,:arg,:code
end

class ModuleTests < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    test1=Test1.new(:name=>"method",:arg=>"1,3,4",:code=>"something")
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_create_factory
    persona=Reflect::ClassFactory.create_class("Persona",["altura"],nil)
    persona.respond_to?(altura)
  end
end