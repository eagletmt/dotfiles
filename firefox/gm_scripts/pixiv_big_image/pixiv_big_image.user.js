// ==UserScript==
// @name           pixiv big image
// @namespace      http://d.hatena.ne.jp/eagletmt/
// @description    hoge
// @include        http://www.pixiv.net/member_illust.php?mode=medium*
// ==/UserScript==
(function() {
  if (document.getElementById('bigmode')) {
    return;
  }
  var a = document.evaluate('//a[contains(@href, "mode=big")]', document, null, 7, null).snapshotItem(0).cloneNode(true);
  a.firstChild.src = a.firstChild.src.replace(/_m(\.\w+)$/, '$1');

  var div = content.document.createElement('div');
  div.id = 'bigmode';
  div.appendChild(a);
  document.getElementById('illust_contents').appendChild(div);
})();

