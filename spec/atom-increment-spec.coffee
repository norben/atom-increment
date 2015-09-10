AtomIncrement = require '../lib/atom-increment'

describe "Atom Increment Package Tests", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('atom-increment')

    waitsForPromise ->
      atom.workspace.open()

  describe "* Tests on 'incNumber' feature", ->

    describe "- tests on selection", ->

      it "--> increments numbers from 'selection' : 1 empty line", ->
        editor = atom.workspace.getActiveTextEditor()
        editor.insertText("")
        editor.selectAll()
        changeHandler = jasmine.createSpy('changeHandler')
        editor.onDidChange(changeHandler)
        atom.commands.dispatch workspaceElement, 'atom-increment:incNumber'
        waitsForPromise ->
          activationPromise
        waitsFor ->
          changeHandler.callCount > 0
        runs ->
          expect(editor.getText()).toEqual "0"

      it "--> increments numbers from 'selection' : 1 line of text", ->
        editor = atom.workspace.getActiveTextEditor()
        editor.insertText("lorem")
        editor.selectAll()
        changeHandler = jasmine.createSpy('changeHandler')
        editor.onDidChange(changeHandler)
        atom.commands.dispatch workspaceElement, 'atom-increment:incNumber'
        waitsForPromise ->
          activationPromise
        waitsFor ->
          changeHandler.callCount > 0
        runs ->
          expect(editor.getText()).toEqual "0"

      it "--> increments numbers from 'selection' : 2 empty lines", ->
        editor = atom.workspace.getActiveTextEditor()
        editor.insertText("\n")
        editor.selectAll()
        changeHandler = jasmine.createSpy('changeHandler')
        editor.onDidChange(changeHandler)
        atom.commands.dispatch workspaceElement, 'atom-increment:incNumber'
        waitsForPromise ->
          activationPromise
        waitsFor ->
          changeHandler.callCount > 0
        runs ->
          expect(editor.getText()).toEqual "0\n"

      it "--> increments numbers from 'selection' : 2 lines of text", ->
        editor = atom.workspace.getActiveTextEditor()
        editor.insertText("lorem\nipsum")
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

      it "--> increments numbers from 'selection' : 3 empty lines", ->
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

      it "--> increments numbers from 'selection' : 3 lines of text", ->
        editor = atom.workspace.getActiveTextEditor()
        editor.insertText("lorem\nipsum\ndolor")
        editor.selectAll()
        changeHandler = jasmine.createSpy('changeHandler')
        editor.onDidChange(changeHandler)
        atom.commands.dispatch workspaceElement, 'atom-increment:incNumber'
        waitsForPromise ->
          activationPromise
        waitsFor ->
          changeHandler.callCount > 0
        runs ->
          expect(editor.getText()).toEqual "0\n1\n2\n"

    describe "- tests on multiple cursors", ->

      it "--> increments numbers from 'multiple cursors' : 2 empty lines", ->
        editor = atom.workspace.getActiveTextEditor()
        editor.insertText("\n")
        editor.setCursorScreenPosition([0, 0])
        editor.addCursorAtScreenPosition([1, 0])
        expect(editor.getCursors().length).toBe 2
        changeHandler = jasmine.createSpy('changeHandler')
        editor.onDidChange(changeHandler)
        atom.commands.dispatch workspaceElement, 'atom-increment:incNumber'
        waitsForPromise ->
          activationPromise
        waitsFor ->
          changeHandler.callCount > 0
        runs ->
          expect(editor.getText()).toEqual "0\n1"

      it "--> increments numbers from 'multiple cursors' : 2 lines of text", ->
        editor = atom.workspace.getActiveTextEditor()
        editor.insertText("lorem\nipsum")
        editor.setCursorScreenPosition([0, 0])
        editor.addCursorAtScreenPosition([1, 0])
        expect(editor.getCursors().length).toBe 2
        changeHandler = jasmine.createSpy('changeHandler')
        editor.onDidChange(changeHandler)
        atom.commands.dispatch workspaceElement, 'atom-increment:incNumber'
        waitsForPromise ->
          activationPromise
        waitsFor ->
          changeHandler.callCount > 0
        runs ->
          expect(editor.getText()).toEqual "0lorem\n1ipsum"

  describe "* Tests on 'incString' feature", ->

    describe "- tests on selection", ->

      it "--> increments strings from 'selection' : 1 empty line", ->
        editor = atom.workspace.getActiveTextEditor()
        editor.insertText("")
        editor.selectAll()
        changeHandler = jasmine.createSpy('changeHandler')
        editor.onDidChange(changeHandler)
        atom.commands.dispatch workspaceElement, 'atom-increment:incString'
        waitsForPromise ->
          activationPromise
        waitsFor ->
          changeHandler.callCount > 0
        runs ->
          expect(editor.getText()).toEqual "aaa"

      it "--> increments strings from 'selection' : 1 line of text", ->
        editor = atom.workspace.getActiveTextEditor()
        editor.insertText("lorem")
        editor.selectAll()
        changeHandler = jasmine.createSpy('changeHandler')
        editor.onDidChange(changeHandler)
        atom.commands.dispatch workspaceElement, 'atom-increment:incString'
        waitsForPromise ->
          activationPromise
        waitsFor ->
          changeHandler.callCount > 0
        runs ->
          expect(editor.getText()).toEqual "aaa"

      it "--> increments numbers from 'selection' : 2 empty lines", ->
        editor = atom.workspace.getActiveTextEditor()
        editor.insertText("\n")
        editor.selectAll()
        changeHandler = jasmine.createSpy('changeHandler')
        editor.onDidChange(changeHandler)
        atom.commands.dispatch workspaceElement, 'atom-increment:incString'
        waitsForPromise ->
          activationPromise
        waitsFor ->
          changeHandler.callCount > 0
        runs ->
          expect(editor.getText()).toEqual "aaa\n"

      it "--> increments strings from 'selection' : 2 lines of text", ->
        editor = atom.workspace.getActiveTextEditor()
        editor.insertText("lorem\nipsum")
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

      it "--> increments strings from 'selection' : 3 empty lines", ->
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

      it "--> increments strings from 'selection' : 3 lines of text", ->
        editor = atom.workspace.getActiveTextEditor()
        editor.insertText("lorem\nipsum\ndolor")
        editor.selectAll()
        changeHandler = jasmine.createSpy('changeHandler')
        editor.onDidChange(changeHandler)
        atom.commands.dispatch workspaceElement, 'atom-increment:incString'
        waitsForPromise ->
          activationPromise
        waitsFor ->
          changeHandler.callCount > 0
        runs ->
          expect(editor.getText()).toEqual "aaa\naab\naac\n"

    describe "- tests on multiple cursors", ->

      it "--> increments strings from 'multiple cursors' : 2 empty lines", ->
        editor = atom.workspace.getActiveTextEditor()
        editor.insertText("\n")
        editor.setCursorScreenPosition([0, 0])
        editor.addCursorAtScreenPosition([1, 0])
        expect(editor.getCursors().length).toBe 2
        changeHandler = jasmine.createSpy('changeHandler')
        editor.onDidChange(changeHandler)
        atom.commands.dispatch workspaceElement, 'atom-increment:incString'
        waitsForPromise ->
          activationPromise
        waitsFor ->
          changeHandler.callCount > 0
        runs ->
          expect(editor.getText()).toEqual "aaa\naab"

      it "--> increments strings from 'multiple cursors' : 2 lines of text", ->
        editor = atom.workspace.getActiveTextEditor()
        editor.insertText("lorem\nipsum")
        editor.setCursorScreenPosition([0, 0])
        editor.addCursorAtScreenPosition([1, 0])
        expect(editor.getCursors().length).toBe 2
        changeHandler = jasmine.createSpy('changeHandler')
        editor.onDidChange(changeHandler)
        atom.commands.dispatch workspaceElement, 'atom-increment:incString'
        waitsForPromise ->
          activationPromise
        waitsFor ->
          changeHandler.callCount > 0
        runs ->
          expect(editor.getText()).toEqual "aaalorem\naabipsum"
