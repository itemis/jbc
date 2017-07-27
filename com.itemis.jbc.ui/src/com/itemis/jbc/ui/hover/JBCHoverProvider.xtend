package com.itemis.jbc.ui.hover

import com.itemis.jbc.jbc.CodeTableEntry
import com.itemis.jbc.jbc.ConstantPoolEntry
import com.itemis.jbc.jbc.U1
import com.itemis.jbc.jbc.U2
import com.itemis.jbc.jbc.U4
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.ui.editor.hover.html.DefaultEObjectHoverProvider

class JBCHoverProvider extends DefaultEObjectHoverProvider {

	override protected hasHover(EObject o) {
		if (isInstance(o, U1, U2, U4, ConstantPoolEntry, CodeTableEntry))
			return true
		super.hasHover(o)
	}

	private def isInstance(EObject o, Class<? extends EObject>... classes) {
		for (c : classes)
			if (c.isInstance(o))
				return true
		return false
	}

	override protected getFirstLine(EObject o) {
		var result = ""
		if (isInstance(o, U1, U2, U4)) {
			val name = o.eContainingFeature.name
			if (name !== null)
				result += "<b>" + name + "</b> = "
		}
		val label = getLabel(o)
		if (label !== null)
			result += label
		return result
	}

}
