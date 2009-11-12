function! metarw#hatena#complete(arglead, cmdline, cursorpos)
  return []
endfunction

function! metarw#hatena#read(fakepath)
  return ["error", "read not supported"]
endfunction

function! metarw#hatena#write(fakepath, line1, line2, append_p)
  let l = split(a:fakepath, ':')
  if len(l) == 2
    let [schema, user] = l
    let base = 'http://d.hatena.ne.jp/' . user
    let outenc = 'EUC-JP'
  elseif len(l) == 3
    let [schema, group, user] = l
    let base = printf('http://%s.g.hatena.ne.jp/%s', group, user)
    let outenc = 'UTF-8'
  else
    return ['error', 'invalid fakepath']
  endif
  let pass = inputsecret('Password: ')

  let cookie_file = tempname()
  let content = system(printf('curl --silent -k -c %s https://www.hatena.ne.jp/login -d name=%s -d password=%s -d mode=enter', cookie_file, user, pass))
  if match(content, '<div class="error-message">') != -1
    return ['error', 'login failed']
  endif

  if filereadable(cookie_file)
    let json = system(printf('curl --silent -b %s "%s/?mode=json"', cookie_file, base))
    let rkm = matchstr(json, '"rkm":"\zs.*\ze"')

    let body = iconv(join(getline(a:line1, a:line2), "\n"), &encoding, outenc)
    let time = localtime()
    let result = system(printf('curl -b %s --silent %s/edit -F mode=enter -F timestamp=%d -F rkm=%s -F year=%s -F month=%s -F day=%s -F body="%s"', cookie_file, base, time, rkm, strftime('%Y', time), strftime('%m', time), strftime('%d', time), body))

    if delete(cookie_file) == 0
      return ['done', '']
    else
      return ['error', printf('failed to delete temporary file %s', cookie_file)]
    endif
  else
    return ["error", printf("%s is not readable!", cookie_file)]
  endif
endfunction

