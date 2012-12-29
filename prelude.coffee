# This is a rewrite of the prelude.ls in CoffeeScript for CoffeeScript
# It omits currying and put callables at the end of paramater lists

typeOf = {}.toString

X = {}

X.typeOf = (obj) ->
  typeOf.call(obj)[8...-1]

X.toMap = toMap = (obj) ->
  (key) -> obj[key]

X.each = each = (xs, f) ->
  if typeOf.call(xs) is '[object Object]'
    f x for key, x of xs
  else
    f x for x in xs
  xs

X.map = map = (xs, f) ->
  type = typeOf.call xs
  if type is '[object Object]'
    res = {}
    res[key] = f x for key, x of xs
    res
  else
    result = (f x for x in xs)
    if type is '[object String]' then result.join('') else result

X.filter = filter = (xs, f) ->
  type = typeOf.call xs
  if type is '[object Object]'
    result = {}
    result[key] = x for key, x of xs when f x
    result
  else
    result = (x for x in xs when f x)
    if type is '[object String]' then result.join('') else result

X.reject = reject = (xs, f) ->
  type = typeOf.call xs
  if type is '[object Object]'
    result = {}
    result[key] = x for key, x of xs when not f x
    result
  else
    result = (x for x in xs when not f x)
    if type is '[object String]' then result.join('') else result

X.partition = partition = (xs, f) ->
  type = typeOf.call xs
  if type is '[object Object]'
    passed = {}
    failed = {}
    for key, x of xs
      (if f x then passed else failed)[key] = x
  else
    passed = []
    failed = []
    for x in xs
      (if f x then passed else failed).push x
    if type is '[object String]'
      passed = passed.join ''
      failed = failed.join ''
  [passed, failed]

X.find = find = (xs, f) ->
  if typeOf.call(xs) is '[object Object]'
    for key, x of xs when f x then return x
  else
    for x in xs when f x then return x
  undefined

X.pluck = pluck = (prop, xs) ->
  if typeOf.call(xs) is '[object Object]'
    result = {}
    result[key] = x[prop] for key, x of xs when x[prop]?
    result
  else
    x[prop] for x in xs when x[prop]?

X.head = head = X.first = first = (xs) ->
  return undefined if not xs.length
  xs[0]

X.tail = tail = (xs) ->
  return undefined if not xs.length
  xs[1..]

X.last = last = (xs) ->
  return undefined if not xs.length
  xs[xs.length - 1]

X.initial = initial = (xs) ->
  return undefined if not xs.length
  xs[0...-1]

X.empty = empty = (xs) ->
  if typeOf.call(xs) is '[object Object]'
    for x of xs then return false
    return yes
  not xs.length

X.values = values = (obj) ->
  x for key, x of obj

X.keys = keys = (obj) ->
  x for x of obj

X.len = len = (xs) ->
  xs = values xs if typeOf.call(xs) is '[object Object]'
  xs.length

X.cons = cons = (x, xs) ->
  if typeOf.call(xs) is '[object String]' then x + xs else [x].concat xs

X.append = append = (xs, ys) ->
  if typeOf.call(ys) is '[object String]' then xs + ys else xs.concat ys

X.join = join = (sep, xs) ->
  xs = values xs if typeOf.call(xs) is '[object Object]'
  xs.join sep

X.reverse = reverse = (xs) ->
  if typeOf.call(xs) is '[object String]'
  then (xs.split '').reverse().join ''
  else xs.slice().reverse()

X.fold = fold = X.foldl = foldl = (memo, xs, f) ->
  if typeOf.call(xs) is '[object Object]'
    for key, x of xs
      memo = f memo, x
  else
    for x in xs
      memo = f memo, x
  memo

X.fold1 = fold1 = X.foldl1 = foldl1 = (xs, f) ->
  fold xs[0], xs[1..], f

X.foldr = foldr = (memo, xs, f) ->
  fold memo, xs.slice().reverse(), f

X.foldr1 = foldr1 = (xs, f) ->
  xs = xs.slice().reverse()
  fold xs[0], xs[1..], f

X.unfoldr = unfoldr = X.unfold = unfold = (b, f) ->
  while (that = f b)?
    b = that[1]
    that[0]

X.andList = andList = (xs) ->
  for x in xs when not x
    return false
  true

X.orList = orList = (xs) ->
  for x in xs when x
    return true
  false

X.any = any = (xs, f) ->
  for x in xs when f x
    return yes
  no

X.all = all = (xs, f) ->
  for x in xs when not f x
    return no
  yes

X.unique = unique = (xs) ->
  result = []
  if typeOf.call(xs) is '[object Object]'
    result.push x for key, x of xs when x not in result
  else
    result.push x for      x in xs when x not in result
  if typeOf.call(xs) is '[object String]' then result.join('') else result

X.sort = sort = (xs) ->
  xs.slice().sort (x, y) ->
    if      x > y then  1
    else if x < y then -1
    else                0

X.sortWith = sortWith = (xs, f) ->
  return [] unless xs.length
  xs.slice().sort f

X.sortBy = sortBy = (xs, f) ->
  sortWith xs, compare f

X.compare = compare = (fx, y, f) ->
  if arguments.length is 3
    if      (f fx) > (f y) then  1
    else if (f fx) < (f y) then -1
    else                        0
  else
    (x, y) ->
      if      (fx x) > (fx y) then  1
      else if (fx x) < (fx y) then -1
      else                        0

X.sum = sum = (xs) ->
  result = 0
  if typeOf.call(xs) is '[object Object]'
    result += x for key, x of xs
  else
    result += x for      x in xs
  result

X.product = product = (xs) ->
  result = 1
  if typeOf.call(xs) is '[object Object]'
    result *= x for key, x of xs
  else
    result *= x for      x in xs
  result

X.mean = mean = X.average = average = (xs) ->
  (sum xs) / len xs

X.median = median = (xs) ->
  if xs.length is 0
    undefined
  else 
    xs = sort xs
    mid = div xs.length, 2
    if odd xs.length
      xs[mid]
    else
      (xs[mid - 1] + xs[mid]) / 2

X.concat = concat = (xss) ->
  return [] if not xss.length
  for x in xss when not (typeOf.call(x) is '[object String]')
    return [].concat xss...
  xss.join ''

X.concatMap = concatMap = (xs, f) ->
  concat map xs, f

X.listToObj = listToObj = (xs) ->
  result = {}
  result[x[0]] = x[1] for x in xs
  result

X.maximum = maximum = (xs) ->
  fold1 xs, max

X.minimum = minimum = (xs) ->
  fold1 xs, min

X.scan = scan = X.scanl = scanl = (memo, xs, f) ->
  last = memo
  if typeOf.call(xs) is '[object Object]'
  then [memo].concat (last = f last, x for key, x of xs)
  else [memo].concat (last = f last, x for      x in xs)

X.scan1 = scan1 = X.scanl1 = scanl1 = (xs, f) ->
  scan xs[0], xs[1..], f

X.scanr = scanr = (memo, xs, f) ->
  xs = xs.slice().reverse()
  (scan memo, xs, f).reverse()

X.scanr1 = scanr1 = (xs, f) ->
  xs = xs.slice().reverse()
  (scan xs[0], xs[1..], f) .reverse()

X.replicate = replicate = (n, x) ->
  result = []
  i = 0
  while i++ < n
    result.push x
  result

X.take = take = (n, xs) ->
  if n <= 0
    if typeOf.call(xs) is '[object String]' then '' else []
  else if not xs.length
    xs
  else
    xs[...n]

X.drop = drop = (n, xs) ->
  if n <= 0 or not xs.length
    xs
  else
    xs[n..]

X.splitAt = splitAt = (n, xs) ->
  [(take n, xs), (drop n, xs)]

X.takeWhile = takeWhile = (xs, p) ->
  return xs if not xs.length
  result = []
  for x in xs
    break if not p x
    result.push x
  if typeOf.call(xs) is '[object String]' then result.join('') else result

X.dropWhile = dropWhile = (xs, p) ->
  return xs if not xs.length
  i = 0
  for x in xs
    break if not p x
    ++i
  xs[i..]

X.span = span = (xs, p) ->
  [(takeWhile xs, p), (dropWhile xs, p)]

X.breakIt = breakIt = (xs, p) ->
  span xs, (x) -> not p x

X.elem = elem = (x, ys) ->
  if ys?  then x in ys
  else (ys) -> x in ys

X.notElem = notElem = (x, ys) ->
  if ys?  then not (x in ys)
  else (ys) -> not (x in ys)

X.lookup = lookup = (key, xs) ->
  xs?[key]

X.call = call = (key, args..., xs) ->
  xs?[key]?(args...)

X.zip = zip = (xs, ys) ->
  result = []
  for zs, i in [xs, ys]
    for z, j in zs
      if i is 0
        result.push []
      result[j]?.push z
  result

X.zipWith = zipWith = (xs, ys, f) ->
  if not xs.length or not ys.length
    []
  else
    f z... for z in zip xs, ys

X.zipAll = zipAll = (xss...) ->
  result = []
  for xs, i in xss
    for x, j in xs
      if i is 0
        result.push []
      result[j]?.push x
  result

X.zipAllWith = zipAllWith = (xss..., f) ->
  if not xss[0].length or not xss[1].length
    []
  else
    f xs... for xs in zipAll xss...

X.compose = compose = (funcs...) ->
  ->
    args = arguments
    for f in funcs
      args = [f.apply this, args]
    args[0]

X.curry = curry = (f) ->
  ->
    initArgs = arguments
    (args...) ->
      f initArgs..., args...

X.partial = partial = (f, initArgs...) ->
  (args...) ->
    f (initArgs.concat args)...

X.id = id = (x) -> x

X.flip = flip = (f, x, y) ->
  if arguments.length is 3
    f y, x
  else if arguments.length is 2
    (y) -> f y, x
  else
    (x, y) -> f y, x

X.fix = fix = (f) ->
  ( (g, x) -> -> f(g g).apply null, arguments
  ) (g, x) -> -> f(g g).apply null, arguments

X.lines = lines = (str) ->
  return [] unless str.length
  str.split '\n'

X.unlines = unlines = (strs) -> strs.join '\n'

X.words = words = (str) ->
  return [] unless str.length
  str.split /[ ]+/

X.unwords = unwords = (strs) ->
  strs.join ' '

X.max = max = (x, y) ->
  if x > y then x else y

X.min = min = (x, y) ->
  if x < y then x else y

X.negate = negate = (x) -> -x

X.abs = abs = Math.abs

X.signum = signum = (x) ->
  if      x < 0 then -1
  else if x > 0 then  1
  else                0

X.quot = quot = (x, y) -> ~~(x / y)

X.rem = rem = (x, y) -> x % y

X.div = div = (x, y) -> Math.floor x / y

X.mod = mod = (x, y) ->
  if (result = x % y) < 0 && y > 0 || result > 0 && y < 0
    result + y
  else result

X.recip = recip = (x) -> 1 / x

X.pi = pi = Math.PI

X.tau = tau = pi * 2

X.phi = phi = 1.618033988749895

X.exp = exp = Math.exp

X.sqrt = sqrt = Math.sqrt

# changed from log as log is a
# common function for logging things
X.ln = ln = Math.log

# base-b log

X.pow = pow = Math.pow

X.sin = sin = Math.sin

X.tan = tan = Math.tan

X.cos = cos = Math.cos

X.asin = asin = Math.asin

X.acos = acos = Math.acos

X.atan = atan = Math.atan

X.atan2 = atan2 = Math.atan2

# sinh
# tanh
# cosh
# asinh
# atanh
# acosh

X.truncate = truncate = (x) -> ~~x

X.round = round = Math.round

X.ceil = ceil = Math.ceil

X.floor = floor = Math.floor

X.isItNaN = isItNaN = (x) -> x isnt x

X.even = even = (x) -> x % 2 == 0

X.odd = odd = (x) -> x % 2 != 0

X.gcd = gcd = (x, y) ->
  x = Math.abs x
  y = Math.abs y
  until y is 0
    z = x % y
    x = y
    y = z
  x

X.lcm = lcm = (x, y) ->
  Math.abs Math.floor (x / (gcd x, y) * y)

X.plus = plus = (x, y) ->
  if y?  then x + y
  else (y) -> x + y

X.minus = minus = (x, y) ->
  if y?  then x - y
  else (y) -> x - y

X.times = times = (x, y) ->
  if y?  then x * y
  else (y) -> x * y

X.over = over = (x, y) ->
  if y?  then x / y
  else (y) -> x / y

X.equals = equals = (x, y) ->
  if y?  then x == y
  else (y) -> x == y

# meta

X.extend = extend = (to, from, except = []) ->
  to[key] = val for own key, val of from when not (key in except)

X.prelude = prelude = this

X.installPrelude = installPrelude = (target, except) ->
  unless target.prelude?.isInstalled
    extend target, X, except
    target.prelude.isInstalled = true

module.exports = X