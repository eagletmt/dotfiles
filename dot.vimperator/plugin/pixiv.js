liberator.plugins.pixiv = (function() {
  let libly = liberator.plugins.libly;
  let $U = libly.$U;
  let tags_cache = {};

  let pixivManager = {
    bookmark_illust: function(id, tags, comment, next) {
      util.httpGet('http://www.pixiv.net/bookmark_add.php?type=illust&illust_id=' + id, function(res) {
        let m = res.responseText.match(/name="tt" value="([^"]+)"/);
        let params = {
          mode: 'add',
          tt: m[1],
          id: id,
          type: 'illust',
          restrict: '0',
          tag: tags.map(function(t) encodeURIComponent(t)).join('+'),
          comment: comment,
        };
        let q = [k + '=' + params[k] for (k in params)].join('&');

        let req = new libly.Request('http://www.pixiv.net/bookmark_add.php', null, {postBody: q});
        req.addEventListener('onSuccess', next);
        req.post();
      });
    },
    bookmark_user: function(id, next) {
      util.httpGet('http://www.pixiv.net/bookmark_add.php?type=user&id=' + id, function(res) {
        let m = res.responseText.match(/name="tt" *value="([^"]+)"/);
        if (m === null) {
          let m = res.responseText.match(/<a href="member\.php\?id=\d+">([^<]+)<\/a>([^<]+)<\/div>/);
          liberator.echo(m[1] + m[2]);
          return;
        }
        let tt = m[1];
        let params = {
          mode: 'add',
          tt: tt,
          id: id,
          type: 'user',
          restrict: '0',
        };
        let q = [k + '=' + params[k] for (k in params)].join('&');
        let req = new libly.Request('http://www.pixiv.net/bookmark_add.php', null, {postBody: q});
        req.addEventListener('onSuccess', next);
        req.post();
      });
    },
  };

  commands.addUserCommand(['pixivBookmark'], 'pixiv bookmark',
    function(args) {
      if (!buffer.URI.match(/www\.pixiv\.net\/member_illust\.php\?.*illust_id=(\d+)/)) {
        liberator.echoerr('not a pixiv illust page');
        return;
      }

      tags_cache = {};
      let id = RegExp.$1;
      pixivManager.bookmark_illust(id, args, '', function(res) {
        let m = res.responseText.match(/<strong class="link_visited">\[ <a href="[^"]+">(.+?)<\/a> \]<\/strong>(.+?)<br \/>/);
        if (m === null) {
          liberator.echo('bookmark modified');
        } else {
          liberator.echo('[' + m[1] + '] ' + m[2]);
        }
      });
    },
    {
      completer: function(context, args) {
        let id = buffer.URI.match(/illust_id=(\d+)/)[1];
        let url = 'http://www.pixiv.net/bookmark_add.php?type=illust&illust_id=' + id;
        if (tags_cache[url]) {
          context.title = ['tag (cached)'];
          context.completions = [[t, ''] for each(t in tags_cache[url]) if (args.every(function(a) a != t))];
        } else {
          util.httpGet('http://www.pixiv.net/bookmark_add.php?type=illust&illust_id=' + id, function(res) {
            let doc = createHTMLDocument(res.responseText);

            let tags = [];
            let div = doc.getElementsByClassName('bookmark_add_area');
            [div[0], div[1]].forEach(function(e) {
              let as = e.getElementsByTagName('a');
              for each(a in as) {
                tags.push(decodeURIComponent(a.getAttribute('onclick').match(/'([^']+)'/)[1]));
              }
            });

            tags_cache[url] = tags;
            context.title = ['tag'];
            context.completions = [[t, ''] for each(t in tags) if (args.every(function(a) a != t))];
          });
        }
      },
      literal: -1,
    },
    true);

  function createHTMLDocument(text) {
    let c = window.content;
    let doc = c.document.implementation.createDocument('http://www.w3.org/1999/xhtml', 'html', null);
    let range = c.document.createRange();
    range.selectNodeContents(c.document.documentElement);
    let content = doc.adoptNode(range.createContextualFragment(text));
    doc.documentElement.appendChild(content);
    return doc;
  }

  return pixivManager;
})();
