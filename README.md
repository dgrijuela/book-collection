Book Collection
==========

This is a web application where you can upload your books in
multiple formats (pdf, mobi, epub, or zip) with a cover image, a title,
and its author's name (or authors).

Registration is needed to do it.

You can also see all the books uploaded by other users and search them.


Testing
---------

The test suite in use is RSpec which is run by:
```sh
bundle exec rspec
```

Software dependencies
---------

* [Image Magick] - A server-side image processing library required for the
                  [Paperclip] gem to make modify images' attributes.

You can also see other people's books and download them.

There is aIf you don't find any book, you can use its search engine.

[Image Magick]:http://www.imagemagick.org/
[Paperclip]:https://github.com/thoughtbot/paperclip
