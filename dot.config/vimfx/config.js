vimfx.set('prevent_autofocus', true);

vimfx.set('mode.normal.dev', ';');
vimfx.set('mode.normal.scroll_down', 'j <c-e>');
vimfx.set('mode.normal.scroll_half_page_down', 'J');
vimfx.set('mode.normal.scroll_half_page_up', 'K');
vimfx.set('mode.normal.scroll_left', '<a-h>');
vimfx.set('mode.normal.scroll_page_down', '<space> <c-f>');
vimfx.set('mode.normal.scroll_page_up', '<s-space> <c-b>');
vimfx.set('mode.normal.scroll_right', '<a-l>');
vimfx.set('mode.normal.scroll_up', 'k <c-y>');
vimfx.set('mode.normal.stop', '');
vimfx.set('mode.normal.tab_close', 'd');
vimfx.set('mode.normal.tab_restore', 'u');
vimfx.set('mode.normal.tab_select_next', 'gt l');
vimfx.set('mode.normal.tab_select_previous', 'gT h');
vimfx.set('mode.normal.window_new', '');
vimfx.set('mode.normal.window_new_private', '');

vimfx.addKeyOverrides([({hostname, pathname}) => hostname === 'mail.google.com' && pathname.startsWith('/mail/'), ['j', 'k', 'n', 'p', 'o', 'u', 'e', 's', '?']]);
vimfx.addKeyOverrides([({hostname}) => ['fl.wanko.cc', 'reader.livedwango.com'].includes(hostname), ['j', 'k', 'w', 's', 'a', 'v', 'p', 'o']]);
vimfx.addKeyOverrides([({hostname, pathname, search}) => hostname === 'www.pixiv.net' && pathname === '/member_illust.php' && search.includes('mode=medium'), ['b', 'v']]);
vimfx.addKeyOverrides([({hostname, pathname, search}) => hostname === 'www.pixiv.net' && pathname === '/member_illust.php' && search.includes('mode=manga'), ['j', 'k', 'v', 'z', 'b']]);

let Cc = Components.classes;
let Ci = Components.interfaces;
let bookmarkService = Cc['@mozilla.org/browser/nav-bookmarks-service;1'].getService(Ci.nsINavBookmarksService);
[
  ['Google', 'https://www.google.com/search?q=%s', 'gs'],
  ['Google Images', 'https://www.google.com/search?q=%s&tbm=isch', 'gi'],
  ['Twitter', 'https://twitter.com/%s/with_replies', 'tw'],
  ['alc', 'http://eow.alc.co.jp/search?q=%s', 'alc'],
].forEach(([title, url, keyword]) => {
  let uri = Services.io.newURI(url, null, null);
  if (!bookmarkService.isBookmarked(uri)) {
    let id = bookmarkService.insertBookmark(bookmarkService.bookmarksMenuFolder, uri, bookmarkService.DEFAULT_INDEX, title);
    // FIXME: https://bugzilla.mozilla.org/show_bug.cgi?id=1187119
    bookmarkService.setKeywordForBookmark(id, keyword);
  }
});

let {commands} = vimfx.modes.normal;

vimfx.addCommand({
  name: 'search_tabs',
  description: 'Search tabs',
  category: 'tabs',
  order: commands.focus_location_bar.order + 1,
}, ({vim}) => {
  let {gURLBar} = vim.window;
  commands.focus_location_bar.run({vim});
  gURLBar.value = '% ';
  gURLBar.onInput(new vim.window.KeyboardEvent('input'));
});
vimfx.set('custom.mode.normal.search_tabs', 'b');

function run_in_new_tab(args, f) {
  let {vim} = args;
  commands.tab_new.run(args);
  vim.window.setTimeout(f);
}

function focus_location_bar_with_prefix(args, prefix) {
  let {vim} = args;
  let {gURLBar} = vim.window;
  commands.focus_location_bar.run(args);
  gURLBar.value = prefix;
  gURLBar.onInput(new vim.window.KeyboardEvent('input'));
}

function new_tab_with_prefix(args, prefix) {
  run_in_new_tab(args, () => {
    focus_location_bar_with_prefix(args, prefix);
  });
}

vimfx.addCommand({
  name: 'open_google',
  description: 'Open Google',
  category: 'tabs',
  order: commands.focus_location_bar.order + 1,
}, (args) => {
  new_tab_with_prefix(args, 'gs ');
});
vimfx.set('custom.mode.normal.open_google', 'sg');

vimfx.addCommand({
  name: 'open_twitter',
  description: 'Open Twitter',
  category: 'tabs',
  order: commands.focus_location_bar.order + 1,
}, (args) => {
  new_tab_with_prefix(args, 'tw ');
});
vimfx.set('custom.mode.normal.open_twitter', 'sk');

vimfx.addCommand({
  name: 'open_alc',
  description: 'Open alc',
  category: 'tabs',
  order: commands.focus_location_bar.order + 1,
}, (args) => {
  new_tab_with_prefix(args, 'alc ');
});
vimfx.set('custom.mode.normal.open_alc', 'sa');

vimfx.addCommand({
  name: 'open_bookmarks',
  description: 'Open bookmarks',
  category: 'tabs',
  order: commands.tab_new.order + 1,
}, (args) => {
  new_tab_with_prefix(args, '* ');
});
vimfx.set('custom.mode.normal.open_bookmarks', 'gn');

vimfx.addCommand({
  name: 'my_conditional_w',
  description: 'Run various commands depending on the current site',
}, (args) => {
  let {vim} = args;
  let hostname = vim.window.gBrowser.selectedBrowser.currentURI.host;
  if (hostname === 'speakerdeck.com') {
    vimfx.send(vim, 'speakerdeck_next_slide');
  } else if (hostname === 'www.amazon.co.jp') {
    vimfx.send(vim, 'amazon_clean_url');
  } else if (hostname === 'www.slideshare.net') {
    vimfx.send(vim, 'slideshare_next_slide');
  } else if (hostname === 'twitter.com') {
    vimfx.send(vim, 'twitter_kill_tco');
  }
});
vimfx.set('custom.mode.normal.my_conditional_w', 'w');

vimfx.addCommand({
  name: 'my_conditional_shift_w',
  description: 'Run various commands depending on the current site',
}, (args) => {
  let {vim} = args;
  let hostname = vim.window.gBrowser.selectedBrowser.currentURI.host;
  if (hostname === 'speakerdeck.com') {
    vimfx.send(vim, 'speakerdeck_prev_slide');
  } else if (hostname === 'www.slideshare.net') {
    vimfx.send(vim, 'slideshare_prev_slide');
  }
});
vimfx.set('custom.mode.normal.my_conditional_shift_w', 'W');

vimfx.addCommand({
  name: 'add_cookie_permission',
  description: 'Add cookie permission',
}, (args) => {
  let {vim} = args;
  let origin = new vim.window.URL(vim.browser.currentURI.spec).origin;
  vim._modal('prompt', ['Add cookie permission', origin], (input) => {
    if (input !== null) {
      let manager = Cc['@mozilla.org/permissionmanager;1'].getService(Ci.nsIPermissionManager);
      manager.add(Services.io.newURI(input, null, null), 'cookie', manager.ALLOW_ACTION);
    }
  });
});
vimfx.set('custom.mode.normal.add_cookie_permission', 'go');

vimfx.addCommand({
  name: 'remove_cookie_permission',
  description: 'Remove cookie permission',
}, (args) => {
  let {vim} = args;
  let origin = new vim.window.URL(vim.browser.currentURI.spec).origin;
  vim._modal('prompt', ['Remove cookie permission', origin], (input) => {
    if (input !== null) {
      let manager = Cc['@mozilla.org/permissionmanager;1'].getService(Ci.nsIPermissionManager);
      manager.remove(Services.io.newURI(input, null, null), 'cookie');
    }
  });
});
vimfx.set('custom.mode.normal.remove_cookie_permission', 'gO');
