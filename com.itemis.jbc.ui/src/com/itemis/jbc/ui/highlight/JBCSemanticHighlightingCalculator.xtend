package com.itemis.jbc.ui.highlight

import com.itemis.jbc.jbc.JbcPackage
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EReference
import org.eclipse.emf.ecore.EStructuralFeature
import org.eclipse.xtext.ide.editor.syntaxcoloring.DefaultSemanticHighlightingCalculator
import org.eclipse.xtext.ide.editor.syntaxcoloring.IHighlightedPositionAcceptor
import org.eclipse.xtext.util.CancelIndicator

class JBCSemanticHighlightingCalculator extends DefaultSemanticHighlightingCalculator {

	override protected highlightElement(EObject object, IHighlightedPositionAcceptor acceptor,
		CancelIndicator cancelIndicator) {
		for (feature : object.eClass.EAllStructuralFeatures)
			highlightFeature(acceptor, object, feature)
		super.highlightElement(object, acceptor, cancelIndicator)
	}

	override protected highlightFeature(IHighlightedPositionAcceptor acceptor, EObject object,
		EStructuralFeature feature, String... styleIds) {
		if (feature instanceof EReference) {
			if (!feature.containment)
				if (JbcPackage.eINSTANCE.constantPoolEntry.isSuperTypeOf(feature.EReferenceType))
					super.highlightFeature(acceptor, object, feature, JBCHighlightingConfiguration.CONSTANT_POOL_REFERENCE)
				else if (JbcPackage.eINSTANCE.codeTableEntry.isSuperTypeOf(feature.EReferenceType))
					super.highlightFeature(acceptor, object, feature, JBCHighlightingConfiguration.CODE_TABLE_REFERENCE)
		}
	}

}
