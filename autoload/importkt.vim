let s:importCacheLocation = $HOME . '/.import.lib'
let s:inspectCacheLocation = $HOME . '/.import.src'

fu! s:addLineToBuffer(line)
  if !search(a:line)
    call appendbufline(bufnr(), 2, a:line)
  end
endfu

fu! s:handler(line)
  call s:addLineToBuffer(a:line)
endfu


fu! importkt#import()
  if !filereadable(s:importCacheLocation)
    return []
  endif

  let s:cacheList = readfile(s:importCacheLocation)
  let word = expand('<cword>')
  let matches = []

  call system("rg -U --with-filename -t kotlin package > " . s:inspectCacheLocation)
  let s:inspectList = readfile(s:inspectCacheLocation)
  for inspect in s:inspectList
    let names = split(split(inspect, "/")[-1], ":")
    let classname = split(names[0], '\.')[0]
    if word == classname
      call add(matches, substitute(names[1], "package", "import", "") . "." . classname)
    endif
  endfor

  for line in s:cacheList
    if word == split(line, '\.')[-1]
      call add(matches, line)
    endif
  endfor
  
  if (len(matches) == 1)
    call s:addLineToBuffer(matches[0])
  else
    call fzf#run(fzf#wrap({'source': matches, 'sink': function('s:handler') }))
  end
endfu
