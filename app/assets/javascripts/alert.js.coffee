root = exports ? this # root and window are same thing in browser
root.Alert ?= {}
$ = jQuery

class Alert.Standard

  constructor: (message) ->
    @_element = $("<div></div>", {
      'class': 'alert-box'
      'data-alert': ''
    })
    @_element.append(message)
    closeElement = $('<a/>', {
      'class': 'close'
      'href': '#'
    })
    closeElement.append('&times;')
    @_element.append(closeElement)
    console.log @_element
    $('[role=main]').prepend(@_element)

    @_element.delay(1000).fadeOut('fast');