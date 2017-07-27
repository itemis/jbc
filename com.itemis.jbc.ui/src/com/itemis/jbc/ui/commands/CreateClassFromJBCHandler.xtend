package com.itemis.jbc.ui.commands

import com.google.inject.Inject
import com.itemis.jbc.binary.ByteCodeWriter
import com.itemis.jbc.jbc.ClassFile
import java.io.ByteArrayInputStream
import java.io.InputStreamReader
import org.eclipse.core.commands.AbstractHandler
import org.eclipse.core.commands.ExecutionEvent
import org.eclipse.core.commands.ExecutionException
import org.eclipse.core.resources.IFile
import org.eclipse.core.runtime.NullProgressMonitor
import org.eclipse.core.runtime.Path
import org.eclipse.jface.viewers.IStructuredSelection
import org.eclipse.ui.PlatformUI
import org.eclipse.ui.part.FileEditorInput
import org.eclipse.xtext.parser.IParser

class CreateClassFromJBCHandler extends AbstractHandler {

	// TODO use IResource instead of manual parsing
	@Inject
	private IParser parser

	override execute(ExecutionEvent event) throws ExecutionException {
		val activePage = PlatformUI.workbench.activeWorkbenchWindow.activePage
		var selection = activePage.selection
		if (selection instanceof IStructuredSelection) {
			val element = selection.firstElement
			if (element instanceof IFile) {
				val sourceFile = element as IFile
				val sourceName = sourceFile.name
				if (sourceName.endsWith(".jbc")) {
					val targetFile = sourceFile.parent.getFile(
						new Path(sourceName.substring(0, sourceName.length - 4) + ".class"))
					var InputStreamReader reader = null
					try {
						reader = new InputStreamReader(sourceFile.contents)
						val parseResult = parser.parse(reader)
						val byteCode = ByteCodeWriter.writeClassFile(parseResult.rootNode.semanticElement as ClassFile)
						if (targetFile.exists) {
							targetFile.setContents(new ByteArrayInputStream(byteCode), true, true,
								new NullProgressMonitor)
						} else {
							targetFile.create(new ByteArrayInputStream(byteCode), true, new NullProgressMonitor)
						}
						activePage.openEditor(new FileEditorInput(targetFile), "com.itemis.jbc.JBC")
					} finally {
						if (reader !== null)
							reader.close()
					}
				}
			}
		}
	}

}
