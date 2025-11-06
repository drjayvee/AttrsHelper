# frozen_string_literal: true

module Foo
  class Base
    def self.attrs(*attrs)
      attr_reader(*attrs)

      define_method :initialize do |*args|
        puts "Base:initialize(#{args.inspect})"
        attrs.each_with_index { |attr, i| instance_variable_set "@#{attr}", args[i] }
      end
    end

    class Sub < Base
      attrs :a
    end
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

  class Pase
    extend AttrsHelper

    class Sup < Pase
      attrs :a
    end
  end
end

Foo::Base::Sub.new 'a'
Foo::Pase::Sup.new 'a'
