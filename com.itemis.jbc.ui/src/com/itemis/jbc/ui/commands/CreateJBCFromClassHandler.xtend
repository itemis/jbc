package com.itemis.jbc.ui.commands

import com.itemis.jbc.ui.custom.JBCInputStreamContentReader
import org.eclipse.core.commands.AbstractHandler
import org.eclipse.core.commands.ExecutionEvent
import org.eclipse.core.commands.ExecutionException
import org.eclipse.core.resources.IFile
import org.eclipse.core.runtime.NullProgressMonitor
import org.eclipse.core.runtime.Path
import org.eclipse.jface.viewers.IStructuredSelection
import org.eclipse.ui.PlatformUI
import org.eclipse.ui.part.FileEditorInput
import org.eclipse.xtext.util.StringInputStream

class CreateJBCFromClassHandler extends AbstractHandler {

	override execute(ExecutionEvent event) throws ExecutionException {
		val activePage = PlatformUI.workbench.activeWorkbenchWindow.activePage
		var selection = activePage.selection
		if (selection instanceof IStructuredSelection) {
			val element = selection.firstElement
			if (element instanceof IFile) {
				val sourceFile = element as IFile
				val sourceName = sourceFile.name
				if (sourceName.endsWith(".class")) {
					val targetFile = sourceFile.parent.getFile(
						new Path(sourceName.substring(0, sourceName.length - 6) + ".jbc"))
					val content = new JBCInputStreamContentReader().readContent(sourceFile.contents, sourceFile.charset)
					if (targetFile.exists) {
						targetFile.setContents(new StringInputStream(content, sourceFile.charset), true, true,
							new NullProgressMonitor)
					} else {
						targetFile.create(new StringInputStream(content, sourceFile.charset), true,
							new NullProgressMonitor)
					}
					activePage.openEditor(new FileEditorInput(targetFile), "com.itemis.jbc.JBC")
				}
			}
		}
	}

}
