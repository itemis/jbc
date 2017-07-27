package com.itemis.jbc.ui.custom

import com.google.inject.Inject
import java.io.InputStreamReader
import java.lang.reflect.InvocationHandler
import java.lang.reflect.Method
import java.lang.reflect.Proxy
import org.eclipse.core.resources.IEncodedStorage
import org.eclipse.core.resources.IStorage
import org.eclipse.core.runtime.CoreException
import org.eclipse.ui.IEditorInput
import org.eclipse.ui.IFileEditorInput
import org.eclipse.xtext.parser.IParser
import org.eclipse.xtext.ui.editor.XtextEditor
import org.eclipse.xtext.util.StringInputStream

class JBCEditor extends XtextEditor {

	@Inject
	private IParser parser

	override protected doSetInput(IEditorInput input) throws CoreException {
		// The class LastSaveReferenceProvider uses the method IStorage.getContents to access the original content
		// to compare it to the actual content. But we use a binary file to create text from it. To make the comparison
		// work we wrap the "getStorage" method with a dynamic proxy. The proxy converts the binary representation to its
		// textual form to enable the comparison to work.
		if (input instanceof IFileEditorInput) {
			if (input.file.name.endsWith(".class")) {
				super.doSetInput(input.proxy)
				return
			}
		}
		super.doSetInput(input)
	}

	def private IFileEditorInput proxy(IFileEditorInput editorInput) {
		Proxy.newProxyInstance(this.class.classLoader, #[IFileEditorInput],
			new IFileEditorInputHandler(editorInput, parser)) as IFileEditorInput
	}

}

package class IFileEditorInputHandler implements InvocationHandler {

	private final IFileEditorInput original
	private final IParser parser

	new(IFileEditorInput original, IParser parser) {
		this.original = original
		this.parser = parser
	}

	override invoke(Object proxy, Method method, Object[] args) throws Throwable {
		if (method.name.equals("getStorage")) {
			return (method.invoke(original, args) as IStorage).proxy
		} else {
			return method.invoke(original, args)
		}
	}

	def private IStorage proxy(IStorage storage) {
		Proxy.newProxyInstance(this.class.classLoader, #[IStorage], new IStorageHandler(storage, parser)) as IStorage
	}

}

package class IStorageHandler implements InvocationHandler {

	private final IStorage original
	private final IParser parser

	new(IStorage original, IParser parser) {
		this.original = original
		this.parser = parser
	}

	override invoke(Object proxy, Method method, Object[] args) throws Throwable {
		if (method.name.equals("getContents") && method.parameterCount === 0) {
			val reader = new InputStreamReader(original.contents)
			try {
				val content = new JBCInputStreamContentReader().readContent(original.contents,
					(original as IEncodedStorage).charset)
				return new StringInputStream(content)
			} finally {
				reader.close()
			}
		} else {
			return method.invoke(original, args)
		}
	}

}
