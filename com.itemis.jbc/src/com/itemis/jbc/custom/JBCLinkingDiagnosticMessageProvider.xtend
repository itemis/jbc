package com.itemis.jbc.custom

import com.itemis.jbc.jbc.JbcPackage
import org.eclipse.xtext.linking.impl.LinkingDiagnosticMessageProvider

class JBCLinkingDiagnosticMessageProvider extends LinkingDiagnosticMessageProvider {

	override getUnresolvedProxyMessage(ILinkingDiagnosticContext context) {
		if (context.reference == JbcPackage.eINSTANCE.exceptionTableEntry_CatchType && "0000" == context.linkText)
			return null
		if (context.reference == JbcPackage.eINSTANCE.classFile_SuperClass && "0000" == context.linkText)
			return null
		if (context.reference == JbcPackage.eINSTANCE.innerClass_OuterClassInfoIndex && "0000" == context.linkText)
			return null
		if (context.reference == JbcPackage.eINSTANCE.innerClass_InnerNameIndex && "0000" == context.linkText)
			return null
		return super.getUnresolvedProxyMessage(context)
	}

}
