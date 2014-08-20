module Byebug
  #
  # Show methods of specific classes/modules/objects.
  #
  class MethodCommand < Command
    include Columnize

    def regexp
      /^\s* m(?:ethod)? \s+ (i(:?nstance)?\s+)?/x
    end

    def execute
      obj = bb_eval(@match.post_match)
      if @match[1]
        print "#{columnize(obj.methods.sort, Setting[:width])}\n"
      elsif !obj.is_a?(Module)
        print "Should be Class/Module: #{@match.post_match}\n"
      else
        print "#{columnize(obj.instance_methods(false).sort, Setting[:width])}\n"
      end
    end

    class << self
      def names
        %w(method)
      end

      def description
        %{m[ethod] (i[nstance][ <obj>]|<class|module>)

          When invoked with "instance", shows instance methods of the object
          specified as argument or of self no object was specified.

          When invoked only with a class or module, shows class methods of the
          class or module specified as argument.}
      end
    end
  end
end
