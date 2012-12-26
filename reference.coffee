#!! map

#!! Iterable -> Function -> Iterable

#!! Applies the supplied callable to each item in the collection, returns a new collection with the results. The length of the result is the same as the length of the input.


map [1..5], times 2 #=> [2, 4, 6, 8, 10]
map 'haha', call 'toUpperCase' #=> 'HAHA'
map {a: 2, b: 3}, plus 2 #=> {a: 4, b: 5}
map ['one', 'two'], {one: 1, two: 2} #=> [1, 2]
map {power: 1, light: 0}, ['off', 'on']
#=> {power: 'on', light: 'off'}
map [num: 3; num: 1], lookup 'num' #=> [3, 1]


`

map([1, 2, 3, 4, 5], times(2));
//=> [2, 4, 6, 8, 10]
map(aList, someFunction); //=> a list of something
map(['HA', 'ha'], toMap({ha: 1, HA: 2})); //=> [2, 1]
var mapAddTwo = flip(map, add(2));
//=> a function

`


#!! filter

#!! Iterable -> Function -> Iterable

#!! Filters a collection, removing all items that do not pass the test of applying the supplied callable to each item.


filter [1..5], (x) -> x < 3 #=> [1, 2]
filter {a: 3, b: 4, c: 0}, even #=> {b: 4, c: 0}
filter 'hahaha', equals 'a' #=> 'aaa'


`

filter([1, 2, 3, 4, 5], odd); //=> [1, 3, 5]
filter({x: 4, y: 2, z: 8}, function(x){
  return x <= 2; }); //=> {y: 2}

`


#!! reject

#!! Iterable -> Function -> Iterable

#!! Like <code>filter</code>, but instead of adding item to results it passes the test, adds those items who <em>don't</em> pass the test.


reject [1..5], odd #=> [2, 4]
reject {a: 2, b: 'ha'}, (x) -> typeOf(x) is 'String'
#=> {a: 2}
reject 'mmhmm', equals 'h' #=> 'mmmm'


`

reject({a: 3, b: 8, c: 1}, even); //=> {a: 3, c: 1}




`


#!! partition

#!! Iterable -> Function -> [Iterable]

#!! Equivalent to <code>[(filter f, xs), (reject f, xs)]</code>, but more efficient, only using one loop.


partition 'abcdefcf', flip elem, ['abc']
#=> ['abcc', 'deff']


`

partition([1, 2, 3, 4, 5], even);
//=> [[2, 4], [1, 3, 5]]

`


#!! find

#!! Iterable -> Function -> x

#!! Returns the first item to pass the test.


find [2, 4, 6, 7, 8, 9, 10], odd #=> 7


`

find({b: 3, a: 2}, function(x){ return x <= 3; });
//=> 2

`


#!! each

#!! Iterable -> Function -> Iterable

#!! Applies function to each item in the collection (item in list or object, character in string), returns the original collection. Used for side effects.


each [['a'], ['b'], ['c']], call 'push', 'boom'
#=> [['a', 'boom'], ['b', 'boom'], ['c', 'boom']]


`

var count = 4;
each({a:1, b:2, c:3}, function(x){ count += x; });
count; //=>  10

`


#!! head

#!! Array -> x<br />String -> String

#!! The first item of the list, or first character of the string.


head [1..5] #=> 1
head 'hello'  #=> 'h'


`

head([9, 8, 7]); //=> 9
head('world');   //-> 'w'

`


#!! tail

#!! List -> List

#!! Everything but the first item of the list, or everything but the first character in the string.


tail [1..5] #=> [2, 3, 4, 5]
tail 'hello'  #=> 'ello'


`

tail([9, 8, 7]); //=> [8, 7]
tail('world');   //-> 'orld'

`


#!! last

#!! String -> String

#!! The last item of the list, or the last character of the string.


last [1..5] #=> 5
last 'hello'  #=> 'o'


`

last([9, 8, 7]); //=> 7
last('world');   //-> 'd'

`


#!! initial

#!! List -> List

#!! Everything but the last item of the list, or everything but the last character in the string.


initial [1..5] #=> [1, 2, 3, 4]
initial 'hello'  #=> 'hell'


`

initial([9, 8, 7]); //=> [9, 8]
initial('world');   //-> 'worl'

`


#!! empty

#!! Iterable -> Boolean

#!! Whether the collection is empty, eg. <code>[]</code>, <code>{}</code>, or <code>''</code>.


empty [] #=> true
empty {} #=> true
empty '' #=> true


`

empty([]); //=> true
empty({}); //=> true
empty('')' //=> true

`


#!! values

#!! Object -> Array

#!! Returns a list of the values of the object.


values a: 2, b: 3, c: 9 #=> [2, 3, 9]


`

values({moo: 'haha'}); //=> ['haha']

`


#!! keys

#!! Object -> Array

#!! Returns a list of the keys of the object.


keys a: 2, b: 3, c: 9 #=> ['a', 'b', 'c']


`

keys([1, 2, 3]); //=> [0, 1, 2]

`


#!! length

#!! Iterable -> Number

#!! Returns the number of items in the collection.


length [1, 4, 2]     #=> 3
length h: 2, j: 23 #=> 2
length 'antwoord'  #=> 8


`

length([3]); //=> 1
length {}    //=> 0
length 'doh' //=> 3

`


#!! cons

#!! x -> Array -> Array<br />x -> y -> Array<br />String -> String -> String

#!! Returns a new list made by adding the supplied item to the front of the given list. Also mashes together strings.


cons 1, [2, 3]  #=> [1, 2, 3]
cons 4, 5      #=> [4, 5]
cons 'a', 'bc' #=> 'abc'


`

cons(2, [4, 6]); //=> [2, 4, 6]



`


#!! append

#!! List -> List -> List<br />Array -> x -> Array

#!! Returns a new list - either putting two lists together, or appending an item to a list. Also mashes together strings.


append [1, 2], [3, 4] #=> [1, 2, 3, 4]
append [1, 2] 3     #=> [1, 2, 3]
append 'abc', 'def' #=> 'abcdef'


`

append([4, 5], [6, 7]); //=> [4, 5, 6, 7]
append([4, 5], 6);      //=> [4, 5, 6]
append('ha', 'ha');     //=> 'haha'

`


#!! join

#!! String -> Array -> String

#!! Joins a list with the specified separator.


join '|', [1...4] #=> '1|2|3'


`

join('*', [4, 5, 6]); //=> '4*5*6'

`


#!! reverse

#!! List -> List

#!! Reverses a list or a string.


reverse [1..3] #=> [3, 2, 1]
reverse 'goat'   #=> 'taog'


`

reverse([3, 4, 5]); //=> [5, 4, 3]
reverse('Moo');     //=> 'ooM'

`


#!! fold

#!! memo -> Iterable -> Function -> x

#!! Takes a collection of items, and using the function supplied, folds them into a single value. Requires an initial value (memo), which will be the result in case of an empty collection. The function supplied must take two arguments.


fold 0, [1..5], plus #=> 15
product = fold 1, times
fold someFunc, anObject


`

fold(function(x, y){ return x + y; }, 0,
  {a: 4, b: 5, c: 6}); //=> 15


`


#!! fold1

#!! Iterable -> Function -> x

#!! Like <code>fold</code>, except assumes a non-empty collection, and thus doesn't require an initial value.


fold1 [1..3], plus #=> 6


`

fold1(aFunction, aList);

`


#!! foldr

#!! memo -> Iterable -> Function -> x

#!! Like <code>fold</code>, except from the right.


foldr 9, [1, 2, 3, 4], minus #=> -1


`

foldr(aFunction, initValue, aList);

`


#!! foldr1

#!! Iterable -> Function -> x

#!! Like <code>foldr</code>, except assumes a non-empty collection, and thus doesn't require an initial value.


foldr1 [1, 2, 3, 4, 9], minus #=> -1


`

foldr1(aFunction, aList);

`


#!! unfold

#!! x -> Function -> Array

#!! Unfold builds a list from a seed value (<code>x</code>). It takes a function which either returns <code>undefined</code> when it is done producing the list, or returns <code>[a, b]</code>, <code>a</code> is prepended to the list, and <code>b</code> is used as the next element in the recursive call.


unfold 10, (x) -> if x > 0 then [x, x - 1]
#=> [10,9,8,7,6,5,4,3,2,1]


`






`


#!! andList

#!! Array -> Number<br />Object -> Boolean

#!! Returns true if each item in the collection is true.


andList [true, 2 + 2 == 4] #=> true
andList [true, true, false] #=> false


`

andList(aListAllTrue); //=> true



`


#!! orList

#!! Array -> Number<br />Object -> Boolean

#!! Returns true if any item in the collection is true.


orList [false, false, true, false] #=> true


`

orList({a: false, b: true}); //=> true

`


#!! any

#!! Iterable -> Function -> Boolean

#!! Returns true if any of the items in the collection are true when applied to the test.


any [3, 5, 7, 8, 9], even #=> true


`

any([2, 4, 6, 8], odd); #=> false

`


#!! all

#!! Iterable -> Function -> Boolean

#!! Returns true if all the items in the collection are true when applied to the test.


all ['ha', 'ma', 'la'], (x) -> typeOf(x) is 'String'
#=> true


`

all('mmmhmm', function(x){ return x == 'm'; });
//=> false

`


#!! unique

#!! Array -> Array

#!! Sorts a list, does not modify the input.


sort [3, 1, 5, 2, 4, 6]
#=> [1,2,3,4,5,6]


`





`


#!! sortBy

#!! (x -> y -> (-1 | 0 | 1)) -> Array -> Array

#!! Takes a function which compares two items and returns either <code>-1</code>, <code>0</code>, or <code>1</code>, and a list, and sorts using that function. The original list is not modified.


obj = one: 1, two: 2, three: 3
sortBy ['three', 'one', 'two'], (compare toMap obj)
#=> ['one', 'two', 'three']


`






`


#!! compare

#!! x -> y -> Function -> (-1 | 0 | 1)

#!! Takes a function, applies it to both <code>x</code> and <code>y</code>, and produces either <code>-1</code>, <code>0</code>, or <code>1</code>. Useful when combined with <code>sortBy</code>, and just given the first argument.


compare [1..3], [0..5], lookup 'length' #=> -1
compare [1..9], [0..5], lookup 'length' #=>  0
compare [1..4], [4..7], lookup 'length' #=>  1


`






`


#!! sum

#!! [Number] -> Number<br />{Number} -> Number

#!! Sums up the values in the list or object. 0 if empty.


sum [1..5]         #=> 15
sum x: 1, y: 2, z: 3 #=> 6


`

sum([4, 5, 6]); //=> 15



`


#!! product

#!! [Number] -> Number<br />{Number} -> Number

#!! Gets the product of all the items in the list or objects. 1 if empty.


product [1, 2, 3] #=> 6


`

product([4, 3, 2]); //=> 24

`


#!! mean

#!! [Number] -> Number<br />{Number} -> Number

#!! Gets the mean of the values in the list or object.


mean [1..5] #=> 3


`

mean([4, 3]); //=> 3.5

`


#!! concat

#!! [List] -> List

#!! Concatenates a list of lists together.


concat [[1], [2, 3], [4]]   #=> [1, 2, 3, 4]
concat ['aa', 'bb', 'cc', 'dd'] #=> 'aabbccdd'


`

concat([['a', 'b'], ['c']]); //=> ['a', 'b', 'c']



`


#!! concatMap

#!! [List] -> Function -> Array

#!! Maps the callable on the list, then concats.


concatMap [1, 2, 3], (x) -> [1..x] #=> [1,1,2,1,2,3]
concatMap ['aa', 'bb', 'cc', 'dd'], call 'toUpperCase'
#=> 'AABBCCDD'


`

concatMap([1, 2, 3]], function(x){ return [x];});
//=> [1, 2, 3]



`


#!! maximum

#!! [Comparable] -> Comparable

#!! Takes a list of comparable items, and returns the biggest of them.


maximum [4, 1, 9, 3] #=> 9


`

maximum(['b', 'a', 'd']); //=> 'd'

`


#!! minimum

#!! [Comparable] -> Comparable

#!! Takes a list of comparable items, and returns the smallest of them.


minimum ['abcdef'] #=> 'a'


`

minimum([3, 2, 8]); //=> 2

`


#!! scan

#!! memo -> Iterable -> Function -> Array

#!! Like a fold, except instead of just returning the final value, returns a list composed of the initial value, the intermediate values, and then the final value. Requires an initial value (memo) in case of an empty collection. The function supplied needs to take two arguments.


scan (plus), 0, [1..3] #=> [0, 1, 3, 6]


`

scan(someFunc, 0, [1, 2, 3]);

`


#!! scan1

#!! Iterable -> Function -> Array

#!! Like <code>scan</code>, except assumes non-empty collection, and thus doesn't require an initial value.


scan1 [1..3], plus #=> [1, 3, 6]


`

scan1([1, 2, 3], someFunc);

`


#!! scanr

#!! memo -> Iterable -> Function -> Array

#!! Like <code>scan</code>, except from the right.


scanr (plus), 0, [1..3] #=> [6, 5, 3, 0]


`

scanr(someFunc, 0, [1, 2, 3]);

`


#!! scanr1

#!! Iterable -> Function -> Array

#!! Like <code>scanr</code>, except assumes non-empty collection, and thus doesn't require an initial value.


scanr1 [1..3], plus #=> [6, 5, 3]


`

scanr1([1, 2, 3], someFunc);

`


#!! replicate

#!! Number -> x -> [x]

#!! Takes its second argument, and repeats it n times.


replicate 4, 'a' #=> ['a', 'a', 'a', 'a']


`

replicate(4, 2); //=> [3, 3, 3, 3]

`


#!! take

#!! Number -> List -> List

#!! Returns the first n items in the list or string.


take 2, [1..5] #=> [1, 2]
take 4, 'hello'   #=> 'hell'


`

take(4, []); //=> []
var takeTwo = take(2);

`


#!! drop

#!! Number -> List -> List

#!! Returns the result of dropping the first n items of the list or string.


drop 2, [1..5] #=> [3, 4, 5]
drop 1, 'goat'   #=> 'oat'


`

drop(6, [3, 4]); //=> []
drop(3, 'foot'); //=> 't'

`


#!! splitAt

#!! Number -> List -> [List]

#!! Equivalent to <code>[(take n, xs), (drop n, xs)]</code>


splitAt 2, [1..5] #=> [[1, 2], [3, 4, 5]]


`

splitAt(4, 'hello'); //=> ['hell', 'o']

`


#!! takeWhile

#!! List -> Function -> List

#!! Takes the first items of the list or string which pass the test.


takeWhile 'cabdek', flip elem, ['abcd'] #=> 'cabd'


`

takeWhile([2, 4, 5, 6], even); //=> [2, 4]

`


#!! dropWhile

#!! List -> Function -> List

#!! Drops the first items of the list or string which pass the test.


dropWhile [2, 4, 5, 6], even #=> [5, 6]


`

dropWhile([3, 1, 2, 5], odd); //=> [2, 5]

`


#!! span

#!! List -> Function -> [List]

#!! Equivalent to <code>[(takeWhile f, xs), (dropWhile f, xs)]</code>


span [2, 4, 5, 6], even #=> [[2, 4], [5, 6]]


`

span([3, 1, 2, 5], odd); //=> [[3, 1], [2, 5]]

`


#!! breakIt

#!! List -> Function -> [List]

#!! Equivalent to <code>span xs, (x) -> not f x</code>


breakIt [1..5], equals 3 #=> [[1, 2], [3, 4, 5]]


`

breakIt(even, [2, 4, 5, 6] //=> [[], [2, 4, 5, 6]]

`


#!! listToObj

#!! [[key, val]] -> Object

#!! Converts a list of lists (pairs) into an object.


listToObj [['a', 1], ['b', 2]] #=> {a: 1, b: 2}


`

listToObj([['d', 5], ['e', 6]]); //=> {d: 5, e: 6}

`


#!! toMap

#!! Object -> Function

#!! Turns an object or an array into a function, a mapping from keys to values.


f = toMap m: 4, c: 6
f 'm' #=> 4


`

var g = toMap(['a', 'b']);
g(1); //=> 'b'

`


#!! zip

#!! Array -> Array -> [Array]

#!! Zips together its arguments into a list of lists.


zip [1, 2], [4, 5]
#=> [[1, 4], [2, 5]]


`

zip([1, 2], [9, 8]);
//=> [[1, 9], [2, 8]]

`


#!! zipWith

#!! Array -> Array -> Function -> Array

#!! As <code>zip</code>, but applies the supplied function to the lists and creates a list of the results. The supplied function must take two arguments.


zipWith [1, 2, 3], [3, 2, 1], plus #=> [4, 4, 4]
zipWith [4, 5, 3], [6, 5, 4], equals
#=> [false, true, false]


`

zipWith([3, 2, 1], [8, 2, 9], binaryFunction);



`


#!! zipAll

#!! Array... -> [Array]

#!! Zips together its arguments into a list of lists. Can take any number of arguments, but is not curried.


zipAll [1, 2, 3], [4, 5, 6], [7, 8, 9]
#=> [[1, 4, 7], [2, 5, 8], [3, 6, 9]]


`

zipAll([1, 2], [9, 8]);
//=> [[1, 9], [2, 8]]

`


#!! zipAllWith

#!! Array... -> Function -> Array

#!! As <code>zipAll</code>, but applies the supplied function to the lists and creates a list of the results. The supplied function must take in as many arguments as there are lists being inputed.


zipAllWith [1, 2], [3, 2], [1, 1], (x, y, z) ->
  x + y + z
#=> [5, 5, 5]


`

zipWith([3, 2, 1], [8, 2, 9], binaryFunction);



`


#!! compose

#!! ...Functions -> Function

#!! Compose takes a series of functions as arguments, and composes them, returning a single function which when called will apply all the functions. Note that compose composes function forwards. It is an alternative to doing <code>(x) -> f4 f3 f2 f1 x</code>.


f = compose (plus 2), (times 2), minus 2
f 3 #=> 8


`

var g = compose(f1, f2, f3, f4);
g();

`


#!! curry

#!! Function -> Function

#!! Returns the function supplied, curried. Meaning, when the returned function is called with less than its number of arguments, it will return a new, partially applied function. This works on functions with a variable number of arguments as well. Note that curry will always return a function and the function itself is not curried.


curriedPow = curry Math.pow
fourToThe = curriedPow 4
fourToThe 2 #=> 16


`

var add = curry(function(x, y){ return x + y; });
var addFour = add(4);
addFour(3); //=> 6

`


#!! id

#!! x -> x

#!! A function which does nothing. It simply returns its argument.


id 5 #=> 5


`

id('something'); //=> 'something'

`


#!! flip

#!! Function -> Function

#!! Returns a function with the arguments flipped. Works with binary functions.


invertedPower = flip pow
invertedPower 2, 3 #=> 9


`

var divide = function(x, y){ return x / y; };
var divideBy = flip(divide);
divideBy(2, 1); //=> 0.5

`


#!! fix

#!! (Function -> Function) -> Function

#!! Fix-point function for anonymous recursion, implemented with the <a href="https://en.wikipedia.org/wiki/Fixed-point_combinator#Y_combinator">Y combinator</a>.


(fix (fib) -> (n) ->
  if n <= 1 then 1
  else fib(n - 1) + fib(n - 2))(9) #=> 55


`

fix(function(fib){
    return function(n){
      if (n <= 1) { return 1; }
      return fib(n - 1) + fib(n - 2);
    };
  })(9); //=> 55

`


#!! lines

#!! String -> [String]

#!! Splits a string at newlines into a list.


lines '''one
         two
         three'''
#=> ['one', 'two', 'three']


`

lines('a'nb''nc''); //=> ['a', 'b', 'c']




`


#!! unlines

#!! [String] -> String

#!! Joins a list of strings into a single string using newlines.


unlines ['one', 'two', 'three']
#=> 'one
#    two
#    three'


`

unlines(['a', 'b', 'c']); #=> 'a'nb''nc''




`


#!! words

#!! String -> [String]

#!! Splits a string at spaces, returning a list of strings.


words 'hello, what is that?'
#=> ['hello,', 'what', 'is', 'that?']


`

words('at the end  of   the');
//=> ['at', 'the', 'end', 'of', 'the']

`


#!! unwords

#!! [String] -> String

#!! Joins a list of strings into a single string using spaces.


unwords ['one', 'two', 'three'] #=> 'one two three'


`

unwords(['a', 'b', 'c']); //=> 'a b c'

`


#!! max

#!! Comparable -> Comparable -> Value

#!! Takes two arguments which can be compared using <code>&gt;</code>, returns the larger one.


max 3, 1   #=> 3
max 'a', 'c' #=> "c"


`

max(4, 5);     //=> 5
max('d', 'g'); //=> "g"

`


#!! min

#!! Comparable -> Comparable -> Value

#!! Takes two arguments which can be compared using <code>&gt;</code>, returns the smaller one.


min 3, 1   #=> 1
min 'a', 'c' #=> "a"


`

min(4, 5);     //=> 4
min('d', 'g'); //=> "d"

`


#!! negate

#!! Negatable -> Number

#!! Takes an argument, most often a number, but also anything that can be coerced into a number, eg. <code>'3'</code>, and returns it as a number, negated.


negate 3  #=> -3
negate -2 #=>  2


`

negate(-1);  //=>  1
negate('5'); //=> -5

`


#!! abs

#!! Number -> Number

#!! Takes a number and returns its absolute value. A number's absolute value is


abs -2 #=>  2
abs 2  #=> 2


`

negate(-1);  //=>  1
negate('5'); //=> -5

`


#!! signum

#!! Number -> (-1 | 0 | 1)

#!! Takes a number and returns either -1, 0, or 1 depending on the sign of the number.


signum -5 #=> -1
signum  0 #=>  0
signum  9 #=>  1


`

signum(-1); //=> -1
signum( 0); //=>  0
signum( 1); //=>  1

`


#!! quot

#!! Number -> Number -> Number

#!! Division truncated toward 0.


quot -20, 3 #=> -6


`

quot(-20, 3); //=> -6

`


#!! rem

#!! Number -> Number -> Number

#!! Remainder, like the <code>%</code> operator.


rem -20, 3 #=> -2


`

rem(-20, 3); //=> -2

`


#!! div

#!! Number -> Number -> Number

#!! Division truncated down toward negative infinity.


div -20, 3 #=> -7


`

div(-20, 3); //=> -7

`


#!! mod

#!! Number -> Number -> Number

#!! Remainder, modulo, with proper mathematical semantics.


mod -20, 3 #=> 1


`

mod(20, -3); //=> -1

`


#!! recip

#!! Number -> Number

#!! One over the number, ie <code>1 / x</code>


recip 4 #=> 0.25


`

recip(0.5); //=> 2

`


#!! pi

#!! Number

#!! &pi;


pi #=> 3.141592653589793


`

pi; //=> 3.141592653589793

`


#!! tau

#!! Number

#!! &tau; - equal to 2 * &pi;


tau #=> 6.283185307179586


`

tau; //=> 6.283185307179586

`


#!! exp

#!! Number -> Number

#!! Returns e to the argument.


exp 1 #=> 2.718281828459045


`

exp(1); #=> 2.718281828459045

`


#!! sqrt

#!! Number -> Number

#!! Square root.


sqrt 4 #=> 2


`

sqrt(16); //=> 4

`

#!! ln

#!! Number -> Number -> Number

#!! Natural log.


ln 10 #=> 2.302585092994046


`

ln(10); //=> 2.302585092994046

`


#!! pow

#!! Number -> Number -> Number

#!! Power. First raised to the power of the second.


pow -2, 2 #=> 4


`

pow(4, 2) #=> 16

`


#!! sin

#!! Number -> Number

#!! Number truncated toward 0.


truncate -1.5 #=> -1
truncate  1.5 #=>  1


`

truncate(-1.8); //=> -1
truncate( 1.2); //=>  1

`


#!! round

#!! Number -> Number

#!! Number rounded to nearest whole number.


round 0.6 #=> 1
round 0.5 #=> 1
round 0.4 #=> 0


`

round(-1.3); //=> -1
round(-1.8); //=> -2
round( 9.5); //=>  10

`


#!! ceil

#!! Number -> Number

#!! Number rounded up.


ceil 0.1 #=> 1


`

ceil(-0.9); //=> 0

`


#!! floor

#!! Number -> Number

#!! Number rounded down.


floor 0.9 #=> 0


`

floor(-0.1); //=> -1

`


#!! isItNaN

#!! Number -> Boolean

#!! Is it <code>NaN</code> (not a number)? More accurate than the native <code>isNaN</code> function.


isItNaN sqrt -1 #=> true


`

isItNaN(undefined); //=> false

`


#!! even

#!! Number -> Boolean

#!! Is the number even?


even 4 #=> true


`

even(0); //=> true

`


#!! odd

#!! Number -> Boolean

#!! Is the number odd?


odd 3 #=> true


`

odd(0); //=> false

`


#!! gcd

#!! Number -> Number -> Number

#!! Greatest common denominator.


gcd 12, 18 #=> 6


`

gcd(12, 18); //=> 6

`


#!! lcm

#!! Number -> Number -> Number

#!! Least common multiple.


lcm 12, 18 #=> 36


`

lcm(12, 18); //=> 36

`
