liberator.plugins.pixiv = (function() {
  let libly = liberator.plugins.libly;
  let $LXs = libly.$U.getNodesFromXPath;
  let tags_cache = {};

  let pixivManager = {
    bookmark_illust: function(id, tags, comment, next) {  // {{{
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
    },  /// }}}
    bookmark_user: function(id, next) { // {{{
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
    },  /// }}}
    get_entries: function(id, next) {  // {{{
      let url = 'http://www.pixiv.net/bookmark_illust_user.php?illust_id=' + id;
      let req = new libly.Request(url);
      req.addEventListener('onSuccess', function(res) {
        res.getHTMLDocument();
        let doc = res.doc;

        let obj = {};
        let span = doc.querySelector('.bookmark_link');
        obj.count = span ? span.textContent.match(/^\d+/)[0] : '0';

        obj.entries = $LXs('id("content2")/div[@class="link_visited"]/div', doc).map(function(b) {
          let date = b.firstChild.nodeValue.trim();
          let img = b.getElementsByTagName('img').item(0);
          let tags = $LXs('a[contains(@href, "tag=")]', b).map(function(a)
                        decodeURIComponent(a.href.match(/tag=([^&]+)/)[1]));
          return { date: date, imgsrc: img.src, user: img.alt, tags: tags };
        });

        next(obj);
      });
      req.get();
    },  // }}}
  };

  commands.addUserCommand(['pixivBookmark'], 'pixiv bookmark',  // {{{
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
          context.completions = [[t, ''] for each(t in tags_cache[url]) if (args.indexOf(t) == -1)];
        } else {
          let req = new libly.Request('http://www.pixiv.net/bookmark_add.php?type=illust&illust_id=' + id);
          req.addEventListener('onSuccess', function(res) {
            let tags = res.getHTMLDocument('//div[@class="bookmark_add_area"]/ul/li/a')
                        .map(function(a) a.firstChild.nodeValue);

            tags_cache[url] = tags;
            context.title = ['tag'];
            context.completions = [[t, ''] for each(t in tags) if (args.indexOf(t) == -1)];
          });
          req.get();
        }
      },
      literal: -1,
    },
    true);  // }}}

  commands.addUserCommand('pixivUserBookmark', 'bookmark this user', // {{{
    function() {
      let id = content.document.getElementById('rpc_u_id');
      if (id) {
        id = id.textContent;
      } else {
        if (/^http:\/\/www\.pixiv\.net\/[\w_]+\.php\?id=(\d+)/.test(buffer.URI)) {
          id = RegExp.$1;
        } else {
          liberator.echoerr('cannot bookmark here!');
          return;
        }
      }
      pixivManager.bookmark_user(id, function(res) {
        let m = res.responseText.match(/<a href="member\.php\?id=\d+">([^<]+)<\/a>([^<]+)/);
        liberator.echo(m[1] + m[2]);
      });
    }, { argCount: '0' }, true);  // }}}

  commands.addUserCommand('pixivViewBookmark', 'view pixiv bookmark', // {{{
    function() {
      if (!/http:\/\/www\.pixiv\.net\/member_illust\.php\?.*illust_id=(\d+)/.test(buffer.URI)) {
        liberator.echo('not pixiv illust page');
        return;
      }

      pixivManager.get_entries(RegExp.$1, function(r) {
        let dd = <></>;
        r.entries.forEach(function(e) {
          dd += <>
            <dd class="liberator-pixiv-bookmark-entry" highlight="Completions" style="margin: 0; height: 18px;">
              <span class="liberator-pixiv-bookmark-date">{e.date}</span>
              <span class="liberator-pixiv-bookmark-icon"><img src={e.imgsrc}/></span>
              <span class="liberator-pixiv-bookmark-user">{e.user}</span>
              <span class="liberator-pixiv-bookmark-tag" highlight="Tag" style="margin-left: 1em;">{e.tags.join(', ')}</span>
            </dd>
          </>;
        });

        const TITLE = "\u3053\u306E\u30A4\u30E9\u30B9\u30C8\u3092\u30D6\u30C3\u30AF\u30DE\u30FC\u30AF\u3057\u3066\u3044\u308B\u30E6\u30FC\u30B6\u30FC";
        let xml = <>
          <dl id="liberator-pixiv-bookmark" style="margin: 0;">
            <dt highlight="CompTitle">{TITLE}  {r.count}({r.entries.length})</dt>
            {dd}
          </dl>
        </>;

        liberator.echo(xml);
      });
      req.get();
    }, { argCount: '0' }, true);  // }}}

  return pixivManager;
})();

// vim: set et sw=2 ts=2 sts=2:

