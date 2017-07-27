package com.itemis.jbc.ui.custom

import com.itemis.jbc.binary.ByteCodeWriter
import com.itemis.jbc.jbc.ClassFile
import java.io.ByteArrayInputStream
import java.io.InputStream
import org.eclipse.core.runtime.CoreException
import org.eclipse.core.runtime.IProgressMonitor
import org.eclipse.jface.text.IDocument
import org.eclipse.ui.IFileEditorInput
import org.eclipse.xtext.resource.XtextResource
import org.eclipse.xtext.ui.editor.model.XtextDocument
import org.eclipse.xtext.ui.editor.model.XtextDocumentProvider
import org.eclipse.xtext.util.concurrent.IUnitOfWork

class JBCDocumentProvider extends XtextDocumentProvider {

	override protected setDocumentContent(IDocument document, InputStream contentStream,
		String encoding) throws CoreException {
		document.set(new JBCInputStreamContentReader().readContent(contentStream, encoding))
	}

	override protected doSaveDocument(IProgressMonitor monitor, Object element, IDocument document,
		boolean overwrite) throws CoreException {
		if (element instanceof IFileEditorInput) {
			if (document instanceof XtextDocument) {
				if (element.file.exists && element.file.name.endsWith(".class")) {
					document.readOnly(new IUnitOfWork.Void<XtextResource>() {
						override process(XtextResource resource) throws Exception {
							val ast = resource.parseResult.rootASTElement
							element.file.setContents(
								new ByteArrayInputStream(ByteCodeWriter.writeClassFile(ast as ClassFile)), true, true,
								monitor)
							}
						});
						return;
					}
				}
			}
			super.doSaveDocument(monitor, element, document, overwrite)
		}

	}
	