commands.add(
    ['google'],
    'Search webpages with google', 
    function(args, bang, count) {
      liberator.open('http://www.google.com/search?q=' + encodeURIComponent(args.join(' ')), liberator.NEW_TAB);
    }
);

commands.add(
    ['googleimage'],
    'Search images with google',
    function(args, bang, count) {
      liberator.open('http://images.google.com/images?q=' + encodeURIComponent(args.join(' ')), liberator.NEW_TAB);
    }
);

commands.add(
    ['eijiro'],
    'Search English words with Eijiro',
    function(args, bang, count) {
      liberator.open('http://eow.alc.co.jp/' + encodeURIComponent(args.join(' ')) + '/UTF-8/', liberator.NEW_TAB);
    }
);

commands.add(
    ['blogsearch'],
    'Search blogs with google',
    function(args, bang, count) {
      liberator.open('http://blogsearch.google.co.jp/blogsearch?q=' + encodeURIComponent(args.join(' ')), liberator.NEW_TAB);
    }
);

commands.add(
    ['twittersearch'],
    'Search Tweets',
    function(args, bang, count) {
      liberator.open('http://pcod.no-ip.org/yats/search?query=' + encodeURIComponent(args.join(' ')), liberator.NEW_TAB);
    }
);

commands.add(
    ['hoogle'],
    'hoogle',
    function(args, bang, count) {
      liberator.open('http://www.haskell.org/hoogle/?hoogle=' + encodeURIComponent(args.join(' ')), liberator.NEW_TAB);
    }
);

commands.add(
    ['googlecode'],
    'Google code search', 
    function(args, bang, count) {
      liberator.open('http://www.google.com/codesearch?q=' + encodeURIComponent(args.join(' ')), liberator.NEW_TAB);
    }
);

