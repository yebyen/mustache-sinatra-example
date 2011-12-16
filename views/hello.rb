class App
  module Views
    class Hello < Mustache
      @@have=nil
      def self.have(got)
        @@have=got
      end
      def rows
        [{ :key => "foo", :value => 1 },
         { :key => "bar", :value => 2 },
         { :key => "baz", :value => 3 }]
      end
      def have
        !@@have.nil?
      end
      def got
        @@have
      end
    end
  end
end
