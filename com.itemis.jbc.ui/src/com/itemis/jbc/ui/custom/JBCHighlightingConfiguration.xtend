package com.itemis.jbc.ui.custom

import org.eclipse.swt.SWT
import org.eclipse.swt.graphics.RGB
import org.eclipse.xtext.ui.editor.syntaxcoloring.DefaultHighlightingConfiguration

class JBCHighlightingConfiguration extends DefaultHighlightingConfiguration {

	override keywordTextStyle() {
		var textStyle = defaultTextStyle().copy()
		textStyle.setColor(new RGB(127, 0, 85))
		textStyle.setStyle(SWT.BOLD)
		return textStyle
	}

	override numberTextStyle() {
		var textStyle = defaultTextStyle().copy()
		textStyle.setColor(new RGB(63, 63, 127))
		return textStyle
	}

}
