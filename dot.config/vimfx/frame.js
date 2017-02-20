vimfx.listen('speakerdeck_next_slide', () => {
  let iframe = content.document.querySelector('.speakerdeck-iframe');
  if (iframe) {
    iframe.contentWindow.wrappedJSObject.player.nextSlide();
  }
});

vimfx.listen('speakerdeck_prev_slide', () => {
  let iframe = content.document.querySelector('.speakerdeck-iframe');
  if (iframe) {
    iframe.contentWindow.wrappedJSObject.player.previousSlide();
  }
});

vimfx.listen('amazon_clean_url', () => {
  let doc = content.document;
  // ASIN.0 in kindle store
  let asin = doc.getElementById('ASIN') || doc.getElementsByName('ASIN.0')[0];
  if (asin) {
    content.window.history.replaceState(null, 'amazon_clean_url', '/dp/' + asin.value + '/');
  }
});

vimfx.listen('slideshare_next_slide', () => {
  let btn = content.document.getElementById('btnNext');
  if (btn) {
    btn.click();
  }
});

vimfx.listen('slideshare_prev_slide', () => {
  let btn = content.document.getElementById('btnPrevious');
  if (btn) {
    btn.click();
  }
});

vimfx.listen('twitter_kill_tco', () => {
  for (let node of content.document.querySelectorAll('.twitter-timeline-link')) {
    let url = node.dataset.expandedUrl;
    if (url && node.href !== url) {
      node.href = url;
      node.textContent = url;
      node.classList.remove('u-hidden');
    }
  }

  for (let img of content.document.querySelectorAll('.js-adaptive-photo > img')) {
    let a = content.document.createElement('a');
    a.href = `${img.src}:orig`;
    let div = img.parentNode;
    div.parentNode.replaceChild(a, div);
    a.appendChild(img);
  }
});

vimfx.listen('pixiv_tags_clickable', () => {
  for (let tag of content.document.querySelectorAll('.tag')) {
    if (!tag.querySelector('a')) {
      tag.setAttribute('role', 'checkbox');
    }
  }
});

vimfx.listen('github_disable_hotkey', () => {
  // FIXME: Sometimes doesn't work...
  for (let item of content.document.querySelectorAll('.js-toolbar-item[data-toolbar-hotkey]')) {
    item.removeAttribute('data-toolbar-hotkey');
    item.removeAttribute('data-prefix');
    item.removeAttribute('data-suffix');
  }
});

vimfx.listen('go_hatena_bookmark', () => {
  content.window.location.href = 'http://b.hatena.ne.jp/entry/' + content.window.location.href;
});

vimfx.listen('go_ldr', () => {
  content.window.location.href = 'http://reader.livedwango.com/subscribe/' + content.window.location.href;
});

vimfx.listen('toggle_source', () => {
  if (content.window.location.protocol === 'view-source:') {
    content.window.location.href = content.window.location.pathname + content.window.location.hash;
  } else {
    content.window.location.href = 'view-source:' + content.window.location.href;
  }
});
