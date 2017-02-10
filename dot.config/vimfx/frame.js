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
});
