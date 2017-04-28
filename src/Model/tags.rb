class Marray < Array
  def [](i)
    super.nil? ? self[i] = Marray.new : super
  end
end

class Tag

  def initialize
    @list = ['added', 'fixed', 'removed', 'improved']
    @change = Marray.new(@list.count)
  end

  def add (type, change)
    @change[@list.index(type)][@change[@list.index(type)].count] = change
  end

  def get
    @change
  end

end
