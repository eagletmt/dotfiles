window.addEventListener(
  'keypress',
  function (event) {
    function killEvent ()
      (event.preventDefault(), event.stopPropagation());

    if (liberator.mode === modes.COMMAND_LINE && modes.extended === modes.HINTS) {
      let key = events.toString(event);
      if (/^<[CA]/(key)) {
        killEvent();
        let map = mappings.get(modes.COMMAND_LINE, key);
        if (map) {
          map.execute();
        }
      }
    }

    if (liberator.mode === modes.INSERT && modes.extended === modes.MENU) {
      let key = events.toString(event);
      if (key == '<Space>')
        return;
      let map = mappings.get(modes.INSERT, events.toString(event));
      if (map) {
        killEvent();
        map.execute();
      }
    }
  },
  false
);
