(function() {
  const FORMAT_INFO = {
    5: {
      desc: 'flv1+mp3 360p',
      ext: 'flv',
    },
    18: {
      desc: 'h264+aac 360p',
      ext: 'mp4',
    },
    22: {
      desc: 'h264+aac 720p',
      ext: 'mp4',
    },
    34: {
      desc: 'h264+aac 360p',
      ext: 'flv',
    },
    35: {
      desc: 'h264+aac 480p',
      ext: 'flv',
    },
    37: {
      desc: 'h264+aac 1080p',
      ext: 'mp4',
    },
  };

  commands.addUserCommand(['ytd[ownload]'], 'download this video',
    function(args) {
      let yt = content.wrappedJSObject.yt;
      let video_id = yt.getConfig('VIDEO_ID');
      let t = yt.getConfig('SWF_ARGS').t;
      let title = args.literalArg || yt.getConfig('VIDEO_TITLE');
      title = title.replace(/[\/\\]/, '_');
      let fmt = args['-fmt'] || available_formats()[0];

      let uri = makeURI('http://www.youtube.com/get_video?fmt=' + fmt + '&video_id=' + video_id + '&t=' + t);
      let file = io.File(liberator.globalVariables.yt_save_dir || '~');
      if (!file.exists() || !file.isDirectory()) {
        file.create(Ci.nsIFile.DIRECTORY_TYPE, 0777);
      }
      let name = title + '.' + FORMAT_INFO[fmt].ext;
      file.appendRelativePath(name);
      let fileUri = makeFileURI(file);

      let persist = makeWebBrowserPersist();
      let dm = services.get('downloadManager');
      let download = dm.addDownload(0, uri, fileUri, name, null, null, null, null, persist);
      persist.progressListener = download;
      persist.saveURI(uri, null, null, null, null, file);

      liberator.echo('download to ' + file.path + ' with fmt=' + fmt);
    },
    {
      literal: 0,
      options: [
        [['-fmt', '-f'], commands.OPTION_INT, null, fmt_completer],
      ],
      completer: function(context, args) {
        context.title = ['filename'];
        context.completions = [[content.wrappedJSObject.yt.getConfig('VIDEO_TITLE'), 'title']];
      },
    }, true);

  function available_formats()
    content.wrappedJSObject.yt.getConfig('SWF_ARGS').fmt_url_map.split('%2C').map(function(u) u.split('%7C')[0]);

  function fmt_completer(context, args)
    [[f, FORMAT_INFO[f].desc + ' (' + FORMAT_INFO[f].ext + ')']
        for each(f in available_formats())];
})();

// vim: et sw=2 ts=2 sts=2:

