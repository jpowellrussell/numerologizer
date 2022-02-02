# numerologizer
Small Emacs package that converts strings to their numerological value.

Just a bit of fun as I've been experimenting with traditional American numerology as described in these [posts](https://ecosophia.dreamwidth.org/tag/numerology).

I'm pretty novice at elisp, so this is likely rather ugly and could be cleaner. Use `numerologizer-prompt` to get a quick value echoed to the messages buffer, or use `numerologizer` in any code where you might want the numerological value of a string returned.

Please note that this has **not** been tested with a very wide range of characters - pretty much just the standard American keyboard. You'll want to add items to the hash-table if you have a lot of other characters to deal with.

I use the following [use-package](https://github.com/jwiegley/use-package) setup along with [straight.el](https://github.com/raxod502/straight.el) for initializing the package in my own config. If you use straight.el and use-package, you should only need to replace YOUR-NAME below with your github username.

```
(use-package numerologizer
  :straight (numerologizer :type git :host github :repo "jpowellrussell/numerologizer"
            :fork (:host github
                         :repo "YOUR-NAME/numerologizer"))
  :demand t)
```

You can remove the `:demand` keyword if you have some kind of key-binding to call the function, or if some mode or another will ask for the function at some point. Otherwise, `:demand` just says "load this at startup". It's a small enough package that you shouldn't notice any slow down.
