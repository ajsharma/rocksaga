root = exports ? this # root and window are same thing in browser
root.Utils ?= {}

#
# Utils
#
Utils.createTag = (type, id, className, left, top, width, height) ->
  tag = document.createElement(type)
  tag.id = id
  tag.className = className
  tag.style.left = String(left) + "px"
  tag.style.top = String(top) + "px"
  tag.style.width = String(width) + "px"
  tag.style.height = String(height) + "px"
  tag  
  
Utils.createDiv = (id, className, left, top, width, height) ->
  div = document.createElement("div")
  div.id = id
  div.className = className
  div.style.left = String(left) + "px"
  div.style.top = String(top) + "px"
  div.style.width = String(width) + "px"
  div.style.height = String(height) + "px"
  div

Utils.createLi = (id, className, left, top, width, height) ->
  li = document.createElement("li")
  li.id = id
  li.className = className
  li.style.left = String(left) + "px"
  li.style.top = String(top) + "px"
  li.style.width = String(width) + "px"
  li.style.height = String(height) + "px"
  li  

Utils.createImg = (id, className, zIndex, left, top, width, height, src) ->
  img = document.createElement("img")
  img.id = id
  img.className = className
  img.style.zIndex = zIndex
  img.style.left = String(left) + "px"
  img.style.top = String(top) + "px"
  img.style.width = String(width) + "px"
  img.style.height = String(height) + "px"
  img.src = src
  img

Utils.getMouseObject = (e) ->
  (if e then e.target else window.event.srcElement)

Utils.getMouseX = (e) ->
  (if e then e.clientX else window.event.clientX)

Utils.getMouseY = (e) ->
  (if e then e.clientY else window.event.clientY)

Utils.pxToNumber = (s) ->
  Number s.substring(0, s.length - 2)
