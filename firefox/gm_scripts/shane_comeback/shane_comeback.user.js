// ==UserScript==
// @name           shane comeback
// @namespace      http://taizooo.tumblr.com/
// @include        http://www.tumblr.com/*
// @description    Show avatars and Recover images
// @version        0.0.1.2010.10.25
// ==/UserScript==
// via Tumblr Dashboard High-Res Photos : http://userscripts.org/scripts/source/43621.user.js?

(function(){
	function $(selectors, context) {
		return Array.prototype.slice.call((context || document).querySelectorAll(selectors), 0);
	}

	function comebackAvatar(post) {
		var asrc = $('.so_ie_doesnt_treat_this_as_inline script', post)[0].textContent.match(/(http:\/\/[^\/]+\/\w+\.\w+)/)[1];
		if (!asrc)
			return;
		var anc = $('a.post_avatar', post)[0];
		anc.style.backgroundImage = 'url("' + asrc + '")';

		var imgsrc = $('.post_content script', post)[0].textContent.match(/(http:\/\/[^\/]+\/\w+\.\w+)/)[1];
		if (!imgsrc)
			return;
		var img = $('.post_content img.image_thumbnail', post)[0];
		img.src = imgsrc;
	}

	$('#posts')[0].addEventListener('AutoPagerize_DOMNodeInserted', function(e) {
		comebackAvatar(e.target);
	}, false);

	//$('li.post').forEach(comebackAvatar);
})();
