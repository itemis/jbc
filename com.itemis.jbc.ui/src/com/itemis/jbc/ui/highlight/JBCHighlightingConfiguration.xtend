package com.itemis.jbc.ui.highlight

import org.eclipse.swt.SWT
import org.eclipse.swt.graphics.RGB
import org.eclipse.xtext.ui.editor.syntaxcoloring.DefaultHighlightingConfiguration
import org.eclipse.xtext.ui.editor.syntaxcoloring.IHighlightingConfigurationAcceptor

class JBCHighlightingConfiguration extends DefaultHighlightingConfiguration {

	public static final String CONSTANT_POOL_REFERENCE = JBCHighlightingStyles.CONSTANT_POOL_REFERENCE_ID;

	public static final String CODE_TABLE_REFERENCE = JBCHighlightingStyles.CODE_TABLE_REFERENCE_ID;

	override configure(IHighlightingConfigurationAcceptor acceptor) {
		super.configure(acceptor)
		acceptor.acceptDefaultHighlighting(CONSTANT_POOL_REFERENCE, "Constant Pool Reference",
			contantPoolReferenceTextStyle());
		acceptor.acceptDefaultHighlighting(CODE_TABLE_REFERENCE, "Code Table Reference", codeTableReferenceTextStyle());
	}

	override keywordTextStyle() {
		var textStyle = defaultTextStyle().copy()
		textStyle.setColor(new RGB(127, 0, 85))
		textStyle.setStyle(SWT.BOLD)
		return textStyle
	}

	override numberTextStyle() {
		var textStyle = defaultTextStyle().copy()
		textStyle.setColor(new RGB(127, 127, 127))
		return textStyle
	}

	override stringTextStyle() {
		var textStyle = defaultTextStyle().copy()
		textStyle.setColor(new RGB(42, 0, 255))
		return textStyle
	}

	private def contantPoolReferenceTextStyle() {
		var textStyle = defaultTextStyle().copy()
		textStyle.setColor(new RGB(91, 42, 127))
		return textStyle
	}

	private def codeTableReferenceTextStyle() {
		var textStyle = defaultTextStyle().copy()
		textStyle.setColor(new RGB(91, 145, 42))
		return textStyle
	}

}
