(function() {
  function getflv(id, next) {
    util.httpGet('http://www.nicovideo.jp/api/getflv?v=' + id, function(xhr) {
      let obj = {};
      xhr.responseText.split('&').forEach(function(p) let ([k,v] = p.split('=')) obj[k] = decodeURIComponent(v));
      next(obj);
    });
  }

  commands.addUserCommand(['nicod[ownload]'], 'download this video',
    function(args) {
      let m = buffer.URI.match(/watch\/(\w+)/);
      if (!m) {
        return;
      }
      let id = m[1];
      getflv(id, function(obj) {
        let uri = makeURI(obj.url);
        let dm = services.get('downloadManager');
        let file = liberator.globalVariables.nico_save_dir
          ? io.File(liberator.globalVariables.nico_save_dir)
          : dm.userDownloadsDirectory;
        if (!file.exists() || !file.isDirectory()) {
          file.create(Ci.nsIFile.DIRECTORY_TYPE, 0777);
        }
        file.appendRelativePath(id + '.flv');
        let fileUri = makeFileURI(file);

        let persist = makeWebBrowserPersist();
        let download = dm.addDownload(0, uri, fileUri, name, null, null, null, null, persist);
        persist.progressListener = download;
        persist.saveURI(uri, null, null, null, null, file);

        liberator.echo('download to ' + file.path);
      });
    },
    {
      argCount: '0',
      completer: completion.file,
    }, true);
})();

// vim: et sw=2 ts=2 sts=2:

