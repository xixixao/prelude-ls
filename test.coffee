prelude = require './prelude.js'
prelude.installPrelude global

describe "In prelude", ->

  describe "each", ->

    it "works on empty array", ->
      expect(each [], ->).toEqual []

    it "changes given array", ->
      expect(each [[1, 5], [2, 6]], (l) -> l.pop()).toEqual [[1], [2]]

    it "iterates over strings", ->
      testTarget = 0
      expect(each 'hello', -> ++testTarget).toEqual 'hello'
      expect(testTarget).toEqual 5
      expect(each '', ->).toEqual ''

    it "iterates over objects", ->
      count = 4
      each {a: 1, b: 2, c: 3}, (n) -> count += n
      expect(count).toEqual 10

  describe "map", ->

    it "works on arrays", ->
      expect(map [], ->).toEqual []
      expect(map [1, 2, 3], plus 1).toEqual [2, 3, 4]

    it "works on strings", ->
      expect(map 'abc', (ch) -> ch.toUpperCase()).toEqual 'ABC'

    it "works on objects", ->
      obj = map {a:1, b:2}, (times 2)
      expect(obj.a).toEqual 2
      expect(obj.b).toEqual 4

    it "works with an object mapping", ->
      expect(map ["one", "two", "three", "four"], toMap one: 1, two: 2, three: 3, four: 4).toEqual [1, 2, 3, 4]

    it "works with an array mapping", ->
      switches = map {power: 1, light: 0}, toMap ['off', 'on']
      expect(switches.power).toEqual 'on'
      expect(switches.light).toEqual 'off'

  fromAtoC = (x) -> 'a' <= x <= 'c'

  describe "filter ", ->

    it "works on arrays", ->
      expect(filter [], id).toEqual []
      expect(filter [1..5], even).toEqual [2, 4]

    it "works on strings", ->
      expect(filter 'abcdefcf', fromAtoC).toEqual 'abcc'

    it "works on objects", ->
      obj = filter {a:1, b:2}, equals 2
      expect(obj.b).toEqual 2
      expect(obj.a?).toBe false

  describe "reject", ->

    it "works on arrays", ->
      expect(reject [1..5], even).toEqual [1, 3, 5]

    it "works on strings", ->
      expect(reject 'abcdefcf', fromAtoC).toEqual 'deff'

    it "works on objects", ->
      obj = reject {a:1, b:2}, equals 2
      expect(obj.a).toEqual 1
      expect(obj.b?).toBe false

  describe "partition", ->

    it "works on arrays", ->
      [passed, failed] = partition [49, 58, 76, 43, 88, 77, 90], (x) -> x > 60
      expect(passed).toEqual [76, 88, 77, 90]
      expect(failed).toEqual [49, 58, 43]

    it "works on objects", ->
      [isTwo, notTwo] = partition {a:1, b:2, c:3}, equals 2
      expect( isTwo.b).toEqual 2
      expect(notTwo.a).toEqual 1
      expect(notTwo.c).toEqual 3
      expect(notTwo.b?).toBe false
      expect( isTwo.a?).toBe false
      expect( isTwo.c?).toBe false

    it "works on strings", ->
      expect(partition 'abcdefcf', fromAtoC).toEqual ['abcc', 'deff']

  describe "find", ->

    it "works on arrays", ->
      expect(find [3, 1, 4, 8, 6], even).toEqual 4
      expect(find [3, 1], even).toBe undefined

    it "works on strings", ->
      expect(find 'abs', equals 'b').toEqual 'b'
      expect(find 'abs', equals 'c').toBe undefined

    it "works on objects", ->
      expect(find {a:1, b:2}, equals 2).toEqual 2
      expect(find {a:1, b:2}, equals 3).toBe undefined

  describe "pluck", ->

    it "works on arrays", ->
      expect(pluck 'num', [num: 'one'; num: 'two'] ).toEqual ['one', 'two']

    it "works on objects", ->
      plucked = pluck 'num', a: {num: 1}, b: {num: 2}
      expect(plucked.a).toEqual 1
      expect(plucked.b).toEqual 2

  list = [1, 2, 3, 4, 5]
  string = 'abcde'

  describe "head", ->

    it "works on arrays", ->
      expect(head list).toEqual 1
      expect((head [])?).toBe false

    it "works on strings", ->
      expect(head string).toEqual 'a'
      expect((head '')?).toBe false

  describe "tail", ->

    it "works on arrays", ->
      expect(tail list).toEqual [2, 3, 4, 5]
      expect((tail [])?).toBe false

    it "works on strings", ->
      expect(tail string).toEqual 'bcde'
      expect((tail '')?).toBe false

  describe "last", ->

    it "works on arrays", ->
      expect(last list).toEqual 5
      expect((last [])?).toBe false

    it "works on strings", ->
      expect(last string).toEqual 'e'
      expect((last '')?).toBe false

  describe "initial", ->

    it "works on arrays", ->
      expect(initial list).toEqual [1, 2, 3, 4]
      expect((initial [])?).toBe false

    it "works on strings", ->
      expect(initial string).toEqual 'abcd'
      expect((initial '')?).toBe false

  describe "empty", ->

    it "works on arrays", ->
      expect(empty []).toBe true
      expect(empty [1]).toBe false

    it "works on objects", ->
      expect(empty {}).toBe true
      expect(empty x: 1).toBe false

    it "works on strings", ->
      expect(empty '').toBe true
      expect(empty '1').toBe false

  describe "values", ->

    it "works", ->
      expect(values sadf: 1, asdf: 2, fdas: 3).toEqual [1, 2, 3]

  describe "keys", ->

    it "works on objects", ->
      expect(keys sadf: 1, asdf: 2, fdas: 3).toEqual ['sadf', 'asdf', 'fdas']

    it "works on arrays", ->
      expect(keys [1, 2, 3]).toEqual ['0', '1', '2']

  describe "length", ->

    it "works on arrays", ->
      expect(len list).toEqual 5
      expect(len []).toEqual 0

    it "works on objects", ->
      expect(len {x: 1, y: 2, z: 3}).toEqual 3
      expect(len {}).toEqual 0

    it "works on strings", ->
      expect(len 'abcd').toEqual 4
      expect(len '').toEqual 0

  describe "cons ", ->

    it "adds..an array", ->
      expect(cons 1, [2, 3]).toEqual [1, 2, 3]

    it "adds two givens..create an array", ->
      expect(cons 4, 5).toEqual [4, 5]

    it "works on strings", ->
      expect(cons 'a', 'bc').toEqual 'abc'

  describe "append", ->

    it "works on arrays", ->
      expect(append [1, 2], [3, 4]).toEqual [1, 2, 3, 4]
      expect(append [1, 2], 3).toEqual [1, 2, 3]

    it "works on strings", ->
      expect(append 'abc', 'def').toEqual 'abcdef'

  describe "join", ->

    it "works on arrays", ->
      expect(join ',', [1, 2, 3]).toEqual '1,2,3'


  describe "reverse", ->

    it "works on arrays", ->
      expect(reverse list).toEqual [5, 4, 3, 2, 1]
      expect(reverse []).toEqual []

    it "doesn't mutate given list", ->
      expect(list).toEqual [1, 2, 3, 4, 5]

    it "works on strings", ->
      expect(reverse 'abcd').toEqual 'dcba'
      expect(reverse '').toEqual ''

  describe "fold", ->

    it "works on arrays", ->
      expect(fold 0, [1, 2, 3, 6], plus).toEqual 12
      expect(fold 0, [], plus).toEqual 0

    it "works on strings", ->
      expect(fold '', 'abc', plus).toEqual 'abc'
      expect(fold '', '', plus).toEqual ''

    it "works on objects", ->
      expect(fold 0, {a: 1, b: 2, c: 3, d: 6}, plus).toEqual 12
      expect(fold 0, {}, plus).toEqual 0

  describe "fold1", ->

    it "works on arrays", ->
      expect(fold1 [1, 2, 3, 6], plus).toEqual 12

    it "works on strings", ->
      expect(fold1 'abc', (x, y) -> "#{x} -> #{y}").toEqual 'a -> b -> c'

  describe "foldr", ->

    it "works", ->
      expect(foldr 9, [1, 2, 3, 4], minus).toEqual -1

  describe "foldr1", ->

    it "works", ->
      expect(foldr1 [1, 2, 3, 4, 9], minus).toEqual -1

  describe "unfoldr", ->

    it "works", ->
      expect(unfoldr 10, (x) ->
        if x == 0 then null else [x, x - 1]
      ).toEqual [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

  describe "andList", ->

    it "returns true for all true", ->
      expect(andList [true, 2 + 2 == 4]).toBe true

    it "returns false if false occurs", ->
      expect(andList [true, true, false, true]).toBe false

    it "returns true for empty", ->
      expect(andList []).toBe true

  describe "orList", ->

    it "returns true for some true", ->
      expect(orList [false, false, false, true, false]).toBe true

    it "returns false for all false", ->
      expect(orList [false, 2 + 2 == 3]).toBe false

    it "returns false for empty", ->
      expect(orList []).toBe false

  describe "any", ->

    it "works on arrays", ->
      expect(any [1, 4, 3], even).toBe true
      expect(any [1, 3, 7, 5], even).toBe false
      expect(any [], even).toBe false

    it "works on strings", ->
      expect(any 'mmmhMmm', equals 'M').toBe true
      expect(any 'mmmhMmm', equals 'Z').toBe false
      expect(any '', equals 'Z').toBe false

  describe "all", ->

    it "works on arrays", ->
      expect(all [2, 4, 6], even).toBe true
      expect(all [2, 5, 6], even).toBe false
      expect(all [], even).toBe true

    it "works on strings", ->
      expect(all 'MMMMMM', equals 'M').toBe true
      expect(all 'MMMmMM', equals 'M').toBe false
      expect(all '', equals 'M').toBe true

  describe "unique", ->

    it "works on arrays", ->
      expect(unique [1, 1, 2, 3, 3, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6]).toEqual(
                    [1, 2, 3, 4, 5, 6]
      )

    it "works on objects", ->
      expect(unique a: 2, b: 3, c: 2).toEqual [2, 3]

    it "works on strings", ->
      expect(unique 'aaabbbcccdd').toEqual 'abcd'

  describe "sort", ->

    it "works on arrays", ->
      expect(sort [3, 1, 5, 2, 4, 6]).toEqual [1, 2, 3, 4, 5, 6]
      expect(sort []).toEqual []

    it "sorts numbers numerically not alphabetically", ->
      expect(sort [334, 12, 5, 2, 4999, 6]).toEqual [2, 5, 6, 12, 334, 4999]


  describe "sortWith", ->

    it "doesn't need a useful callback with empty list", ->
      expect(sortWith [], ->).toEqual []

    it "works", ->
      obj = one: 1, two: 2, three: 3
      expect(sortWith ['three', 'one', 'two'], compare toMap obj).toEqual(
                      ['one', 'two', 'three']
      )

  describe "sortBy", ->

    it "works", ->
      obj = one: 1, two: 2, three: 3
      expect(sortBy ['three', 'one', 'two'], toMap obj).toEqual(
                      ['one', 'two', 'three']
      )

  describe "compare", ->

    it "works", ->
      expect(compare [1..3], [0..5], (x) -> x.length).toEqual -1
      expect(compare [1..9], [0..5], (x) -> x.length).toEqual  1
      expect(compare [1..4], [4..7], (x) -> x.length).toEqual  0

  describe "sum", ->

    it "works on arrays", ->
      expect(sum [1, 2, 3, 4]).toEqual 10
      expect(sum []).toEqual 0

    it "works on objects", ->
      expect(sum a: 1, b: 2, c: 3, d: 4).toEqual 10
      expect(sum {}).toEqual 0

  describe "product", ->

    it "works on arrays", ->
      expect(product [1, 2, 3, 4]).toEqual 24
      expect(product []).toEqual 1

    it "works on objects", ->
      expect(product a: 1, b: 2, c: 3, d: 4).toEqual 24
      expect(product {}).toEqual 1

  describe "mean", ->

    it "works on arrays", ->
      expect(mean [2, 3, 4, 5, 6]).toEqual 4
      expect(isItNaN mean []).toBe true

    it "works on objects", ->
      expect(mean a: 2, b: 3, c: 4, d: 5, e: 6).toEqual 4

  describe "median", ->

    it "is not defined for empty", ->
      expect(median []).toEqual undefined

    it "works on odd number of elements", ->
      expect(median [4, 3, 2, 6, 5]).toEqual 4

    it "works on even number of elements", ->
      expect(median [4, 5, 2, 3]).toEqual 3.5

  describe "concat", ->

    it "works on arrays", ->
      expect(concat [[1, 2], [3, 4], [5, 6]]).toEqual [1, 2, 3, 4, 5, 6]
      expect(concat []).toEqual []

    it "works on strings", ->
      expect(concat ['aa', 'bb', 'cc', 'dd']).toEqual 'aabbccdd'

  describe "concatMap", ->

    it "works on arrays", ->
      expect(concatMap [1, 2, 3], (x) -> [1..x]).toEqual [1, 1, 2, 1, 2, 3]
      expect(concatMap [], ->).toEqual []

    it "works on strings", ->
      expect(concatMap ['aa', 'bb', 'cc', 'dd'], (x) ->
        x.toUpperCase()
      ).toEqual 'AABBCCDD'

  describe "maximum", ->

    it "works on arrays", ->
      expect(maximum [1, 2, 6, 4, 5]).toEqual 6
      expect(maximum []).toEqual undefined

    it "works on strings", ->
      expect(maximum 'abcdef').toEqual 'f'
      expect(maximum ['charlie', 'dan', 'adam', 'bob']).toEqual 'dan'

  describe "minimum", ->

    it "works on arrays", ->
      expect(minimum [4, 3, 2, 6, 9]).toEqual 2
      expect(minimum []).toEqual undefined

    it "works on strings", ->
      expect(minimum 'abcdef').toEqual 'a'
      expect(minimum ['charlie', 'dan', 'adam', 'bob']).toEqual 'adam'

  describe "scan", ->

    it "works on arrays", ->
      expect(scan 4, [1, 2, 3], (x, y) -> 2 * x + y).toEqual [4, 9, 20, 43]
      expect((res = scan 0, [], plus).length).toEqual 1
      expect(res).toEqual [0]

  describe "scan1", ->

    it "works on arrays", ->
      expect(scan1 [1, 2, 3, 4], plus).toEqual [1, 3, 6, 10]

  describe "scanr", ->

    it "works on arrays", ->
      expect(scanr 5, [1, 2, 3, 4], plus).toEqual [15, 14, 12, 9, 5]

  describe "scanr1", ->

    it "works on arrays", ->
      expect(scanr1 [1, 2, 3, 4], plus).toEqual [10, 9, 7, 4]

  describe "replicate", ->

    it "works", ->
      expect(replicate 4, 3).toEqual [3, 3, 3, 3]
      expect(replicate 0, 0).toEqual []

    it "does not treat strings specially", ->
      expect(replicate 4, 'a').toEqual ['a', 'a', 'a', 'a']
      expect(replicate 0, 'a').toEqual []

  describe "take", ->

    it "works on arrays", ->
      expect(take 3, [1, 2, 3, 4, 5]).toEqual [1, 2, 3]
      expect(take 3, []).toEqual []
      expect(take -1, [1..5]).toEqual []

    it "works on strings", ->
      expect(take 2, string).toEqual 'ab'
      expect(take 3, '').toEqual ''
      expect(take 0, string).toEqual ''

  describe "drop", ->

    it "works on arrays", ->
      expect(drop 3, [1, 2, 3, 4, 5]).toEqual [4, 5]
      expect(drop 3, []).toEqual []
      expect(drop 0, [1..5]).toEqual [1, 2, 3, 4, 5]

    it "works on strings", ->
      expect(drop 2, string).toEqual 'cde'
      expect(drop 2, '').toEqual ''
      expect(drop 0, string).toEqual 'abcde'

  describe "splitAt", ->

    it "works on arrays", ->
      expect(join '|', splitAt 3, [1, 2, 3, 4, 5]).toEqual '1,2,3|4,5'
      expect((res = splitAt 3, []).length).toEqual 2
      expect(res[0]).toEqual []
      expect(res[1]).toEqual []

    it "works on strings", ->
      expect(join '|', splitAt 3, 'abcde').toEqual 'abc|de'
      expect((res = splitAt 3, '').length).toEqual 2
      expect(res[0]).toEqual ''
      expect(res[1]).toEqual ''

  describe "takeWhile", ->

    it "works on arrays", ->
      expect(takeWhile [1, 3, 5, 4, 8, 7, 9], odd).toEqual [1, 3, 5]
      expect(takeWhile [], odd).toEqual []

    it "works on strings", ->
      expect(takeWhile 'mmmmmhmm', equals 'm').toEqual 'mmmmm'
      expect(takeWhile '', equals 'm').toEqual ''

  describe "dropWhile", ->

    it "works on arrays", ->
      expect(dropWhile [2, 4, 6, 7, 9, 10], even).toEqual [7, 9, 10]
      expect(dropWhile [], odd).toEqual []

    it "works on strings", ->
      expect(dropWhile 'mmmmmhmm', equals 'm').toEqual 'hmm'
      expect(dropWhile '', equals 'm').toEqual ''

  describe "span", ->

    it "works on arrays", ->
      expect(join '|', span [2, 4, 6, 7, 9, 10], even).toEqual '2,4,6|7,9,10'
      expect((res = span [], even).length).toEqual 2
      expect(res[0]).toEqual []
      expect(res[1]).toEqual []

    it "works on strings", ->
      expect(join '|', span 'mmmmmhmm', equals 'm').toEqual 'mmmmm|hmm'
      expect((res = span '', equals 'm').length).toEqual 2
      expect(res[0]).toEqual ''
      expect(res[1]).toEqual ''

  describe "breakIt", ->

    it "works on arrays", ->
      expect(join '|', breakIt [1, 2, 3, 4, 5], equals 3).toEqual '1,2|3,4,5'
      expect((res = breakIt [], even).length).toEqual 2
      expect(res[0]).toEqual []
      expect(res[1]).toEqual []

    it "works on strings", ->
      expect(join '|', breakIt 'mmmmmhmm', equals 'h').toEqual 'mmmmm|hmm'
      expect((res = breakIt '', equals 'h').length).toEqual 2
      expect(res[0]).toEqual ''
      expect(res[1]).toEqual ''

  describe "elem", ->

    it "works on arrays", ->
      expect(elem 2, [1..5]).toBe true
      expect(elem 6, [1..5]).toBe false
      expect(elem 3, []).toBe false

    it "works on strings", ->
      expect(elem 'a', 'bad').toBe true

  describe "notElem", ->

    it "works on arrays", ->
      expect(notElem 0, [1..5]).toBe true
      expect(notElem 3, [1..5]).toBe false
      expect(notElem 3, []).toBe true

    it "works on strings", ->
      expect(notElem 'z', 'bad').toBe true

  describe "lookup", ->

    it "works on objects", ->
      expect(lookup 'two', two: 2).toEqual 2
      expect((lookup 'two', {})?).toBe false

    it "works on arrays", ->
      expect(lookup 2, [2, 3, 4]).toEqual 4

  describe "call", ->

    it "works on objects", ->
      expect(call 'four', four: -> 4).toEqual 4
      expect((call 'four', {})?).toBe false

    it "works on arrays", ->
      expect(call 1, [null, -> 4]).toEqual 4

    it "passes arguments along", ->
      expect(call 'four', 6, four: id).toEqual 6

  describe "listToObj", ->

    it "works", ->
      expect(listToObj [['a', 'b']
                        ['c', 'd']
                        ['e', 1]]).toEqual a: 'b', c: 'd', e: 1
      expect(listToObj []).toEqual []

  describe "toMap", ->

    it "works", ->
      expect((toMap one: 1, two: 2)('two')).toEqual 2

  describe "typeOf", ->

    it "identifies String", ->
      expect(typeOf new String).toEqual 'String'
      expect(typeOf "").toEqual 'String'

    it "identifies Array", ->
      expect(typeOf []).toEqual 'Array'

    it "identifies Object", ->
      expect(typeOf {}).toEqual 'Object'
      class Snake
      expect(typeOf new Snake).toEqual 'Object'

    it "identifies Number", ->
      expect(typeOf 42).toEqual 'Number'
      expect(typeOf new Number).toEqual 'Number'

    it "identifies Date", ->
      expect(typeOf new Date).toEqual 'Date'

    it "identifies RegExp", ->
      expect(typeOf /goal/g).toEqual 'RegExp'
      expect(typeOf new RegExp "goal").toEqual 'RegExp'

    it "identifies Undefined and Null", ->
      expect(typeOf undefined).toEqual 'Undefined'
      expect(typeOf null).toEqual 'Null'

  describe "zip", ->

    it "works", ->
      expect(zip [1, 2], [4, 5]).toEqual [[1, 4], [2, 5]]
      expect(zip [], []).toEqual []

  describe "zipWith", ->

    it "works in the right order", ->
      expect(zipWith [1, 2, 3], [2, 3, 4], minus).toEqual [-1, -1, -1]
      expect(zipWith [], [], id).toEqual []

  describe "zipAll", ->

    it "works", ->
      expect(zipAll [1, 2, 3], [4, 5, 6], [7, 8, 9]).toEqual (
                   [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
      )
      expect(zipAll [], []).toEqual []

  describe "zipAllWith", ->

    it "works", ->
      expect(zipAllWith [1, 2, 3], [3, 2, 1], [1, 2, 3], (x, y, z) ->
        x + y + z).toEqual [5, 6, 7]
      expect(zipAllWith [], [], [], [], id).toEqual []

  describe "compose", ->

    it "works", ->
      addTwo = (x) -> x + 2
      timesTwo = (x) -> x * 2
      minusOne = (x) -> x - 1
      composed = compose addTwo, timesTwo, minusOne
      expect(composed 3).toEqual 9,

  describe "curry", ->

    it "works", ->
      add = (x, y, z) -> x + y + z
      addCurried = curry add
      expect((addCurried 4, 2) 3).toEqual 9
      expect((addCurried 4) 2, 2).toEqual 8
      #expect( addCurried 4, 2, 1).toEqual 7

  describe "partial", ->

    addAdd = (x, y, z) -> x + y + z
    it "curries", ->
      add9 = partial addAdd, 4, 5
      expect(add9 8).toEqual 17

    it "curries multiple", ->
      add3 = partial addAdd, 3
      expect(add3 9, 5).toEqual 17

    it "curries all arguments", ->
      add0 = partial addAdd
      expect(add0 0, 0, 17).toEqual 17

    it "curries 0 arguments", ->
      add17 = partial addAdd, 0, 0, 17
      expect(add17()).toEqual 17

  describe "id ", ->

    it "works", ->
      expect(id 5).toEqual 5

  describe "flip", ->

    it "works", ->
      expect((flip minus) 5, 15).toEqual 10

    it "curries", ->
      expect(flip minus, 5, 15).toEqual 10

  describe "fix", ->

    it "works with one argument", ->
      expect((fix (fib) -> (n) ->
        if n <= 1 then 1
        else fib(n - 1) + fib(n - 2))(10)
      ).toEqual 89

    it "works with multiple arguments", ->

      expect((fix (fib) -> (n, minus = 0) ->
        if n - minus <= 1 then 1
        else fib(n, minus + 1) + fib(n, minus + 2))(10)
      ).toEqual 89

  describe "lines", ->

    it "works", ->
      expect(lines 'one\ntwo\nthree').toEqual ['one', 'two', 'three']
      #expect(lines 'one\r\ntwo\r\nthree').toEqual ['one', 'two', 'three']
      expect(lines '').toEqual []

  describe "unlines", ->

    it "works", ->
      expect(unlines ['one', 'two', 'three']).toEqual 'one\ntwo\nthree'
      expect(unlines []).toEqual ''

  describe "words", ->

    it "works with single spaces", ->
      expect(words 'what is this').toEqual ['what', 'is', 'this']
      expect(words '' ).toEqual []

    it "works with multiple spaces", ->
      expect(words 'what   is  this').toEqual ['what', 'is', 'this']

  describe "unwords", ->

    it "works", ->
      expect(unwords ['what', 'is', 'this']).toEqual 'what is this'
      expect(unwords []).toEqual ''

  describe "max", ->

    it "works on numbers", ->
      expect(max 2, 3).toEqual 3

    it "works on strings", ->
      expect(max 'a', 'b').toEqual 'b'
      expect(max 'adam', 'barbara').toEqual 'barbara'

  describe "min", ->

    it "works on numbers", ->
      expect(min 9, 0).toEqual 0

    it "works on strings", ->
      expect(min 'a', 'b').toEqual 'a'
      expect(min 'adam', 'barbara').toEqual 'adam'

  describe "negate", ->

    it "works", ->
      expect(negate  2).toEqual -2
      expect(negate -3).toEqual  3
      expect(negate  0).toEqual  0

  describe "abs", ->

    it "works", ->
      expect(abs -4).toEqual 4
      expect(abs  4).toEqual 4
      expect(abs  0).toEqual 0

  describe "signum", ->

    it "works", ->
      expect(signum 8).toEqual 1
      expect(signum 82372.237272).toEqual 1
      expect(signum 0).toEqual 0
      expect(signum -0).toEqual 0
      expect(signum -5.3).toEqual -1

  describe "quot", ->

    it "works", ->
      expect(quot -20, 3).toEqual -6

  describe "rem", ->

    it "works like %", ->
      expect(rem -20,  3).toEqual -2
      expect(rem  20, -3).toEqual  2
      expect(rem -20, -3).toEqual -2

  describe "div", ->

    it "works", ->
      expect(div -20, 3).toEqual -7

  describe "mod", ->

    it "works (properly on negatives)", ->
      expect(mod -20, 3).toEqual  1
      expect(mod 20, -3).toEqual -1

  describe "recip", ->

    it "inverts", ->
      expect(recip 2).toEqual 0.5

  describe "pi", -> it "works", ->

      expect(pi).toEqual 3.141592653589793

  describe "tau", -> it "works", ->

      expect(tau).toEqual 6.283185307179586

  describe "exp", -> it "works", ->

      expect(exp 1).toEqual 2.718281828459045

  describe "sqrt", -> it "works", ->

      expect(sqrt 4).toEqual 2

  describe "ln", -> it "works", ->

      expect(ln 2).toEqual 0.6931471805599453

  describe "pow", -> it "works", ->

      expect(pow -2, 2).toEqual 4

  describe "sin", -> it "works", ->

      expect(sin 1).toEqual 0.8414709848078965
      expect(sin 0).toEqual 0

  describe "tan", -> it "works", ->

      expect(tan 1).toEqual 1.5574077246549023
      expect(tan 0).toEqual 0

  describe "cos", -> it "works", ->

      expect(cos 1).toEqual 0.5403023058681398
      expect(cos 0).toEqual 1

  describe "acos", -> it "works", ->

      expect(acos 0.1).toEqual 1.4706289056333368

  describe "asin", -> it "works", ->

      expect(asin 1).toEqual 1.5707963267948966

  describe "atan", -> it "works", ->

      expect(atan 1).toEqual 0.7853981633974483

  describe "atan2", -> it "works", ->

      expect(atan2 1, 2).toEqual 0.4636476090008061

  # # not implemented yet
  # describe "sinh", ->
  # describe "tanh", ->
  # describe "cosh", ->
  # describe "asinh", ->
  # describe "atanh", ->
  # describe "acosh", ->

  describe "truncate", ->

    it "rounds toward 0 (that is ceil on negatives)", ->
      expect(truncate -1.5).toEqual -1

    it "rounds toward 0 (that is floor on positives)", ->
      expect(truncate  1.5).toEqual  1

  describe "round", ->

    it "rounds unbiased", ->
      expect(round 0.6).toEqual 1
      expect(round 0.5).toEqual 1
      expect(round 0.4).toEqual 0

  describe "ceil", ->

    it "rounds up", ->
      expect(ceil 0.1).toEqual 1

  describe "floor", ->

    it "rounds down", ->
      expect(floor 0.9).toEqual 0

  describe "isItNaN", ->

    it "works", ->
      expect(isItNaN Math.sqrt -1).toBe true
      expect(isItNaN '0').toBe false

  describe "even", ->

    it "works", ->
      expect(even -2).toBe true
      expect(even  7).toBe false
      expect(even  0).toBe true

  describe "odd", ->

    it "works", ->
      expect(odd  3).toBe true
      expect(odd -4).toBe false
      expect(odd  0).toBe false

  describe "gcd", ->

    it "works", ->
      expect(gcd 12, 18).toEqual 6

    it "works on negatives", ->
      expect(gcd -12,  18).toEqual 6
      expect(gcd  12, -18).toEqual 6
      expect(gcd -12, -18).toEqual 6

  describe "lcm", ->

    it "works", ->
      expect(lcm 12, 18).toEqual 36

    it "works on negatives", ->
      expect(lcm  12, -18).toEqual 36
      expect(lcm -12,  18).toEqual 36
      expect(lcm -12, -18).toEqual 36

  describe "plus", ->

    it "adds numbers", ->
      expect(plus -2, 3).toEqual 1

    it "curries", ->
      expect((plus -2) 3).toEqual 1

  describe "minus", ->

    it "subtracts numbers", ->
      expect(minus -2, 3).toEqual -5

    it "curries", ->
      expect((minus -2) 3).toEqual -5

  describe "times", ->

    it "multiplies numbers", ->
      expect(times -2, 3).toEqual -6

    it "curries", ->
      expect((times -2) 3).toEqual -6

  describe "over", ->

    it "divides numbers", ->
      expect(over -2, 3).toEqual -2/3

    it "curries", ->
      expect((over -2) 3).toEqual -2/3

  describe "equals", ->

    it "compares numbers", ->
      expect(equals 3, 3).toBe true

    it "curries", ->
      expect((equals 3) 3).toBe true