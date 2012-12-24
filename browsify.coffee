fs = require 'fs'

js = fs.readFileSync "prelude.js", "utf-8"

js = """(function (that) {
  if(typeof define !== 'function') {
    var define = function (x) {
      that.prelude = x;
    }
  }
  var module = {};
  define(function () {

#{js}

    return module.exports;
  });
})(this);"""

fs.writeFileSync "prelude-browser.js", js, "utf-8"