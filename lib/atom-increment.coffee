{CompositeDisposable} = require 'atom'

module.exports = AtomIncrement =
  subscriptions: null

  config:
    orderByClick:
      type: 'boolean'
      default: false
      description: 'general : follows click order or not'
    incSize:
      type: 'integer'
      default: 1
      minimum: 1
      description: 'incNumber : Increment amount between 2 consecutive values'
    incValue:
      type: 'integer'
      default: 0
      minimum: 0
      description: 'incNumber : Increment start value'
    stringsOfSameSize:
      type: 'boolean'
      default: true
      description: 'incString : are string increment the same size or not'
    stringsUpperCase:
      type: 'boolean'
      default: false
      description: 'incString : are string increment in uppercase'
    stringsLeftToRight:
      type: 'boolean'
      default: false
      description: 'incString : are string increment read from left to right'
    stringsMinimumSize:
      type: 'integer'
      default: 3
      minimum: 1
      description: 'incString : minimum size of string, only used when
       stringsOfSameSize=true'


  activate: ->
    # Events subscribed to in atom's system can be cleaned up with this
    @subscriptions = new CompositeDisposable

    # Register commands
    @subscriptions.add atom.commands.add 'atom-workspace',
      'atom-increment:incNumber': => @increment('number')
    @subscriptions.add atom.commands.add 'atom-workspace',
      'atom-increment:incString': => @increment('string')
    @subscriptions.add atom.commands.add 'atom-workspace',
      'atom-increment:activate': => @fakeActivate()

  deactivate: ->
    @subscriptions.dispose()


  fakeActivate: ->
    return ""


  increment: (type) ->
    if (type != "number" && type != "string")
      console.log "Error -- increment type unknown -- skipping"
    else
      if editor = atom.workspace.getActiveTextEditor()
        isSameSize = atom.config.get('atom-increment.stringsOfSameSize')
        isUpperCase = atom.config.get('atom-increment.stringsUpperCase')
        isFromLeftToRight = atom.config.get('atom-increment.stringsLeftToRight')
        minStringSize = atom.config.get('atom-increment.stringsMinimumSize')
        orderByClick = atom.config.get('atom-increment.orderByClick')

        if (type == "number")
          incValue = atom.config.get('atom-increment.incValue')
          incSize = atom.config.get('atom-increment.incSize')
        else if (type == "string")
          incValue = 0
          incSize = 1

        selectionList = []
        if (!orderByClick)
          selectionList = editor.getSelectionsOrderedByBufferPosition()
        else
          selectionList = editor.getSelections()

        checkpoint = editor.createCheckpoint()

        for i in [0..selectionList.length-1]
          if (type == 'number')
            result = incValue.toString()
          else if (type == 'string')
            result = @convertIntegerToString(incValue.toString(), isUpperCase,
             isFromLeftToRight, minStringSize, isSameSize)

          sel = selectionList[i]
          lineList = sel.getText().split(/\n/)
          nbLines = lineList.length
          if (nbLines > 1)
            for j in [1..nbLines-1]
              incValue = incValue + incSize
              if !(j == nbLines-1 && lineList[j] == "")
                if (type == 'number')
                  result = result + '\n' + incValue.toString()
                else if (type == 'string')
                  result = result + '\n' + @convertIntegerToString(incValue.
                   toString(), isUpperCase, isFromLeftToRight, minStringSize,
                   isSameSize)

              if (j == nbLines-1)
                result = result + '\n'
          else
            incValue = incValue + incSize

          sel.insertText(result)

        editor.groupChangesSinceCheckpoint(checkpoint)


  convertIntegerToString: (num, isUpper, readL2R, minSize, sameSize) ->
    base26 = (num >>> 0).toString(26)
    value = ''
    for m in [0..base26.length-1]
      value = @getReturnValue(value, isUpper, readL2R, base26[m])

    if (sameSize)
      if (minSize > value.length)
        for n in [0..minSize-value.length-1]
          value = @getReturnValue(value, isUpper, !readL2R, '0')

    return value


  getReturnValue: (currentValue, isUpper, readL2R, ind) ->
    tabCharLower = {
      '0':'a', '1':'b', '2':'c', '3':'d', '4':'e', '5':'f', '6':'g', '7':'h',
      '8':'i', '9':'j', 'a':'k', 'b':'l', 'c':'m', 'd':'n', 'e':'o', 'f':'p',
      'g':'q', 'h':'r', 'i':'s', 'j':'t', 'k':'u', 'l':'v', 'm':'w', 'n':'x',
      'o':'y', 'p':'z'
    }
    tabCharUpper = {
      '0':'A', '1':'B', '2':'C', '3':'D', '4':'E', '5':'F', '6':'G', '7':'H',
      '8':'I', '9':'J', 'a':'K', 'b':'L', 'c':'M', 'd':'N', 'e':'O', 'f':'P',
      'g':'Q', 'h':'R', 'i':'S', 'j':'T', 'k':'U', 'l':'V', 'm':'W', 'n':'X',
      'o':'Y', 'p':'Z'
    }
    returnValue = ''

    if (isUpper)
      if (!readL2R)
        returnValue = currentValue + tabCharUpper[ind]
      else
        returnValue = tabCharUpper[ind] + currentValue
    else
      if (!readL2R)
        returnValue = currentValue + tabCharLower[ind]
      else
        returnValue = tabCharLower[ind] + currentValue

    return returnValue
