## 在Ruby里模拟Scala的for comprehension

Haskell的do-notation是个好东西，类似于JavaScript的async-await语法，可以帮助我们从`>>=`运算符的层层嵌套中解脱出来，其实质是编译器帮助我们做了一次CPS变换

In Haskell
```Haskell
f :: Monad m => m a
f = do
  x1 <- m1
  x2 <- m2
  ...
  return xn
```

Scala的for-comprehension也是类似的：
```Scala
val f[M[_]: Monad, A]: M[A] = for {
  x1 <- m1
  x2 <- m2
  ...
} yield xn
```

但如果是Ruby呢?

对不起，Ruby没有

为此我模仿Scala的for-comprehension给Ruby订制了一套DSL，与Scala的Monad一样，只需给需要成为Monad的类定义一个`unit`类方法和`flat_map`实例方法即可，比如我们要将Ruby内置类型`Array`变成一个Monad，只需
```Ruby
class Array
  include Monad

  def self.unit(x)
    [x]
  end
end
```
因为`Array`已经实现了`flat_map`，所以只需实现`unit`
效果如下：
```Ruby
Array.for {
  let(:x) { [1, 2, 3] }
  let(:y) { (0..x).to_a }
}.yield { x + y } # => [1, 2, 2, 3, 4, 3, 4, 5, 6]
```

`let`函数实在是丑陋，所以我又实现了以下语法：
```Ruby
Array.for {
  x <= proc { [1, 2, 3] }
  y <= proc { (0..x).to_a }
}.yield { x + y }
```
