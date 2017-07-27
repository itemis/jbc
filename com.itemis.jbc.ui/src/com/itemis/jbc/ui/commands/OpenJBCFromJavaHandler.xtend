package com.itemis.jbc.ui.commands

import org.eclipse.core.commands.AbstractHandler
import org.eclipse.core.commands.ExecutionEvent
import org.eclipse.core.commands.ExecutionException
import org.eclipse.core.resources.IFile
import org.eclipse.jdt.core.ICompilationUnit
import org.eclipse.jdt.core.JavaCore
import org.eclipse.jdt.internal.core.Region
import org.eclipse.jface.viewers.IStructuredSelection
import org.eclipse.ui.PlatformUI
import org.eclipse.ui.part.FileEditorInput

class OpenJBCFromJavaHandler extends AbstractHandler {

	override execute(ExecutionEvent event) throws ExecutionException {
		val activePage = PlatformUI.workbench.activeWorkbenchWindow.activePage
		var selection = activePage.selection
		if (selection instanceof IStructuredSelection) {
			val element = selection.firstElement
			if (element instanceof ICompilationUnit) {
				val region = new Region()
				region.add(element)
				for (r : JavaCore.getGeneratedResources(region, false)) {
					PlatformUI.workbench.activeWorkbenchWindow.activePage.openEditor(new FileEditorInput(r as IFile),
						"com.itemis.jbc.JBC")
				}
			}
		}
		return null
	}

}
