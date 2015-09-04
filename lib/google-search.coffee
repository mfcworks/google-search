{CompositeDisposable} = require 'atom'
shell = require 'shell'

module.exports = GoogleSearch =
  subscriptions: null
  URL: ''

  config:
    URL:
      title: 'URL'
      description: 'Substitute search keyword in address with %s'
      type: 'string'
      default: 'https://www.google.com/#q=%s'

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'google-search:search': => @search()

    # Configuration
    @URL = atom.config.get('google-search.URL')

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->

  search: ->
#    console.log 'google-search:search'
    if editor = atom.workspace.getActiveTextEditor()
      selected = editor.getSelectedText()

      searchURL = @URL.replace /%s/, encodeURIComponent(selected.replace(/\n/g, ' '))
      shell.openExternal searchURL
