//
// subscldr.js
//
// LICENSE: {{{
//   Copyright (c) 2009 snaka<snaka.gml@gmail.com>
//
//     Distributable under the terms of an MIT-style license.
//     http://www.opensource.jp/licenses/mit-license.html
// }}}
//
// PLUGIN INFO: {{{
var PLUGIN_INFO =
<VimperatorPlugin>
  <name>{NAME}</name>
  <description>Adds subscriptions to livedoor Reader/Fastladder in place.</description>
  <description lang="ja">ページ遷移なしでlivedoor ReaderやFastladderにフィードを登録します。</description>
  <minVersion>2.0pre</minVersion>
  <maxVersion>2.3</maxVersion>
  <require type="plugin">_libly.js</require>
  <updateURL>http://svn.coderepos.org/share/lang/javascript/vimperator-plugins/trunk/subscldr.js</updateURL>
  <author mail="snaka.gml@gmail.com" homepage="http://vimperator.g.hatena.ne.jp/snaka72/">snaka</author>
  <license>MIT style license</license>
  <version>0.2.2</version>
  <detail><![CDATA[
    == Subject ==
    Adds subscriptions to livedoor Reader/Fastladder in place.

    == Commands ==
    >||
    :subscldr
    :subscfl
    ||<

  ]]></detail>

  <detail lang="ja"><![CDATA[
    == 概要 ==
    ページ遷移すること無しにlivedoor ReaderやFastladderへのフィードの登録を行います。

    == コマンド ==
    >||
    :subscldr
    :subscfl
    ||<

  ]]></detail>
</VimperatorPlugin>;
// }}}

liberator.plugins.subscldr = (function() {
  // PUBLIC {{{
  var PUBLICS = {
    // TODO:Provide API function.

    // for DEBUG {{{
    //getSubscription: getSubscription,
    //postSubscription: postSubscription,
    //selectFeed: selectFeed
    // }}}
  };

  // }}}
  // COMMAND {{{
  addCommand(
    ["subscldr", "subscrldr"],
    "livedoor Reader",
    "http://reader.livedoor.com/subscribe/"
  );

  addCommand(
    ["subscfl", "subscrfl"],
    "Fastladder",
    "http://fastladder.com/subscribe/"
  );
  // }}}
  // PRIVATE {{{
  function addCommand (command, servicename, endpoint) {

    function handleFeedRequest(opts, redirectUrl, force) {
        try {
          var subscribeInfo = getSubscription(redirectUrl);
        } catch (e if e == "Cannot find subscribe info about this page!") {
          commandline.input(e + " See Page2Feed preview? [y/N]:",
            function(ans) {
              if (ans.toLowerCase().indexOf("y") == 0)
                liberator.open("http://ic.edge.jp/page2feed/preview/" + (redirectUrl || buffer.URI));
              else
                liberator.echo("Canceled.");
              commandline.close();
            }
          );
          return;
        }
        var availableLinks = subscribeInfo.feedlinks.filter(function(info) info[1]);
        var alreadySubscribed = availableLinks.length != subscribeInfo.feedlinks.length;

        if (alreadySubscribed && !force) {
          liberator.echo("This site has already been subscribed. Are you sure to want to add subscription?");
          commandline.input("Add? [y/N]:",
            function(ans) {
              if (ans.toLowerCase().indexOf("y") == 0) // /^y(?:es)?$/.test(ans.toLowerCase())
                handleFeedRequest(opts, null, true);
              else
                liberator.echo("Canceled.");
              commandline.close();
            }
          );
          return;
        }

        if (availableLinks.length == 1) {
          liberator.log("FEED ONLY ONE!!");
          subscribeInfo.feedlinks = [availableLinks[0][0], true];
          postSubscription(subscribeInfo, opts);
        } else {
          liberator.log("SOME FEED AVAILABLE");
          selectFeed( availableLinks.map(function(i) [i[0], i[2]]),
            function(sel) {
              liberator.log("SELECTED FEED:" + sel);
              liberator.echo("Redirected ...");
              var redirectUrl = endpoint + "?url=" + encodeURIComponent(sel);
              handleFeedRequest(opts, redirectUrl);
            }
          );
        }
    }

    function getSubscription(target) {
      liberator.echo("Please wait ...");
      var subscribeInfo;

      var uri = target || endpoint + buffer.URL;

      var req = new libly.Request(uri, null, {asynchronous: false});
      req.addEventListener("onSuccess", function(res) {
        liberator.log(res.responseText);
        res.getHTMLDocument();
        subscribeInfo = getSubscribeInfo(res.doc);
        liberator.log(subscribeInfo.toSource());
      });
      req.get();

      return subscribeInfo;
    }

    function postSubscription(info, opts) {
      liberator.log("subscribe:" + info.toSource());

      var folder_id = "0";
      if (opts.folder && info.folder_ids[opts.folder]) {
        folder_id = info.folder_ids[opts.folder];
      }
      var postBody= "url=" + encodeURIComponent(info.target_url) +
                    "&folder_id=" + folder_id +
                    "&rate=" + (opts.rate || "0") +
                    "&register=1" +
                    "&feedlink=" + encodeURIComponent(info.feedlinks[0]) +
                    "&public=1" +
                    "&ApiKey=" + info.apiKey;

      liberator.log("POST DATA:" + postBody);
      var req = new libly.Request(
        endpoint,
        null,
        {
          asynchronous: true,
          postBody: postBody
        }
      );
      req.addEventListener("onSuccess", function(data) {
        liberator.log("Post status: " + data.responseText);
        liberator.echo("Subscribe feed succeed.");
      });
      req.addEventListener("onFailure", function(data) {
        liberator.log("POST FAILURE: " + data.responseText);
        liberator.echoerr("POST FAILURE: " + data.statusText);
      });

      req.post();
    }

    commands.addUserCommand(
      command,
      "Register feed subscriptions to " + servicename + ".",
      function(args) {
        try {
          handleFeedRequest({rate: args["-rate"], folder: args["-folder"]},
            args[0] ? endpoint + args[0] : undefined);
        } catch (e) {
          liberator.echoerr(e);
        }
      },
      {
        options: [
          [["-rate", "-r"], commands.OPTION_INT],
          [["-folder", "-f"], commands.OPTION_STRING],
        ],
        argCount: '?',
      },
      true  // Use in DEVELOP
    );

  }

  function getSubscribeInfo(htmldoc) {
    var subscribeInfo = {
       target_url: null,
       register: 1,
       apiKey: null,
       feedlinks: [],
       folder_ids: {},
    };

    $LXs('id("feed_candidates")/xhtml:li', htmldoc).forEach( function(item) {
      var feedlink = $LX('./xhtml:a[@class="feedlink"]', item);
      var title = $LX('./xhtml:a[@class="subscribe_list"]', item);
      var users = $LX('./xhtml:span[@class="subscriber_count"]/xhtml:a', item);
      var yet = $LX('./xhtml:input[@name="feedlink"]', item);
      liberator.log("input:" + feedlink.href);
      subscribeInfo.feedlinks.push([feedlink.href, (yet != null), (title ? title.textContent : '' ) + ' / ' + (users ? users.textContent :  '0 user')]);
    });

    var target_url = $LX('id("target_url")', htmldoc);
    if (!target_url) throw "Cannot find subscribe info about this page!";
    subscribeInfo.target_url = target_url.value;
    liberator.log("target_url:" + subscribeInfo.target_url);

    subscribeInfo.apiKey = $LX('//*[@name="ApiKey"]', htmldoc).value;
    if (!subscribeInfo.apiKey) throw "Can't get API key for subscription!";

    var select = $LX('//*[@name="folder_id"]', htmldoc);
    if (!select) throw "Can't get foldr_id";
    $LXs('*', select).forEach( function(item) {
      subscribeInfo.folder_ids[item.innerHTML] = item.value;
    });
    return subscribeInfo;
  }

  function selectFeed(links, next) {
    liberator.log(links.toSource());
    liberator.echo("Following feeds were found on this site. Which are you subscribe?");
    commandline.input("Select or input feed URL ", function(selected) {
      liberator.echo("You select " + selected + ".");
      commandline.close();
      if (next && typeof next == "function")
        next(selected);
      else
        liberator.echoerr("Your selected no is invalid.");
    },{
      completer: function(context) {
        context.title = ["Available feeds", "Title / users"];
        context.completions = links;
      }
    });
    // Open candidates list forcibly
    events.feedkeys("<TAB>");
  }

  // For convenience
  //function $LXs(a,b) libly.$U.getNodesFromXPath(a,b);
  //function $LX(a,b)  libly.$U.getFirstNodeFromXPath(a,b);

  function nsResolver(prefix) {
    var ns = { 'xhtml': 'http://www.w3.org/1999/xhtml' };
    return ns[prefix] || null;
  }

  function $LXs(a, b) {
    var ret = [];
    var res = (b.ownerDocument || b).evaluate(a, b, nsResolver, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
    for (var i = 0; i < res.snapshotLength; i++) {
      ret.push(res.snapshotItem(i));
    }
    return ret;
  }

  function $LX(a, b) {
    var res = (b.ownerDocument || b).evaluate(a, b, nsResolver, XPathResult.FIRST_ORDERED_NODE_TYPE, null);
    return res.singleNodeValue || null;
  }

  // }}}
  return PUBLICS;
})();

// vim:sw=2 ts=2 et si fdm=marker:
