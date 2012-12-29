fs = require 'fs'

js = fs.readFileSync "prelude.js", "utf-8"

js = """(function (that) {
  var define = that.define
  if(typeof define !== 'function') {
    define = function (x) {
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