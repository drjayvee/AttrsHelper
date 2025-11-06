The code in this repo demonstrates a bug in JetBrains RubyMine's RBS support.

`lib/foo.rb` contains two classes, each of which uses a helper method to declare attributes
and a matching `initialize` method. The only difference between the classes is that `Bad`'s
helper lives in a separate module (which `Bad` `extend`s), while `Good` has the same helper
as an own class method.

Both classes have identical, correct RBS signatures.

The problem is that RubyMine ignores `Bad#initialize`'s signature entirely (falling back on
`BasicObject#initialize`), and therefore reports warnings:

![screenshot](screenshot.png)