require './monad'

class Array
  include Monad

  def self.unit(x)
    [x]
  end
end

# 用Array Monad实现全排列
# permute([1, 2, 3]) # => [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
# def permute(nums)
#   if nums == []
#     [[]]
#   else
#     Array.for {
#       let(:x) { nums }
#       let(:perm) { permute(nums.reject { |y| y == x }) }
#     }.yield { [x] + perm }
#   end
# end
