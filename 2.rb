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
    @content.each_slice(@thread_count).map { |slice|
      Thread.new {
        Thread.current[:results] = slice.map { |item| block.call item}
      }
    }.map do |t|
      t.join
      t[:results]
    end.flatten
  end

  def to_s
    "BigArray aka " + @content.to_s
  end
end


[BigArray, Array].each { |cl|
  p " ~~~~ MAP for: " + cl.to_s + " ~~~~"
  p "ready..."
  a = cl.new
  p "steady..."

  (1..27).each {|x| a.push x}

  puts a

  p "GO!"
  start = Time.now
  a.map {|x| sleep x / 10; x ** x ** 5}
  tm = Time.now - start
  p "Finish"
  p tm
}