package com.itemis.jbc.custom

import com.itemis.jbc.jbc.CodeTableEntry
import com.itemis.jbc.jbc.ConstantPoolEntry
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.naming.IQualifiedNameProvider
import org.eclipse.xtext.naming.QualifiedName

import static extension com.itemis.jbc.binary.ClassFileAccessAPI.*

class JBCQualifiedNameProvider extends IQualifiedNameProvider.AbstractImpl {

	override getFullyQualifiedName(EObject obj) {
		if (obj instanceof ConstantPoolEntry)
			return QualifiedName.create(obj.index.u2Value)
		else if (obj instanceof CodeTableEntry)
			return QualifiedName.create(obj.offset.u2Value)
	}

}
