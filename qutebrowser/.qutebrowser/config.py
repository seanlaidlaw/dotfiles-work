## Always restore open sites when qutebrowser is reopened.
## Type: Bool
c.auto_save.session = True


## Whether quitting the application requires a confirmation.
## Type: ConfirmQuit
## Valid values:
##   - always: Always show a confirmation.
##   - multiple-tabs: Show a confirmation if multiple tabs are opened.
##   - downloads: Show a confirmation if downloads are running
##   - never: Never show a confirmation.
c.confirm_quit = ['always']


## Enable smooth scrolling for web pages. Note smooth scrolling does not
## work with the `:scroll-px` command.
## Type: Bool
c.scrolling.smooth = True

## When to show the tab bar.
## Type: String
## Valid values:
##   - always: Always show the tab bar.
##   - never: Always hide the tab bar.
##   - multiple: Hide the tab bar if only one tab is open.
##   - switching: Show the tab bar when switching tabs.
c.tabs.show = 'switching'

## Definitions of search engines which can be used via the address bar.
## Maps a searchengine name (such as `DEFAULT`, or `ddg`) to a URL with a
## `{}` placeholder. The placeholder will be replaced by the search term,
## use `{{` and `}}` for literal `{`/`}` signs. The searchengine named
## `DEFAULT` is used when `url.auto_search` is turned on and something
## else than a URL was entered to be opened. Other search engines can be
## used by prepending the search engine name to the search term, e.g.
## `:open google qutebrowser`.
## Type: Dict
c.url.searchengines = {
        'DEFAULT': 'https://www.google.co.uk/search?q={}',
        'gfr': 'https://www.google.fr/search?q={}',
        'gs': 'https://scholar.google.com/scholar?hl=en&q={}',
        'gtf': 'https://translate.google.com/#view=home&op=translate&sl=auto&tl=fr&text={}',
        'gte': 'https://translate.google.com/#view=home&op=translate&sl=fr&tl=en&text={}',
        'gi': 'https://www.google.com/search?tbm=isch&q={}',
        'gia': 'https://www.google.com/search?as_st=y&tbm=isch&q={}+site%3Aaudible.com+OR+site%3Akobo.com',
        'w': 'https://en.wikipedia.org/w/index.php?search={}',
        'wfr': 'https://fr.wikipedia.org/w/index.php?search={}',
        'doi': 'dx.doi.org/{}',
        'ss': 'https://www.semanticscholar.org/search?q={}&sort=relevance',
        'lib': 'https://biu-montpellier.hosted.exlibrisgroup.com/primo-explore/search?query=any,contains,{}&tab=default_tab&search_scope=default_scope&vid=33UM_VU1',
        'am': 'https://www.amazon.fr/s/field-keywords={}',
        'sh': 'https://sci-hub.tw/{}',
        'wa': 'https://www.wolframalpha.com/input/?i={}',
        'yt': 'https://www.youtube.com/results?search_query={}',
        'lg': 'http://libgen.io/search.php?req={}',
        'tpb': 'https://thepiratebay.org/search/{}/0/99/0',
        'bh': 'https://duckduckgo.com/?q={}+site%3Abiblehub.com+%22Strong%27s+Hebrew%22&ia=web',
        'z': 'https://torrents.me/s/{}:zooqle'
}

## Bindings for normal mode
config.bind('d', 'scroll-page 0 0.5')
config.bind('<Ctrl-w>', 'set content.user_stylesheets "";; set colors.webpage.bg white""')
config.bind('<Ctrl-e>', 'set content.user_stylesheets "" ;; set colors.webpage.bg #002b36 ;; set content.user_stylesheets solarized-dark.css')
config.bind('<Ctrl-r>', 'set content.user_stylesheets "" ;; set content.user_stylesheets  wikipedia_custom.css')
config.bind('<Ctrl-t>', 'set content.user_stylesheets "" ;; set content.user_stylesheets  pubmed_custom.css')

config.bind('<Ctrl-p>', 'set content.pdfjs false')
config.bind('<F1>', 'spawn --userscript unpaywall')
config.bind('<F2>', 'spawn --userscript getbib')
config.bind('<F5>', 'spawn --userscript readability')
config.bind('ZZ', 'quit --save')
config.bind('x', 'tab-close')

# Use custom dark solarized theme
c.content.user_stylesheets = [
    'solarized-dark.css',
    'custom_solarized.css'
]

solarized = {
    'base03': '#002b36',
    'base02': '#073642',
    'base01': '#586e75',
    'base00': '#657b83',
    'base0': '#839496',
    'base1': '#93a1a1',
    'base2': '#eee8d5',
    'base3': '#fdf6e3',
    'yellow': '#b58900',
    'orange': '#cb4b16',
    'red': '#dc322f',
    'magenta': '#d33682',
    'violet': '#6c71c4',
    'blue': '#268bd2',
    'cyan': '#2aa198',
    'green': '#859900'
}

## Background color of the completion widget category headers.
## Type: QssColor
c.colors.completion.category.bg = solarized['base03']

## Bottom border color of the completion widget category headers.
## Type: QssColor
c.colors.completion.category.border.bottom = solarized['base03']

## Top border color of the completion widget category headers.
## Type: QssColor
c.colors.completion.category.border.top = solarized['base03']

## Foreground color of completion widget category headers.
## Type: QtColor
c.colors.completion.category.fg = solarized['base3']

## Background color of the completion widget for even rows.
## Type: QssColor
c.colors.completion.even.bg = solarized['base02']

## Text color of the completion widget.
## Type: QtColor
c.colors.completion.fg = solarized['base3']

## Background color of the selected completion item.
## Type: QssColor
c.colors.completion.item.selected.bg = solarized['violet']

## Bottom border color of the selected completion item.
## Type: QssColor
c.colors.completion.item.selected.border.bottom = solarized['violet']

## Top border color of the completion widget category headers.
## Type: QssColor
c.colors.completion.item.selected.border.top = solarized['violet']

## Foreground color of the selected completion item.
## Type: QtColor
c.colors.completion.item.selected.fg = solarized['base3']

## Foreground color of the matched text in the completion.
## Type: QssColor
c.colors.completion.match.fg = solarized['base2']

## Background color of the completion widget for odd rows.
## Type: QssColor
c.colors.completion.odd.bg = solarized['base02']

## Color of the scrollbar in completion view
## Type: QssColor
c.colors.completion.scrollbar.bg = solarized['base0']

## Color of the scrollbar handle in completion view.
## Type: QssColor
c.colors.completion.scrollbar.fg = solarized['base2']

## Background color for the download bar.
## Type: QssColor
c.colors.downloads.bar.bg = solarized['base03']

## Background color for downloads with errors.
## Type: QtColor
c.colors.downloads.error.bg = solarized['red']

## Foreground color for downloads with errors.
## Type: QtColor
c.colors.downloads.error.fg = solarized['base3']

## Color gradient start for download backgrounds.
## Type: QtColor
# c.colors.downloads.start.bg = '#0000aa'

## Color gradient start for download text.
## Type: QtColor
c.colors.downloads.start.fg = solarized['base3']

## Color gradient stop for download backgrounds.
## Type: QtColor
# c.colors.downloads.stop.bg = '#00aa00'

## Color gradient end for download text.
## Type: QtColor
# c.colors.downloads.stop.fg = solarized['base3']

## Color gradient interpolation system for download backgrounds.
## Type: ColorSystem
## Valid values:
##   - rgb: Interpolate in the RGB color system.
##   - hsv: Interpolate in the HSV color system.
##   - hsl: Interpolate in the HSL color system.
##   - none: Don't show a gradient.
# c.colors.downloads.system.bg = 'rgb'

## Color gradient interpolation system for download text.
## Type: ColorSystem
## Valid values:
##   - rgb: Interpolate in the RGB color system.
##   - hsv: Interpolate in the HSV color system.
##   - hsl: Interpolate in the HSL color system.
##   - none: Don't show a gradient.
# c.colors.downloads.system.fg = 'rgb'

## Background color for hints. Note that you can use a `rgba(...)` value
## for transparency.
## Type: QssColor
c.colors.hints.bg = solarized['violet']

## Font color for hints.
## Type: QssColor
c.colors.hints.fg = solarized['base3']

## Font color for the matched part of hints.
## Type: QssColor
c.colors.hints.match.fg = solarized['base2']

## Background color of the keyhint widget.
## Type: QssColor
# c.colors.keyhint.bg = 'rgba(0, 0, 0, 80%)'

## Text color for the keyhint widget.
## Type: QssColor
c.colors.keyhint.fg = solarized['base3']

## Highlight color for keys to complete the current keychain.
## Type: QssColor
c.colors.keyhint.suffix.fg = solarized['yellow']

## Background color of an error message.
## Type: QssColor
c.colors.messages.error.bg = solarized['red']

## Border color of an error message.
## Type: QssColor
c.colors.messages.error.border = solarized['red']

## Foreground color of an error message.
## Type: QssColor
c.colors.messages.error.fg = solarized['base3']

## Background color of an info message.
## Type: QssColor
c.colors.messages.info.bg = solarized['base03']

## Border color of an info message.
## Type: QssColor
c.colors.messages.info.border = solarized['base03']

## Foreground color an info message.
## Type: QssColor
c.colors.messages.info.fg = solarized['base3']

## Background color of a warning message.
## Type: QssColor
c.colors.messages.warning.bg = solarized['orange']

## Border color of a warning message.
## Type: QssColor
c.colors.messages.warning.border = solarized['orange']

## Foreground color a warning message.
## Type: QssColor
c.colors.messages.warning.fg = solarized['base3']

## Background color for prompts.
## Type: QssColor
c.colors.prompts.bg = solarized['base02']

## Border used around UI elements in prompts.
## Type: String
c.colors.prompts.border = '1px solid ' + solarized['base3']

## Foreground color for prompts.
## Type: QssColor
c.colors.prompts.fg = solarized['base3']

## Background color for the selected item in filename prompts.
## Type: QssColor
c.colors.prompts.selected.bg = solarized['base01']

## Background color of the statusbar in caret mode.
## Type: QssColor
c.colors.statusbar.caret.bg = solarized['blue']

## Foreground color of the statusbar in caret mode.
## Type: QssColor
c.colors.statusbar.caret.fg = solarized['base3']

## Background color of the statusbar in caret mode with a selection.
## Type: QssColor
c.colors.statusbar.caret.selection.bg = solarized['violet']

## Foreground color of the statusbar in caret mode with a selection.
## Type: QssColor
c.colors.statusbar.caret.selection.fg = solarized['base3']

## Background color of the statusbar in command mode.
## Type: QssColor
c.colors.statusbar.command.bg = solarized['base03']

## Foreground color of the statusbar in command mode.
## Type: QssColor
c.colors.statusbar.command.fg = solarized['base3']

## Background color of the statusbar in private browsing + command mode.
## Type: QssColor
c.colors.statusbar.command.private.bg = solarized['base01']

## Foreground color of the statusbar in private browsing + command mode.
## Type: QssColor
c.colors.statusbar.command.private.fg = solarized['base3']

## Background color of the statusbar in insert mode.
## Type: QssColor
c.colors.statusbar.insert.bg = solarized['green']

## Foreground color of the statusbar in insert mode.
## Type: QssColor
c.colors.statusbar.insert.fg = solarized['base3']

## Background color of the statusbar.
## Type: QssColor
c.colors.statusbar.normal.bg = solarized['base03']

## Foreground color of the statusbar.
## Type: QssColor
c.colors.statusbar.normal.fg = solarized['base3']

## Background color of the statusbar in passthrough mode.
## Type: QssColor
c.colors.statusbar.passthrough.bg = solarized['magenta']

## Foreground color of the statusbar in passthrough mode.
## Type: QssColor
c.colors.statusbar.passthrough.fg = solarized['base3']

## Background color of the statusbar in private browsing mode.
## Type: QssColor
c.colors.statusbar.private.bg = solarized['base01']

## Foreground color of the statusbar in private browsing mode.
## Type: QssColor
c.colors.statusbar.private.fg = solarized['base3']

## Background color of the progress bar.
## Type: QssColor
c.colors.statusbar.progress.bg = solarized['base3']

## Foreground color of the URL in the statusbar on error.
## Type: QssColor
c.colors.statusbar.url.error.fg = solarized['red']

## Default foreground color of the URL in the statusbar.
## Type: QssColor
c.colors.statusbar.url.fg = solarized['base3']

## Foreground color of the URL in the statusbar for hovered links.
## Type: QssColor
c.colors.statusbar.url.hover.fg = solarized['base2']

## Foreground color of the URL in the statusbar on successful load
## (http).
## Type: QssColor
c.colors.statusbar.url.success.http.fg = solarized['base3']

## Foreground color of the URL in the statusbar on successful load
## (https).
## Type: QssColor
c.colors.statusbar.url.success.https.fg = solarized['base3']

## Foreground color of the URL in the statusbar when there's a warning.
## Type: QssColor
c.colors.statusbar.url.warn.fg = solarized['yellow']

## Background color of the tab bar.
## Type: QtColor
# c.colors.tabs.bar.bg = '#555555'

## Background color of unselected even tabs.
## Type: QtColor
c.colors.tabs.even.bg = solarized['base01']

## Foreground color of unselected even tabs.
## Type: QtColor
c.colors.tabs.even.fg = solarized['base2']

## Color for the tab indicator on errors.
## Type: QtColor
c.colors.tabs.indicator.error = solarized['red']

## Color gradient start for the tab indicator.
## Type: QtColor
c.colors.tabs.indicator.start = solarized['violet']

## Color gradient end for the tab indicator.
## Type: QtColor
c.colors.tabs.indicator.stop = solarized['orange']

## Color gradient interpolation system for the tab indicator.
## Type: ColorSystem
## Valid values:
##   - rgb: Interpolate in the RGB color system.
##   - hsv: Interpolate in the HSV color system.
##   - hsl: Interpolate in the HSL color system.
##   - none: Don't show a gradient.
# c.colors.tabs.indicator.system = 'rgb'

## Background color of unselected odd tabs.
## Type: QtColor
# c.colors.tabs.odd.bg = solarized['base01']

# ## Foreground color of unselected odd tabs.
# ## Type: QtColor
# c.colors.tabs.odd.fg = solarized['base2']

# ## Background color of selected even tabs.
# ## Type: QtColor
# c.colors.tabs.selected.even.bg = solarized['base01']
c.colors.tabs.selected.even.bg = '#000'

# ## Foreground color of selected even tabs.
# ## Type: QtColor
c.colors.tabs.selected.even.fg = solarized['base3']

# ## Background color of selected odd tabs.
# ## Type: QtColor
# c.colors.tabs.selected.odd.bg = solarized['base01']
c.colors.tabs.selected.odd.bg = '#000'

# ## Foreground color of selected odd tabs.
# ## Type: QtColor
c.colors.tabs.selected.odd.fg = solarized['base3']

## Background color for webpages if unset (or empty to use the theme's
## color)
## Type: QtColor
# stop whtie screen between pagees loading
c.colors.webpage.bg = '#002b36'
