vimfx.set('prevent_autofocus', true);

vimfx.set('mode.normal.dev', ';');
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
