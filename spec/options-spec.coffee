AtomIncrement = require '../lib/atom-increment'

describe "Atom Increment Package Tests - options", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('atom-increment')

    waitsForPromise ->
      atom.workspace.open()

  describe "* tests on package default options", ->

    it "--> verifies 'orderByClick' default value is 'false'", ->
      expect(atom.packages.isPackageActive("atom-increment")).toBe(false)
      atom.commands.dispatch workspaceElement, 'atom-increment:activate'
      waitsForPromise ->
        activationPromise
      runs ->
        expect(atom.packages.isPackageActive("atom-increment")).toBe(true)
        expect(atom.config.get('atom-increment.orderByClick')).toBe(false)

    it "--> verifies 'incSize' default value is '1'", ->
      expect(atom.packages.isPackageActive("atom-increment")).toBe(false)
      atom.commands.dispatch workspaceElement, 'atom-increment:activate'
      waitsForPromise ->
        activationPromise
      runs ->
        expect(atom.packages.isPackageActive("atom-increment")).toBe(true)
        expect(atom.config.get('atom-increment.incSize')).toBe(1)

    it "--> verifies 'incValue' default value is '0'", ->
      expect(atom.packages.isPackageActive("atom-increment")).toBe(false)
      atom.commands.dispatch workspaceElement, 'atom-increment:activate'
      waitsForPromise ->
        activationPromise
      runs ->
        expect(atom.packages.isPackageActive("atom-increment")).toBe(true)
        expect(atom.config.get('atom-increment.incValue')).toBe(0)

    it "--> verifies 'stringsOfSameSize' default value is 'true'", ->
      expect(atom.packages.isPackageActive("atom-increment")).toBe(false)
      atom.commands.dispatch workspaceElement, 'atom-increment:activate'
      waitsForPromise ->
        activationPromise
      runs ->
        expect(atom.packages.isPackageActive("atom-increment")).toBe(true)
        expect(atom.config.get('atom-increment.stringsOfSameSize')).toBe(true)

    it "--> verifies 'stringsUpperCase' default value is 'false'", ->
      expect(atom.packages.isPackageActive("atom-increment")).toBe(false)
      atom.commands.dispatch workspaceElement, 'atom-increment:activate'
      waitsForPromise ->
        activationPromise
      runs ->
        expect(atom.packages.isPackageActive("atom-increment")).toBe(true)
        expect(atom.config.get('atom-increment.stringsUpperCase')).toBe(false)

    it "--> verifies 'stringsLeftToRight' default value is 'false'", ->
      expect(atom.packages.isPackageActive("atom-increment")).toBe(false)
      atom.commands.dispatch workspaceElement, 'atom-increment:activate'
      waitsForPromise ->
        activationPromise
      runs ->
        expect(atom.packages.isPackageActive("atom-increment")).toBe(true)
        expect(atom.config.get('atom-increment.stringsLeftToRight')).toBe(false)

    it "--> verifies 'stringsMinimumSize' default value is '3'", ->
      expect(atom.packages.isPackageActive("atom-increment")).toBe(false)
      atom.commands.dispatch workspaceElement, 'atom-increment:activate'
      waitsForPromise ->
        activationPromise
      runs ->
        expect(atom.packages.isPackageActive("atom-increment")).toBe(true)
        expect(atom.config.get('atom-increment.stringsMinimumSize')).toBe(3)

  describe "* tests on package when options are changed", ->

    it "--> mod. sequence when 'orderByClick' is set to 'true'", ->
      editor = atom.workspace.getActiveTextEditor()
      editor.insertText("\n\n")
      editor.setCursorScreenPosition([0, 0])
      editor.addCursorAtScreenPosition([1, 0])
      editor.addCursorAtScreenPosition([2, 0])
      changeHandler = jasmine.createSpy('changeHandler')
      editor.onDidChange(changeHandler)
      atom.commands.dispatch workspaceElement, 'atom-increment:incString'
      waitsForPromise ->
        activationPromise
      waitsFor ->
        changeHandler.callCount > 0
      runs ->
        expect(editor.getText()).toEqual "aaa\naab\naac"
        atom.config.set('atom-increment.orderByClick', true)
        editor.selectAll()
        editor.insertText("\n\n")
        editor.setCursorScreenPosition([0, 0])
        editor.addCursorAtScreenPosition([2, 0])
        editor.addCursorAtScreenPosition([1, 0])
        changeHandler = jasmine.createSpy('changeHandler')
        editor.onDidChange(changeHandler)
        atom.commands.dispatch workspaceElement, 'atom-increment:incString'
        waitsForPromise ->
          activationPromise
        waitsFor ->
          changeHandler.callCount > 0
        runs ->
          expect(editor.getText()).toEqual "aaa\naac\naab"

    it "--> mod. sequence when 'incValue' & 'incSize' are changed", ->
      editor = atom.workspace.getActiveTextEditor()
      editor.insertText("\n\n")
      editor.selectAll()
      changeHandler = jasmine.createSpy('changeHandler')
      editor.onDidChange(changeHandler)
      atom.commands.dispatch workspaceElement, 'atom-increment:incNumber'
      waitsForPromise ->
        activationPromise
      waitsFor ->
        changeHandler.callCount > 0
      runs ->
        expect(editor.getText()).toEqual "0\n1\n"
        atom.config.set('atom-increment.incValue', 10)
        atom.config.set('atom-increment.incSize', 2)
        editor.selectAll()
        editor.insertText("\n\n")
        editor.selectAll()
        changeHandler = jasmine.createSpy('changeHandler')
        editor.onDidChange(changeHandler)
        atom.commands.dispatch workspaceElement, 'atom-increment:incNumber'
        waitsForPromise ->
          activationPromise
        waitsFor ->
          changeHandler.callCount > 0
        runs ->
          expect(editor.getText()).toEqual "10\n12\n"

    it "--> mod. sequence when 'stringsUpperCase' is set to 'true'", ->
      editor = atom.workspace.getActiveTextEditor()
      editor.insertText("\n\n")
      editor.selectAll()
      changeHandler = jasmine.createSpy('changeHandler')
      editor.onDidChange(changeHandler)
      atom.commands.dispatch workspaceElement, 'atom-increment:incString'
      waitsForPromise ->
        activationPromise
      waitsFor ->
        changeHandler.callCount > 0
      runs ->
        expect(editor.getText()).toEqual "aaa\naab\n"
        atom.config.set('atom-increment.stringsUpperCase', true)
        editor.selectAll()
        editor.insertText("\n\n")
        editor.selectAll()
        changeHandler = jasmine.createSpy('changeHandler')
        editor.onDidChange(changeHandler)
        atom.commands.dispatch workspaceElement, 'atom-increment:incString'
        waitsForPromise ->
          activationPromise
        waitsFor ->
          changeHandler.callCount > 0
        runs ->
          expect(editor.getText()).toEqual "AAA\nAAB\n"

    it "--> mod. sequence when 'stringsOfSameSize' & 'stringsMinimumSize'
     are changed ", ->
      editor = atom.workspace.getActiveTextEditor()
      editor.insertText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
      editor.insertText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
      editor.selectAll()
      changeHandler = jasmine.createSpy('changeHandler')
      editor.onDidChange(changeHandler)
      atom.commands.dispatch workspaceElement, 'atom-increment:incString'
      waitsForPromise ->
        activationPromise
      waitsFor ->
        changeHandler.callCount > 0
      runs ->
        expect(editor.getText()).toEqual "aaa\naab\naac\naad\naae\naaf\naag\naah\naai\naaj\naak\naal\naam\naan\naao\naap\naaq\naar\naas\naat\naau\naav\naaw\naax\naay\naaz\naba\nabb\nabc\nabd\n"
        atom.config.set('atom-increment.stringsOfSameSize', false)
        atom.config.set('atom-increment.stringsMinimumSize', 1)
        editor.selectAll()
        editor.insertText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
        editor.insertText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
        editor.selectAll()
        changeHandler = jasmine.createSpy('changeHandler')
        editor.onDidChange(changeHandler)
        atom.commands.dispatch workspaceElement, 'atom-increment:incString'
        waitsForPromise ->
          activationPromise
        waitsFor ->
          changeHandler.callCount > 0
        runs ->
          expect(editor.getText()).toEqual "a\nb\nc\nd\ne\nf\ng\nh\ni\nj\nk\nl\nm\nn\no\np\nq\nr\ns\nt\nu\nv\nw\nx\ny\nz\nba\nbb\nbc\nbd\n"

    it "--> mod. sequence when 'stringsLeftToRight' is set to 'true'", ->
      editor = atom.workspace.getActiveTextEditor()
      editor.insertText("\n\n")
      editor.selectAll()
      changeHandler = jasmine.createSpy('changeHandler')
      editor.onDidChange(changeHandler)
      atom.commands.dispatch workspaceElement, 'atom-increment:incString'
      waitsForPromise ->
        activationPromise
      waitsFor ->
        changeHandler.callCount > 0
      runs ->
        expect(editor.getText()).toEqual "aaa\naab\n"
        atom.config.set('atom-increment.stringsLeftToRight', true)
        editor.selectAll()
        editor.insertText("\n\n")
        editor.selectAll()
        changeHandler = jasmine.createSpy('changeHandler')
        editor.onDidChange(changeHandler)
        atom.commands.dispatch workspaceElement, 'atom-increment:incString'
        waitsForPromise ->
          activationPromise
        waitsFor ->
          changeHandler.callCount > 0
        runs ->
          expect(editor.getText()).toEqual "aaa\nbaa\n"
