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
