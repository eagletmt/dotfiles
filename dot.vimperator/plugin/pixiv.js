(function() {
  commands.addUserCommand(['pixivBookmark'], 'pixiv bookmark',
    function(args) {
      if (!buffer.URI.match(/www\.pixiv\.net\/member_illust\.php\?.*illust_id=\d+/)) {
        liberator.echoerr('not a pixiv illust page');
        return;
      }
      let params = {
        mode: 'add',
        tt: liberator.plugins.libly.$U.getFirstNodeFromXPath('//input[@name="tt"]').value,
        id: buffer.URI.match(/illust_id=(\d+)/)[1],
        type: 'illust',
        restrict: '0',
        tag: args.map(function(t) encodeURIComponent(t)).join('+'),
        comment: '',
      };
      let q = [k + '=' + params[k] for (k in params)].join('&');

      let req = new liberator.plugins.libly.Request('http://www.pixiv.net/bookmark_add.php', null, {postBody: q});
      req.addEventListener('onSuccess', function(res) {
        let m = res.responseText.match(/<strong class="link_visited">\[ <a href="[^"]+">(.+?)<\/a> \]<\/strong>(.+?)<br \/>/);
        liberator.echo('[' + m[1] + '] ' + m[2]);
      });
      req.post();
    },
    {
      completer: function(context, args) {
        let libly = liberator.plugins.libly;
        let $U = libly.$U;

        let id = buffer.URI.match(/illust_id=(\d+)/)[1];
        let req = new libly.Request('http://www.pixiv.net/bookmark_add.php?type=illust&illust_id=' + id);
        req.addEventListener('onSuccess', function(res) {
          let cnt = window.content;
          let doc = cnt.document.implementation.createDocument(
            'http://www.w3.org/1999/xhtml',
            'html',
            cnt.document.implementation.createDocumentType(
              'html',
              '-//W3C//DTD HTML 4.01//EN',
              'http://www.w3.org/TR/html4/strict.dtd'));
          let range = cnt.document.createRange();
          range.selectNodeContents(cnt.document.documentElement);
          let content = doc.adoptNode(range.createContextualFragment(res.responseText));
          doc.documentElement.appendChild(content);

          let tags = [];
          let div = doc.getElementsByClassName('bookmark_add_area');
          [div[0], div[1]].forEach(function(e) {
            let as = e.getElementsByTagName('a');
            for each(a in as) {
              let onclick = a.getAttribute('onclick');
              let m = onclick.match(/'([^']+)'/);
              tags.push(decodeURI(m[1]));
            }
          });

          context.title = ['tag'];
          context.completions = [[t, ''] for each(t in tags)];
          //tags.forEach(function(t) liberator.echo(t));
        });
        req.get();
      },
      literal: -1,
    },
    true);
})();

