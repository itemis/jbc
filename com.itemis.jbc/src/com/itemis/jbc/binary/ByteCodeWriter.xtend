package com.itemis.jbc.binary

import com.itemis.jbc.jbc.ClassFile
import com.itemis.jbc.jbc.CodeTableEntry
import com.itemis.jbc.jbc.ConstantPoolEntry
import com.itemis.jbc.jbc.JbcPackage
import com.itemis.jbc.jbc.U1
import com.itemis.jbc.jbc.U2
import com.itemis.jbc.jbc.U4
import com.itemis.jbc.jbc.UString
import java.io.ByteArrayOutputStream
import java.io.DataOutputStream
import java.util.List
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EReference

import static extension com.itemis.jbc.binary.ClassFileAccessAPI.*

class ByteCodeWriter {

	def static byte[] writeClassFile(ClassFile classFile) {
		return new ByteCodeWriter(classFile).toByteArray
	}

	private ClassFile classFile

	package new(ClassFile classFile) {
		this.classFile = classFile
	}

	private def byte[] toByteArray() {
		val byteArrayOutputStream = new ByteArrayOutputStream()
		addBytesFromElement(new DataOutputStream(byteArrayOutputStream), classFile)
		return byteArrayOutputStream.toByteArray
	}

	private def void addBytesFromElement(DataOutputStream stream, EObject element) {
		if (element instanceof U1) {
			stream.writeByte(element.intValue)
		} else if (element instanceof U2) {
			stream.writeShort(element.intValue)
		} else if (element instanceof U4) {
			stream.writeInt(element.intValue)
		} else if (element instanceof UString) {
			stream.writeUTF(element.value)
		} else {
			for (feature : element.eClass.EAllStructuralFeatures) {
				if (feature instanceof EReference) {
					if ((feature as EReference).isContainment) {
						val child = element.eGet(feature)
						if (child instanceof EObject) {
							addBytesFromElement(stream, child)
						} else if (child !== null) {
							for (c : (child as List<?>)) {
								addBytesFromElement(stream, c as EObject)
							}
						}
					} else {
						if (ConstantPoolEntry.isAssignableFrom(feature.EReferenceType.instanceClass)) {
							val child = element.eGet(feature)
							if (child === null) { // special case when index goes to 'null'
								stream.writeByte(0)
								stream.writeByte(0)
							} else if (child instanceof ConstantPoolEntry) {
								val index = child.index
								if (feature === JbcPackage.eINSTANCE.LDC_Index) { // one byte reference
									stream.writeByte(index)
								} else {
									stream.writeShort(index)
								}
							}
						} else if (CodeTableEntry.isAssignableFrom(feature.EReferenceType.instanceClass)) {
							val child = element.eGet(feature)
							if (child instanceof CodeTableEntry) {
								// TODO redundant case, implement independent model
								val offset = child.offset
								if (feature === JbcPackage.eINSTANCE.GOTO_Branch ||
									feature === JbcPackage.eINSTANCE.GOTO_W_Branch ||
									feature === JbcPackage.eINSTANCE.IF_ACMPEQ_Branch ||
									feature === JbcPackage.eINSTANCE.IF_ACMPNE_Branch ||
									feature === JbcPackage.eINSTANCE.IF_ICMPEQ_Branch ||
									feature === JbcPackage.eINSTANCE.IF_ICMPNE_Branch ||
									feature === JbcPackage.eINSTANCE.IF_ICMPLT_Branch ||
									feature === JbcPackage.eINSTANCE.IF_ICMPGE_Branch ||
									feature === JbcPackage.eINSTANCE.IF_ICMPGT_Branch ||
									feature === JbcPackage.eINSTANCE.IF_ICMPLE_Branch ||
									feature === JbcPackage.eINSTANCE.IFEQ_Branch ||
									feature === JbcPackage.eINSTANCE.IFNE_Branch ||
									feature === JbcPackage.eINSTANCE.IFLT_Branch ||
									feature === JbcPackage.eINSTANCE.IFGE_Branch ||
									feature === JbcPackage.eINSTANCE.IFGT_Branch ||
									feature === JbcPackage.eINSTANCE.IFLE_Branch ||
									feature === JbcPackage.eINSTANCE.IFNONNULL_Branch ||
									feature === JbcPackage.eINSTANCE.IFNULL_Branch ||
									feature === JbcPackage.eINSTANCE.JSR_W_Branch ||
									feature === JbcPackage.eINSTANCE.JSR_Branch
									) { // relative offset
										stream.writeShort(offset - (element as CodeTableEntry).offset)
									} else {
										stream.writeShort(offset)
									}
								}
							}
						}
					}
				}
			}
		}

	}
	