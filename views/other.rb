require 'awesome_print'
#require 'pp'
#require 'stringio'

=begin
def my_pp(*args)
  old_out = $stdout
  begin
    s=StringIO.new
    $stdout=s
    pp(*args)
  ensure
    $stdout=old_out
  end
  s.string
end
=end

class App
  module Views
    class Other < Mustache
      def rows
        @db.query("select * from to_document limit 7")
      end
      def row_ai
        @db.query("select * from to_document limit 7").ai(:html=>true)
      end
      def ascii_art
        <<-end_art
....................
....................
.............:~I7777777777+.                     .,I7777777777I:.
.............778OOOOOOOOO88=                    ..IOOOOOOOOOOOO++
.............77OOOOOOOOOOOOO,,                  ~=8OOOOOOOOOOO8++
.............778OOOOOOOOOOOOII..               .ZZOOOOOOOOOOOOO++
.............77OOOOOOOOOOOOOO8$.             .:O8OOOOOOOOOOOOO8++
            .77OOOOOOOOOOOOO88O+.           ..788OOOOOOOOOOOOO8++.......
            .778OOOOOOOOOOOOOO8O,           .=OOOOOOOOOOOOOOOO8++.......
            .77OOOOOOOOOOOOOOOOO7.         .,ZOOOOOOOOOOOOOOOOO++.......
            .77OOOOOOOOOOOOOOOOOOZ$..     :OZOOOOOOOOOOOOOOOOOO++.......
            .778OOOOOOOOOOOOOOOOOOO?.... .$OOOOOOOOOOOOOOOOOOOO++.......
            .77OOOOOOOOOOOOOOOOOOOOO: ...=O8OOOOOOOOOOOOOOOOOO8++.......
            .77OOOOOOOO8OOOOOOOOOOOO$...,OOOOOOOOOOO8OOOOOOOOO8++.......
            .778OOOOOOO8OO:OOOOOOOOOOO==OOOOOOOOOOZ:OOOOOOOOOO8++.......
            .778OOOOOOOOO8.IOOOOOOOO8O8OOOOOOOOOOO=:O8OOOOOOOO8++.......
            .778OOOOOOOOO8.:OOSomething MagicalO$$.:OOOOOOOOOOO++.......
            .77OOOOOOOOOO8..??OOOOOHappeningOOOO~:.:OOOOOOOOOO8++.......
            .77OOOOOOOOOO8....+OOOOOOHereOOOOOO:...:OOOOOOOOOO8++.......
            .77OOOOOOOOOO8.....OOOOOOOOOOOOOOOI....:O8OOOOOOOOO++.......
            .778OOOOOOOOO8.....=OOOOOOOOOOOOOO:.   :OOOOOOOOOO8++
            .77OOOOOOOOOO8......$88OOOOOOOOO8I     :O8OOOOOOOO8++
            .778OOOOOOOOO8.......$$OOOOOOOO??.     :OOOOOOOOOOO++
            .77OOOOOOOOOO8...... ~:OOOOOOOO,,      :OOOOOOOOOOO++
            .77O8OOOOOOOO8.........7O8OOOO+.       :OOOOOOOOOO8++
            .~~7777777777+.........,77777I. ....   .?7777777777:,
                . . ......=$OOOOOOO$=....~?7$$$$77+, ..     .
                    ....,7OOOOOOOOO8O=..=OOO88O88OOZ:...
                    ..:ZZOOOOOOOOOOOOZ,,OOOOOOOOOOO8O=+.
                  ...=8OOOOOOOOOOOOOOO++OOOOOOOOOOOOOOOI,..
                .,$$8OOOOOOOOOOOOOOOOO$$OOOOOOOOOOOOOOOO8O==
              ..~O8OOOOOOOOOOOOOOOOO8O$$OOOOOOOOOOOOOOOOOOOO?..
            ...?OOOOOOOOOOOOOOOOOOOOOO++OOOOOOOOOOOOOOOOOOOOO$,..
         ...,$$OOOOOOOOOOOOOOOOOOOO887:,OOOOOOOOOOOOOOOOOOOOOOO~=..
  :77III7$O8O8OOOOOOOOOOOOOOOOOOOO87,....+8OOOOOOOOOOOOOOOOOOOOOO8OI======+.
  .$$8OOOOOOOOOOOOOOOOOOOOOOOO8OO++..... .~ZZOOOOOOOOOOOOOOOOOOOOOOOOOOOO$7.
   ,,$8OOOOOOOOOOOOOOOOOO8O888O$: ......   ,,I8888OOOOOOOOOOOOOOOOOO88O8$,,
     .=$OOOOOOOOO8OOOO8O88OZ7I~.........    ..~IOZOO8OOOOOOOOO8O88O8O8O?.
            ...,,,,,....................             ..,~======~~,.
                    ....................
end_art
      end
    end
  end
end
