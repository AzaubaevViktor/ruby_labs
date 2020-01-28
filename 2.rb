require 'sourcify'


class BigArray
  attr_accessor :size
  attr_accessor :content
  attr_accessor :thread_count

  def initialize(size = 0, thread_count = 3)
    @size = size
    @content = Array.new(size)
    @thread_count = thread_count
  end

  def push(value)
    @content.push(value)
    @size += 1
  end

  def map(&block)
    split_content(block).map do |t|
      t.join
      t[:results]
    end.flatten
  end

  def any?(&block)
    threads = split_content(block)
    
    threads.cycle {
        |thread|
      print thread, ': ', thread.status, "\n"
      if thread.status != 'run'
        thread.join
        print "#{thread[:results]}", "\n"
        # this for any, for all the same
        if thread[:results].any?
          print "WE FOUND IT, KILL ALL\n"
          threads.map {
              |th|
            print "Kill #{th}\n"
            th.kill
          }
          threads.clear
          return true
        else
          threads.delete(thread)
        end
      end
    }
    
    false
  end

  def all?(&block)
    threads = split_content(block)

    threads.cycle {
        |thread|
      print thread, ': ', thread.status, "\n"
      if thread.status != 'run'
        thread.join
        print "#{thread[:results]}", "\n"
        # this for any, for all the same
        if !thread[:results].all?
          print "WE FOUND IT, KILL ALL\n"
          threads.map {
              |th|
            print "Kill #{th}\n"
            th.kill
          }
          threads.clear
          return false
        else
          threads.delete(thread)
        end
      end
    }

    true
  end

  def select(&block)
    split_content(block).map do |t|
      t.join
      items = Hash[t[:values].zip t[:results]]
      t[:values].select { |item| items[item] }
    end.flatten
  end

  def to_s
    'BigArray aka ' + @content.to_s
  end

  private

  def split_content(block)
    @content.each_slice(@thread_count).map { |slice|
      Thread.new {
        Thread.current[:values] = slice
        Thread.current[:results] = slice.map { |item| block.call item }
      }
    }
  end
end


class Array
  def test_it_man(range, &block)
    results = []

    puts "...::::````` Start testing for  `````::::..."
    puts ": BLOCK:"
    puts ": #{block.to_source(:strip_enclosure => true)}"

    each { |cl|
      puts ".~~~~ test for: #{cl}  ~~~~"
      puts ': ready...'
      a = cl.new
      puts ': steady...'

      range.each { |x| a.push x }

      puts ": #{a}"

      puts ': GO!'
      start = Time.now
      results.push(block.call(a))
      tm = Time.now - start
      puts ": Finish by #{tm}"
    }

    puts "... Check results"

    raise "Size is 0" unless results.size != 0
    raise "Calculation error: #{results}" unless results.all? { |item| item == results[0] }

    puts "`````::::... NNICE ...::::`````"

  end
end


[BigArray, Array].test_it_man((1..27)) { |a|
  a.select { |x| sleep x / 15; x > 5 }
}


[BigArray, Array].test_it_man((1..27)) { |a|
  a.any? { |x| sleep x / 15; x % 19 == 0 }
}

[BigArray, Array].test_it_man((1..27)) { |a|
  a.all? { |x| sleep x / 15; x != 0 }
}

[BigArray, Array].test_it_man((1..27)) { |a|
  a.map { |x| sleep x / 15; x ** x ** 5 }
}

