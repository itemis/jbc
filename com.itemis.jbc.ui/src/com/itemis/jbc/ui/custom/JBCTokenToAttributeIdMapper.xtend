package com.itemis.jbc.ui.custom

import org.eclipse.xtext.ui.editor.syntaxcoloring.DefaultAntlrTokenToAttributeIdMapper
import org.eclipse.xtext.ui.editor.syntaxcoloring.DefaultHighlightingConfiguration

class JBCTokenToAttributeIdMapper extends DefaultAntlrTokenToAttributeIdMapper {

	override protected calculateId(String tokenName, int tokenType) {
		if (tokenName.equals("RULE_HEX2") || tokenName.equals("RULE_HEX4") || tokenName.equals("RULE_HEX8"))
			return DefaultHighlightingConfiguration.NUMBER_ID
		return super.calculateId(tokenName, tokenType)
	}

}
