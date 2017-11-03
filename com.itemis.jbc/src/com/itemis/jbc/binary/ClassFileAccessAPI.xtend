package com.itemis.jbc.binary

import com.itemis.jbc.jbc.AttributeInfo
import com.itemis.jbc.jbc.Attributes
import com.itemis.jbc.jbc.ClassFile
import com.itemis.jbc.jbc.Code
import com.itemis.jbc.jbc.CodeTable
import com.itemis.jbc.jbc.CodeTableEntry
import com.itemis.jbc.jbc.ConstantClass
import com.itemis.jbc.jbc.ConstantDouble
import com.itemis.jbc.jbc.ConstantFieldRef
import com.itemis.jbc.jbc.ConstantFloat
import com.itemis.jbc.jbc.ConstantInteger
import com.itemis.jbc.jbc.ConstantInterfaceMethodRef
import com.itemis.jbc.jbc.ConstantInvoceDynamic
import com.itemis.jbc.jbc.ConstantLong
import com.itemis.jbc.jbc.ConstantMethodHandle
import com.itemis.jbc.jbc.ConstantMethodRef
import com.itemis.jbc.jbc.ConstantMethodType
import com.itemis.jbc.jbc.ConstantModule
import com.itemis.jbc.jbc.ConstantNameAndType
import com.itemis.jbc.jbc.ConstantPackage
import com.itemis.jbc.jbc.ConstantPool
import com.itemis.jbc.jbc.ConstantPoolEntry
import com.itemis.jbc.jbc.ConstantString
import com.itemis.jbc.jbc.ConstantUtf8
import com.itemis.jbc.jbc.ConstantValue
import com.itemis.jbc.jbc.EnclosingMethod
import com.itemis.jbc.jbc.Exceptions
import com.itemis.jbc.jbc.FieldInfo
import com.itemis.jbc.jbc.InnerClasses
import com.itemis.jbc.jbc.LineNumberTable
import com.itemis.jbc.jbc.LocalVariableTable
import com.itemis.jbc.jbc.MethodInfo
import com.itemis.jbc.jbc.SourceFile
import com.itemis.jbc.jbc.U1
import com.itemis.jbc.jbc.U2
import com.itemis.jbc.jbc.U4
import com.itemis.jbc.jbc.Unknown
import com.itemis.jbc.jbc.impl.CodeTableEntryImplCustom
import com.itemis.jbc.jbc.impl.ConstantPoolEntryImplCustom
import java.nio.ByteBuffer
import org.eclipse.emf.ecore.EObject

class ClassFileAccessAPI {

	private new() {
		// facade with only static methods for static import
	}

	static def ClassFile getClassFile(EObject object) {
		if (object instanceof ClassFile)
			return object as ClassFile
		return object.eContainer.classFile
	}

	static def isPublic(ClassFile classFile) { classFile.isAccessSet(0x0001) }

	static def isFinal(ClassFile classFile) { classFile.isAccessSet(0x0010) }

	static def isSuper(ClassFile classFile) { classFile.isAccessSet(0x0020) }

	static def isInterface(ClassFile classFile) { classFile.isAccessSet(0x0200) }

	static def isAbstract(ClassFile classFile) { classFile.isAccessSet(0x0400) }

	static def isSynthetic(ClassFile classFile) { classFile.isAccessSet(0x1000) }

	static def isAnnotation(ClassFile classFile) { classFile.isAccessSet(0x2000) }

	static def isEnum(ClassFile classFile) { classFile.isAccessSet(0x4000) }

	static def isClass(ClassFile classFile) { !classFile.isInterface && !classFile.isEnum && !classFile.isAnnotation }

	static def isPublic(MethodInfo method) { method.isAccessSet(0x0001) }

	static def isPrivate(MethodInfo method) { method.isAccessSet(0x0002) }

	static def isProtected(MethodInfo method) { method.isAccessSet(0x0004) }

	static def isPackageProtected(MethodInfo method) { !method.isPublic && !method.isProtected && !method.isPrivate }

	static def isStatic(MethodInfo method) { method.isAccessSet(0x0008) }

	static def isFinal(MethodInfo method) { method.isAccessSet(0x0010) }

	static def isSynchronized(MethodInfo method) { method.isAccessSet(0x0020) }

	static def isBridge(MethodInfo method) { method.isAccessSet(0x0040) }

	static def isVarargs(MethodInfo method) { method.isAccessSet(0x0080) }

	static def isNative(MethodInfo method) { method.isAccessSet(0x0100) }

	static def isAbstract(MethodInfo method) { method.isAccessSet(0x0400) }

	static def isStrict(MethodInfo method) { method.isAccessSet(0x0800) }

	static def isSynthetic(MethodInfo method) { method.isAccessSet(0x1000) }

	static def isPublic(FieldInfo field) { field.isAccessSet(0x0001) }

	static def isPrivate(FieldInfo field) { field.isAccessSet(0x0002) }

	static def isProtected(FieldInfo field) { field.isAccessSet(0x0004) }

	static def isPackageProtected(FieldInfo field) { !field.isPublic && ! field.isPrivate && !field.isProtected }

	static def isStatic(FieldInfo field) { field.isAccessSet(0x0008) }

	static def isFinal(FieldInfo field) { field.isAccessSet(0x0010) }

	static def isVolatile(FieldInfo field) { field.isAccessSet(0x0040) }

	static def isTransient(FieldInfo field) { field.isAccessSet(0x0080) }

	static def isSynthetic(FieldInfo field) { field.isAccessSet(0x1000) }

	static def isEnum(FieldInfo field) { field.isAccessSet(0x4000) }

	private static def isAccessSet(ClassFile classFile, int mask) {
		return (classFile?.accessFlags?.intValue.bitwiseAnd(mask)) !== 0
	}

	private static def isAccessSet(MethodInfo method, int mask) {
		return (method?.accessFlags?.intValue.bitwiseAnd(mask)) !== 0
	}

	private static def isAccessSet(FieldInfo field, int mask) {
		return (field?.accessFlags?.intValue.bitwiseAnd(mask)) !== 0
	}

	static def ConstantUtf8 getConstantUtf8(ClassFile classFile, int index) {
		classFile.constantPool.getConstantUtf8(index)
	}

	static def ConstantUtf8 getConstantUtf8(ConstantPool constantPool, int index) {
		val constant = constantPool?.getConstant(index)
		return if(constant instanceof ConstantUtf8) constant else null
	}

	static def ConstantClass getConstantClass(ConstantPool constantPool, int index) {
		val constant = constantPool?.getConstant(index)
		return if(constant instanceof ConstantClass) constant else null
	}

	static def ConstantFieldRef getConstantFieldRef(ConstantPool constantPool, int index) {
		val constant = constantPool?.getConstant(index)
		return if(constant instanceof ConstantFieldRef) constant else null
	}

	static def ConstantMethodRef getConstantMethodRef(ConstantPool constantPool, int index) {
		val constant = constantPool?.getConstant(index)
		return if(constant instanceof ConstantMethodRef) constant else null
	}

	static def ConstantNameAndType getConstantNameAndType(ConstantPool constantPool, int index) {
		val constant = constantPool?.getConstant(index)
		return if(constant instanceof ConstantNameAndType) constant else null
	}

	static def ConstantPoolEntry getConstant(ConstantPool constantPool, int index) {
		val realIndex = constantPool.calculateListIndex(index)
		if (realIndex == -1)
			return null
		constantPool.cpInfo.get(realIndex)
	}

	private static def calculateListIndex(ConstantPool constantPool, int referenceIndex) {
		var result = 0
		for (var n = 0; n < constantPool.cpInfo.size; n++) {
			result++
			val entry = constantPool.cpInfo.get(n)
			if (result == referenceIndex) {
				return n
			}
			if (entry instanceof ConstantLong || entry instanceof ConstantDouble) {
				result++
			}
		}
		return -1
	}

	static def cpSize(ConstantPool constantPool) {
		var result = 1
		for (entry : constantPool.cpInfo) {
			result++
			if (entry instanceof ConstantLong || entry instanceof ConstantDouble)
				result++
		}
		return result
	}

	private static def calculateReferenceIndex(ConstantPool constantPool, ConstantPoolEntry entry) {
		return (entry as ConstantPoolEntryImplCustom).getConstantPoolReferenceIndex();
	}

	static def getStringValue(ConstantUtf8 constantUtf8) {
		constantUtf8.content.value
	}

	static def getIntValue(ConstantInteger constantInteger) {
		constantInteger.bytes.intValue
	}

	static def getFloatValue(ConstantFloat constantFloat) {
		Float.intBitsToFloat(constantFloat.bytes.intValue)
	}

	static def getLongValue(ConstantLong constantLong) {
		val highBytes = constantLong.highBytes.intValue
		val lowBytes = constantLong.lowBytes.intValue
		val buffer = ByteBuffer.allocate(Long.BYTES)
		buffer.putInt(highBytes)
		buffer.putInt(lowBytes)
		buffer.flip()
		return buffer.getLong()
	}

	static def getDoubleValue(ConstantDouble constantDouble) {
		val highBytes = constantDouble.highBytes.intValue
		val lowBytes = constantDouble.lowBytes.intValue
		val buffer = ByteBuffer.allocate(Long.BYTES)
		buffer.putInt(highBytes)
		buffer.putInt(lowBytes)
		buffer.flip()
		return buffer.getDouble()
	}

	static def getReferenceNameIndex(ConstantClass constantClass) {
		return constantClass.nameIndex
	}

	static def getReferenceClassIndex(ConstantFieldRef constantFieldRef) {
		return constantFieldRef.classIndex
	}

	static def getReferenceNameAndTypeIndex(ConstantFieldRef constantFieldRef) {
		return constantFieldRef.nameAndTypeIndex
	}

	static def getReferenceClassIndex(ConstantMethodRef constantMethodRef) {
		return constantMethodRef.classIndex
	}

	static def getReferenceNameAndTypeIndex(ConstantMethodRef constantMethodRef) {
		return constantMethodRef.nameAndTypeIndex
	}

	static def getReferenceClassIndex(ConstantInterfaceMethodRef constantInterfaceMethodRef) {
		return constantInterfaceMethodRef.classIndex
	}

	static def getReferenceNameAndTypeIndex(ConstantInterfaceMethodRef constantInterfaceMethodRef) {
		return constantInterfaceMethodRef.nameAndTypeIndex
	}

	static def getReferenceStringIndex(ConstantString constantString) {
		return constantString.stringIndex
	}

	static def getReferenceNameIndex(ConstantNameAndType constantNameAndType) {
		return constantNameAndType.nameIndex
	}

	static def getReferenceDescriptorIndex(ConstantNameAndType constantNameAndType) {
		return constantNameAndType.descriptorIndex
	}

	private static def getConstantPool(ConstantPoolEntry constant) {
		constant?.eContainer as ConstantPool
	}

	static def int index(ConstantPoolEntry entry) {
		entry?.constantPool?.calculateReferenceIndex(entry)
	}

	static def Class<? extends ConstantPoolEntry> entryTypeForTag(int tag) {
		switch tag {
			case 1:
				ConstantUtf8
			case 3:
				ConstantInteger
			case 4:
				ConstantFloat
			case 5:
				ConstantLong
			case 6:
				ConstantDouble
			case 7:
				ConstantClass
			case 8:
				ConstantString
			case 9:
				ConstantFieldRef
			case 10:
				ConstantMethodRef
			case 11:
				ConstantInterfaceMethodRef
			case 12:
				ConstantNameAndType
			case 15:
				ConstantMethodHandle
			case 16:
				ConstantMethodType
			case 18:
				ConstantInvoceDynamic
			case 19:
				ConstantModule
			case 20:
				ConstantPackage
			default:
				throw new RuntimeException("Unknown tag: " + tag)
		}
	}

	static def int constantTagValue(ConstantPoolEntry entry) {
		switch entry {
			ConstantUtf8:
				1
			ConstantInteger:
				3
			ConstantFloat:
				4
			ConstantLong:
				5
			ConstantDouble:
				6
			ConstantClass:
				7
			ConstantString:
				8
			ConstantFieldRef:
				9
			ConstantMethodRef:
				10
			ConstantInterfaceMethodRef:
				11
			ConstantNameAndType:
				12
			ConstantMethodHandle:
				15
			ConstantMethodType:
				16
			ConstantInvoceDynamic:
				18
			ConstantModule:
				19
			ConstantPackage:
				20
			default:
				throw new RuntimeException("Unknown tag: " + entry)
		}
	}

	static def int offset(CodeTableEntry entry) {
		entry?.table.offset(entry)
	}

	static def getTable(CodeTableEntry entry) {
		entry.eContainer as CodeTable
	}

	static def CodeTableEntry instructionFromOffset(CodeTable table, int targetOffset) {
		var CodeTableEntry actual = null
		var i = 0;
		var offset = 0;
		do {
			actual = table.instruction.get(i)
			if (offset === targetOffset)
				return actual
			offset += Opcode.byteCount(actual)
			i++
		} while (offset <= targetOffset)
		return null
	}

	private static def offset(CodeTable table, CodeTableEntry entry) {
		return (entry as CodeTableEntryImplCustom).getCodeOffset();
	}

	static def int byteCount(AttributeInfo attribute) {
		// TODO probably refactor this into the model!? Extract some class to contain attribute logic, similar to Opcode!?
		switch attribute {
			Code:
				return 2 + 2 + 4 + attribute.codeTable.byteCount + 2 +
					(attribute.exceptionTable.exceptionTableEntry.length * 8) + 2 + attribute.attributes.byteCount
			ConstantValue:
				return 2
			SourceFile:
				return 2
			LineNumberTable:
				return 2 + attribute.lineNumbers.length * 4
			LocalVariableTable:
				return 2 + attribute.localVariables.length * 10
			Exceptions:
				return 2 + attribute.exception.length * 2
			InnerClasses:
				return 2 + attribute.innerClasses.length * 8
			EnclosingMethod:
				return 4
			Unknown:
				return attribute.info.length
		}
		throw new RuntimeException("Unknown attribute " + attribute)
	}

	static def byteCount(Attributes attributes) {
		var result = 0
		for (info : attributes.attributeInfo) {
			result += 2 + 4 + info.byteCount
		}
		return result
	}

	static def byteCount(CodeTable table) {
		var realLength = 0
		for (entry : table.instruction)
			realLength += Opcode.byteCount(entry)
		return realLength
	}

	static def byteValue(String value) {
		Integer.parseUnsignedInt(value, 16) as byte
	}

	static def intValue(U1 u1) {
		if (u1.value === null)
			return 0
		Integer.parseUnsignedInt(u1.value, 16)
	}

	static def intValue(U2 u2) {
		if (u2.value === null)
			return 0
		Integer.parseUnsignedInt(u2.value, 16)
	}

	static def intValue(U4 u4) {
		if (u4.value === null)
			return 0
		Integer.parseUnsignedInt(u4.value, 16)
	}

	static def u1Value(byte value) {
		var result = Integer.toHexString(value).toUpperCase
		while (result.length < 2)
			result = "0" + result;
		return result
	}

	static def u1Value(int value) {
		var result = Integer.toHexString(value).toUpperCase
		while (result.length < 2)
			result = "0" + result;
		return result
	}

	static def u2Value(int value) {
		var result = Integer.toHexString(value).toUpperCase
		while (result.length < 4)
			result = "0" + result;
		return result
	}

	static def u2SignedValue(int value) {
		var unsignedValue = value
		if (unsignedValue < 0)
			unsignedValue = - value + Short.MAX_VALUE
		var result = Integer.toHexString(Integer.parseInt(Long.toUnsignedString(unsignedValue, 16), 16)).toUpperCase
		while (result.length < 4)
			result = "0" + result;
		return result
	}

	static def u4SignedValue(int value) {
		var unsignedValue = value
		if (unsignedValue < 0)
			unsignedValue = - value + Integer.MAX_VALUE
		var result = Integer.toHexString(Integer.parseInt(Long.toUnsignedString(unsignedValue, 16), 16)).toUpperCase
		while (result.length < 8)
			result = "0" + result;
		return result
	}

	static def u4Value(int value) {
		var result = Integer.toHexString(value).toUpperCase
		while (result.length < 8)
			result = "0" + result;
		return result
	}

}
