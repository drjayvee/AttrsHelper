# frozen_string_literal: true

module Foo
  class Good
    def self.attrs(*attrs)
      attr_reader(*attrs) # not necessary to reproduce the bug

      define_method :initialize do |*args|
        puts "Base:initialize(#{args.inspect})"
        attrs.each_with_index { |attr, i| instance_variable_set "@#{attr}", args[i] }
      end
    end

    attrs :a
  end

  module AttrsHelper
    def attrs(*attrs)
      attr_reader(*attrs)

      define_method :initialize do |*args|
        puts "Pase:initialize(#{args.inspect})"
        attrs.each_with_index { |attr, i| instance_variable_set "@#{attr}", args[i] }
      end
    end
  end

  class Bad
    extend AttrsHelper

    attrs :a
  end
end

Foo::Good.new 'a'
Foo::Bad.new 'a'
