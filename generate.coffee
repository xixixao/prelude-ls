fs = require 'fs'

reference = fs.readFileSync "reference.coffee", "utf-8"

reference = reference.replace ///
      \#!!\s(  .*  ) # Name
      \n\n
      \#!!\s(  .*  ) # Type
      \n\n
      \#!!\s(  .*  ) # Description
      \n\n\n
      (  (.*\S.*\n)*.*\S.*   ) # CoffeeScript
      \n\n\n
      `\n\n(  (.|\n)*?  )\n\n` # JavaScript
     ///g, """
        <div id="f-$1" class="func">
          <a name="f-$1"></a>
          <h3>$1</h3>
          <div class="func-type">$2</div>
          <p>$3
          <div class="example">
            <div class="example-ls">

<pre class="prettyprint lang-ls">
$4
</pre>
            </div>
            <div class="example-js">

<pre class="prettyprint lang-js">
$6
</pre>
            </div>
          </div>
        </div>
"""

layout = fs.readFileSync "layout.html", "utf-8"

index = layout.replace /<!--REFERENCE-->/, reference

fs.writeFileSync "index.html", index, "utf-8"

###
<div id="f-foldr1" class="func">
          <a name="f-foldr1"></a>
          <h3>foldr1</h3>
          <div class="func-type">Function -> Iterable -> x</div>
          <p>Like <code>foldr</code>, except assumes a non-empty collection, and thus doesn't require an initial value.
          <div class="example">
            <div class="example-ls">

<pre class="prettyprint lang-ls">
foldr1 (-), [1 2 3 4 9] #=> -1
</pre>
            </div>
            <div class="example-js">

<pre class="prettyprint lang-js">
foldr1(aFunction, aList);
</pre>
            </div>
          </div>
        </div>
###
