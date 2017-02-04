vimfx.set('prevent_autofocus', true);

vimfx.set('mode.normal.dev', ';');
vimfx.set('mode.normal.stop', '');
vimfx.set('mode.normal.scroll_down', 'j <c-e>');
vimfx.set('mode.normal.scroll_half_page_down', 'J');
vimfx.set('mode.normal.scroll_half_page_up', 'K');
vimfx.set('mode.normal.scroll_left', '<a-l>');
vimfx.set('mode.normal.scroll_page_down', '<space> <c-f>');
vimfx.set('mode.normal.scroll_page_up', '<s-space> <c-b>');
vimfx.set('mode.normal.scroll_right', '<a-h>');
vimfx.set('mode.normal.scroll_up', 'k <c-y>');
vimfx.set('mode.normal.tab_close', 'd');
vimfx.set('mode.normal.tab_restore', 'u');
vimfx.set('mode.normal.tab_select_next', 'gt l');
vimfx.set('mode.normal.tab_select_previous', 'gT h');

vimfx.addKeyOverrides([({hostname, pathname}) => hostname === 'mail.google.com' && pathname.startsWith('/mail/'), ['j', 'k', 'n', 'p', 'o', 'u', 'e', 's', '?']]);
vimfx.addKeyOverrides([({hostname}) => ['fl.wanko.cc', 'reader.livedwango.com'].includes(hostname), ['j', 'k', 'w', 's', 'a', 'v', 'p', 'o']]);
vimfx.addKeyOverrides([({hostname, pathname, search}) => hostname === 'www.pixiv.net' && pathname === '/member_illust.php' && search.includes('mode=medium'), ['b', 'v']]);
vimfx.addKeyOverrides([({hostname, pathname, search}) => hostname === 'www.pixiv.net' && pathname === '/member_illust.php' && search.includes('mode=manga'), ['j', 'k', 'v', 'z', 'b']]);

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

vimfx.addCommand({
  name: 'open_google',
  description: 'Open Google',
  category: 'tabs',
  order: commands.focus_location_bar.order + 1,
}, ({vim}) => {
  let {gURLBar} = vim.window;
  commands.focus_location_bar.run({vim});
  gURLBar.value = 'gs ';
  gURLBar.onInput(new vim.window.KeyboardEvent('input'));
});
vimfx.set('custom.mode.normal.open_google', 'sg');

vimfx.addCommand({
  name: 'open_twitter',
  description: 'Open Twitter',
  category: 'tabs',
  order: commands.focus_location_bar.order + 1,
}, ({vim}) => {
  let {gURLBar} = vim.window;
  commands.focus_location_bar.run({vim});
  gURLBar.value = 'tw ';
  gURLBar.onInput(new vim.window.KeyboardEvent('input'));
});
vimfx.set('custom.mode.normal.open_twitter', 'sk');

vimfx.addCommand({
  name: 'open_alc',
  description: 'Open alc',
  category: 'tabs',
  order: commands.focus_location_bar.order + 1,
}, ({vim}) => {
  let {gURLBar} = vim.window;
  commands.focus_location_bar.run({vim});
  gURLBar.value = 'alc ';
  gURLBar.onInput(new vim.window.KeyboardEvent('input'));
});
vimfx.set('custom.mode.normal.open_alc', 'sa');

vimfx.addCommand({
  name: 'open_bookmarks',
  description: 'Open bookmarks',
  category: 'tabs',
  order: commands.tab_new.order + 1,
}, ({vim}) => {
  commands.tab_new.run({vim});
  vim.window.setTimeout(() => {
    let {gURLBar} = vim.window;
    commands.focus_location_bar.run({vim});
    gURLBar.value = '* ';
    gURLBar.onInput(new vim.window.KeyboardEvent('input'));
  });
});
vimfx.set('custom.mode.normal.open_bookmarks', 'gn');
