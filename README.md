# atom-increment package

**atom-increment** is a package i wrote for the [Atom text editor](https://atom.io/).  
It increments values from either a selection, multiple cursors or a combination of both.

See [Figure 1](#fig1) for a screenshot.


## Usage

You can increment :

* numbers using :
  * `atom-increment:incNumber` command,
  * `ctrl-alt-i` keyboard shortcut,

* strings using :
  * `atom-increment:incString` command,
  * `ctrl-alt-j` keyboard shortcut.


## Settings

Please note that you might need to refresh your Atom application for your settings changes to take effect.

You can define settings for `number` or `string` type :

* Numbers
  * Increment Start Value : default is 0
  * Increment Size : default is 1
  * Integers of same size : boolean that states if every generated number will be of the same size (in this case, we add trailing '0' if needed), default is false
  * Integers minimum size : minimum size for every generated number, default is 3

Those default values will generate a sequence like so : `0 1 2 3 4 etc...`  
If you set `start value` to `10` and `size` to `2`, it will generate : `10 12 14 16 etc...`

* Strings (for example : aaa aab aac etc...)
  * Left to right : boolean that states if we increment letters starting from left side, default is false
  * Minimum size : minimum size for every generated string, default is 3
  * Same size : boolean that states if every generated string will be of the same size (in this case, we add trailing 'a' if needed), default is true
  * Upper case : boolean that defines string case, default is false (= lower case)

There are also general settings :

* orderByClick : boolean which defines the order of a generated sequence, default is false
  * if true, the generated values will follow the click order (when using ctrl+click for multiple cursors for example)  
  * if false, the generated values will follow the top-down order


## Note

The number of generated elements will only depend on your selections / multiple cursors.  


## License

MIT (see [License](https://github.com/norben/atom-increment/blob/master/LICENSE.md))


## Figures

<a name="fig1">Figure 1 : a screenshot of the `atom-increment` package settings</a>
![A screenshot of settings](https://raw.githubusercontent.com/norben/atom-increment/4465dd98e554ae09fee57719300757bc8bb8976d/images/settings.png)
