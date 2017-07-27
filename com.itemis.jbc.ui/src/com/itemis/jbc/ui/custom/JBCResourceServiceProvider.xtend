package com.itemis.jbc.ui.custom

import org.eclipse.emf.common.util.URI
import org.eclipse.xtext.resource.impl.DefaultResourceServiceProvider

class JBCResourceServiceProvider extends DefaultResourceServiceProvider {
	
	override canHandle(URI uri) {
		// use the editor only, no not generate any markers or use other files
		return false
	}
	
}
