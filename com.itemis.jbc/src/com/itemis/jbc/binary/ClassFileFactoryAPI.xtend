package com.itemis.jbc.binary

import com.itemis.jbc.jbc.AttributeInfo
import com.itemis.jbc.jbc.Attributes
import com.itemis.jbc.jbc.CodeTable
import com.itemis.jbc.jbc.CodeTableEntry
import com.itemis.jbc.jbc.ConstantClass
import com.itemis.jbc.jbc.ConstantNameAndType
import com.itemis.jbc.jbc.ConstantPool
import com.itemis.jbc.jbc.ConstantPoolEntry
import com.itemis.jbc.jbc.ConstantUtf8
import com.itemis.jbc.jbc.ExceptionTable
import com.itemis.jbc.jbc.ExceptionTableEntry
import com.itemis.jbc.jbc.FieldInfo
import com.itemis.jbc.jbc.Fields
import com.itemis.jbc.jbc.Interface
import com.itemis.jbc.jbc.Interfaces
import com.itemis.jbc.jbc.JbcFactory
import com.itemis.jbc.jbc.JumpOffset
import com.itemis.jbc.jbc.LineNumber
import com.itemis.jbc.jbc.MatchOffsetPair
import com.itemis.jbc.jbc.MethodInfo
import com.itemis.jbc.jbc.Methods
import com.itemis.jbc.jbc.U1
import com.itemis.jbc.jbc.U2
import com.itemis.jbc.jbc.U4
import com.itemis.jbc.jbc.UString

import static extension com.itemis.jbc.binary.ClassFileAccessAPI.*
import com.itemis.jbc.jbc.Requires
import com.itemis.jbc.jbc.Exports
import com.itemis.jbc.jbc.Opens
import com.itemis.jbc.jbc.Uses
import com.itemis.jbc.jbc.Provides
import com.itemis.jbc.jbc.ConstantModule

class ClassFileFactoryAPI {

	private new() {
		// facade with only static methods for static import
	}

	static def classFile(U4 magic, U2 minorVersion, U2 majorVersion, U2 constantPoolCount, ConstantPool constantPool,
		U2 accessFlags, ConstantClass thisClass, ConstantClass superClass, U2 interfacesCount, Interfaces interfaces,
		U2 fieldsCount, Fields fields, U2 methodsCount, Methods methods, U2 attributesCount, Attributes attributes) {
		val result = JbcFactory.eINSTANCE.createClassFile
		result.magic = magic
		result.minorVersion = minorVersion
		result.majorVersion = majorVersion
		result.constantPoolCount = constantPoolCount
		result.constantPool = constantPool
		result.accessFlags = accessFlags
		result.thisClass = thisClass
		result.superClass = superClass
		result.interfaceCount = interfacesCount
		result.interfaces = interfaces
		result.fieldsCount = fieldsCount
		result.fields = fields
		result.methodsCount = methodsCount
		result.methods = methods
		result.attributesCount = attributesCount
		result.attributes = attributes
		return result
	}

	static def constantPool(ConstantPoolEntry... entries) {
		val result = JbcFactory.eINSTANCE.createConstantPool
		for (ConstantPoolEntry entry : entries)
			result.cpInfo.add(entry)
		return result
	}

	static def constantUtf8(U1 tag, UString content) {
		val result = JbcFactory.eINSTANCE.createConstantUtf8
		result.tag = tag
		result.content = content
		return result
	}

	static def constantInteger(U1 tag, U4 bytes) {
		val result = JbcFactory.eINSTANCE.createConstantInteger
		result.tag = tag
		result.bytes = bytes
		return result
	}

	static def constantFloat(U1 tag, U4 bytes) {
		val result = JbcFactory.eINSTANCE.createConstantFloat
		result.tag = tag
		result.bytes = bytes
		return result
	}

	static def constantLong(U1 tag, U4 highBytes, U4 lowBytes) {
		val result = JbcFactory.eINSTANCE.createConstantLong
		result.tag = tag
		result.highBytes = highBytes
		result.lowBytes = lowBytes
		return result
	}

	static def constantDouble(U1 tag, U4 highBytes, U4 lowBytes) {
		val result = JbcFactory.eINSTANCE.createConstantDouble
		result.tag = tag
		result.highBytes = highBytes
		result.lowBytes = lowBytes
		return result
	}

	static def constantClass(U1 tag, ConstantUtf8 nameIndex) {
		val result = JbcFactory.eINSTANCE.createConstantClass
		result.tag = tag
		result.nameIndex = nameIndex
		return result
	}

	static def constantString(U1 tag, ConstantUtf8 stringIndex) {
		val result = JbcFactory.eINSTANCE.createConstantString
		result.tag = tag
		result.stringIndex = stringIndex
		return result
	}

	static def constantFieldRef(U1 tag, ConstantClass classIndex, ConstantNameAndType nameAndTypeIndex) {
		val result = JbcFactory.eINSTANCE.createConstantFieldRef
		result.tag = tag
		result.classIndex = classIndex
		result.nameAndTypeIndex = nameAndTypeIndex
		return result
	}

	static def constantMethodRef(U1 tag, ConstantClass classIndex, ConstantNameAndType nameAndTypeIndex) {
		val result = JbcFactory.eINSTANCE.createConstantMethodRef
		result.tag = tag
		result.classIndex = classIndex
		result.nameAndTypeIndex = nameAndTypeIndex
		return result
	}

	static def constantInterfaceMethodRef(U1 tag, ConstantClass classIndex, ConstantNameAndType nameAndTypeIndex) {
		val result = JbcFactory.eINSTANCE.createConstantInterfaceMethodRef
		result.tag = tag
		result.classIndex = classIndex
		result.nameAndTypeIndex = nameAndTypeIndex
		return result
	}

	static def constantNameAndType(U1 tag, ConstantUtf8 nameIndex, ConstantUtf8 descriptorIndex) {
		val result = JbcFactory.eINSTANCE.createConstantNameAndType
		result.tag = tag
		result.nameIndex = nameIndex
		result.descriptorIndex = descriptorIndex
		return result
	}

	static def constantMethodHandle(U1 tag, U1 referenceKind, ConstantNameAndType referenceIndex) {
		val result = JbcFactory.eINSTANCE.createConstantMethodHandle
		result.tag = tag
		result.referenceKind = referenceKind
		result.referenceIndex = referenceIndex
		return result
	}

	static def constantMethodType(U1 tag, ConstantUtf8 descriptorIndex) {
		val result = JbcFactory.eINSTANCE.createConstantMethodType
		result.tag = tag
		result.descriptorIndex = descriptorIndex
		return result
	}

	static def constantInvoceDynamic(U1 tag, U2 bootstrapMethodAttrIndex, ConstantNameAndType nameAndTypeIndex) {
		val result = JbcFactory.eINSTANCE.createConstantInvoceDynamic
		result.tag = tag
		result.bootstrapMethodAttrIndex = bootstrapMethodAttrIndex
		result.nameAndTypeIndex = nameAndTypeIndex
		return result
	}

	static def constantModule(U1 tag, ConstantUtf8 nameIndex) {
		val result = JbcFactory.eINSTANCE.createConstantModule
		result.tag = tag
		result.nameIndex = nameIndex
		return result
	}

	static def constantPackage(U1 tag, ConstantUtf8 nameIndex) {
		val result = JbcFactory.eINSTANCE.createConstantPackage
		result.tag = tag
		result.nameIndex = nameIndex
		return result
	}

	static def interfaces(Interface... interfaceInfo) {
		val result = JbcFactory.eINSTANCE.createInterfaces
		result.interfaceInfo.addAll(interfaceInfo)
		return result
	}

	static def interfaceInfo(ConstantClass info) {
		val result = JbcFactory.eINSTANCE.createInterface
		result.info = info
		return result
	}

	static def fields(FieldInfo... fieldInfo) {
		val result = JbcFactory.eINSTANCE.createFields
		result.fieldInfo.addAll(fieldInfo)
		return result
	}

	static def fieldInfo(U2 accessFlags, ConstantUtf8 nameIndex, ConstantUtf8 descriptorIndex, U2 attributesCount,
		Attributes attributes) {
		val result = JbcFactory.eINSTANCE.createFieldInfo
		result.accessFlags = accessFlags
		result.nameIndex = nameIndex
		result.descriptorIndex = descriptorIndex
		result.attributesCount = attributesCount
		result.attributes = attributes
		return result
	}

	static def methods(MethodInfo... methodInfo) {
		val result = JbcFactory.eINSTANCE.createMethods
		result.methodsInfo.addAll(methodInfo)
		return result
	}

	static def methodInfo(U2 accessFlags, ConstantUtf8 nameIndex, ConstantUtf8 descriptorIndex, U2 attributesCount,
		Attributes attributes) {
		val result = JbcFactory.eINSTANCE.createMethodInfo
		result.accessFlags = accessFlags
		result.nameIndex = nameIndex
		result.descriptorIndex = descriptorIndex
		result.attributesCount = attributesCount
		result.attributes = attributes
		return result
	}

	static def attributes(AttributeInfo... attributeInfo) {
		val result = JbcFactory.eINSTANCE.createAttributes
		result.attributeInfo.addAll(attributeInfo)
		return result
	}

	static def attributeUnknown(ConstantUtf8 attributeNameIndex, U4 attributeLength, U1... info) {
		val result = JbcFactory.eINSTANCE.createUnknown
		result.attributeNameIndex = attributeNameIndex
		result.attributeLength = attributeLength
		for (U1 i : info)
			result.info.add(i)
		return result
	}

	static def attributeConstantValue(ConstantUtf8 attributeNameIndex, U4 attributeLength,
		ConstantPoolEntry constantValueIndex) {
		val result = JbcFactory.eINSTANCE.createConstantValue
		result.attributeNameIndex = attributeNameIndex
		result.attributeLength = attributeLength
		result.constantValueIndex = constantValueIndex
		return result
	}

	static def attributeCode(ConstantUtf8 attributeNameIndex, U4 attributeLength, U2 maxStack, U2 maxLocals,
		U4 codeLength, CodeTable codeTable, U2 exceptionTableLength, ExceptionTable exceptionTable, U2 attributesCount,
		Attributes attributes) {
		val result = JbcFactory.eINSTANCE.createCode
		result.attributeNameIndex = attributeNameIndex
		result.attributeLength = attributeLength
		result.maxStack = maxStack
		result.maxLocals = maxLocals
		result.codeLength = codeLength
		result.codeTable = codeTable
		result.exceptionTableLength = exceptionTableLength
		result.exceptionTable = exceptionTable
		result.attributesCount = attributesCount
		result.attributes = attributes
		return result
	}

	static def attributeEnclosingMethod(ConstantUtf8 attributeNameIndex, U4 attributeLength, ConstantClass classIndex,
		ConstantNameAndType methodIndex) {
		val result = JbcFactory.eINSTANCE.createEnclosingMethod
		result.attributeNameIndex = attributeNameIndex
		result.attributeLength = attributeLength
		result.classIndex = classIndex
		result.methodIndex = methodIndex
		return result
	}

	static def exceptionTable(ExceptionTableEntry... exceptionTableEntry) {
		val result = JbcFactory.eINSTANCE.createExceptionTable
		result.exceptionTableEntry.addAll(exceptionTableEntry)
		return result
	}

	static def exceptionTableEntry(CodeTableEntry startPc, CodeTableEntry endPc, CodeTableEntry handlerPc,
		ConstantClass catchType) {
		val result = JbcFactory.eINSTANCE.createExceptionTableEntry
		result.startPc = startPc
		result.endPc = endPc
		result.handlerPc = handlerPc
		result.catchType = catchType
		return result
	}

	static def codeTable(CodeTableEntry... copdeTableEntry) {
		val result = JbcFactory.eINSTANCE.createCodeTable
		result.instruction.addAll(copdeTableEntry)
		return result
	}

	static def attributeSourceFile(ConstantUtf8 attributeNameIndex, U4 attributeLength, ConstantUtf8 sourceFileIndex) {
		val result = JbcFactory.eINSTANCE.createSourceFile
		result.attributeNameIndex = attributeNameIndex
		result.attributeLength = attributeLength
		result.sourceFileIndex = sourceFileIndex
		return result
	}

	static def attributeLineNumberTable(ConstantUtf8 attributeNameIndex, U4 attributeLength, U2 lineNumberTableLength,
		LineNumber... lines) {
		val result = JbcFactory.eINSTANCE.createLineNumberTable
		result.attributeNameIndex = attributeNameIndex
		result.attributeLength = attributeLength
		result.lineNumberTableLength = lineNumberTableLength
		result.lineNumbers.addAll(lines)
		return result
	}

	static def lineNumber(CodeTableEntry startPc, U2 lineNumber) {
		val result = JbcFactory.eINSTANCE.createLineNumber
		result.startPc = startPc
		result.lineNumber = lineNumber
		return result
	}

	static def attributeModule(ConstantUtf8 attributeNameIndex, U4 attributeLength, ConstantModule moduleNameIndex,
			U2 moduleFlags, ConstantUtf8 moduleVersionIndex, U2 requiresCount, Requires[] requires, U2 exportsCount,
			Exports[] exports, U2 opensCount, Opens[] opens, U2 usesCount, Uses[] uses, U2 providesCount,
			Provides[] provides) {
		val result = JbcFactory.eINSTANCE.createModule
		result.attributeNameIndex = attributeNameIndex
		result.attributeLength = attributeLength
		result.moduleNameIndex = moduleNameIndex
		result.moduleFlags = moduleFlags
		result.moduleVersionIndex = moduleVersionIndex
		result.requiresCount = requiresCount
		result.requires.addAll(requires)
		result.exportsCount = exportsCount
		result.exports.addAll(exports)
		result.opensCount = opensCount
		result.opens.addAll(opens)
		result.usesCount = usesCount
		result.uses.addAll(uses)
		result.providesCount = providesCount
		result.provides.addAll(provides)
		return result
	}

	static def u1(int value) {
		val result = JbcFactory.eINSTANCE.createU1
		result.value = value.u1Value
		return result
	}

	static def u2(int value) {
		val result = JbcFactory.eINSTANCE.createU2
		result.value = value.u2Value
		return result
	}

	static def u4(int value) {
		val result = JbcFactory.eINSTANCE.createU4
		result.value = value.u4Value
		return result
	}

	static def uString(String value) {
		val result = JbcFactory.eINSTANCE.createUString
		result.value = value
		return result
	}

	static def aaload(U1 tag) {
		val result = JbcFactory.eINSTANCE.createAALOAD
		result.tag = tag
		return result
	}

	static def ldc(U1 tag, ConstantPoolEntry index) {
		val result = JbcFactory.eINSTANCE.createLDC
		result.tag = tag
		result.index = index
		return result
	}

	static def goTo(U1 tag, CodeTableEntry branch) {
		val result = JbcFactory.eINSTANCE.createGOTO
		result.tag = tag
		result.branch = branch
		return result
	}

	static def lookupswitch(U1 tag, U4 ^default, U4 npairs, MatchOffsetPair... matchOffsetPairs) {
		val result = JbcFactory.eINSTANCE.createLOOKUPSWITCH
		result.tag = tag
		result.^default = ^default
		result.npairs = npairs
		result.matchOffsetPairs.addAll(matchOffsetPairs)
		return result
	}

	static def lookupswitch(U1 tag, U1 pad0, U4 ^default, U4 npairs, MatchOffsetPair... matchOffsetPairs) {
		val result = JbcFactory.eINSTANCE.createLOOKUPSWITCH
		result.tag = tag
		result.pad0 = pad0
		result.^default = ^default
		result.npairs = npairs
		result.matchOffsetPairs.addAll(matchOffsetPairs)
		return result
	}

	static def lookupswitch(U1 tag, U1 pad0, U1 pad1, U4 ^default, U4 npairs, MatchOffsetPair... matchOffsetPairs) {
		val result = JbcFactory.eINSTANCE.createLOOKUPSWITCH
		result.tag = tag
		result.pad0 = pad0
		result.pad1 = pad1
		result.^default = ^default
		result.npairs = npairs
		result.matchOffsetPairs.addAll(matchOffsetPairs)
		return result
	}

	static def lookupswitch(U1 tag, U1 pad0, U1 pad1, U1 pad2, U4 ^default, U4 npairs,
		MatchOffsetPair... matchOffsetPairs) {
		val result = JbcFactory.eINSTANCE.createLOOKUPSWITCH
		result.tag = tag
		result.pad0 = pad0
		result.pad1 = pad1
		result.pad2 = pad2
		result.^default = ^default
		result.npairs = npairs
		result.matchOffsetPairs.addAll(matchOffsetPairs)
		return result
	}

	static def matchOffsetPair(U4 match, U4 offset) {
		val result = JbcFactory.eINSTANCE.createMatchOffsetPair
		result.match = match
		result.offset = offset
		return result
	}

	static def tableswitch(U1 tag, U4 ^default, U4 low, U4 high, JumpOffset... jumpOffsets) {
		val result = JbcFactory.eINSTANCE.createTABLESWITCH
		result.tag = tag
		result.^default = ^default
		result.low = low
		result.high = high
		result.jumpOffsets.addAll(jumpOffsets)
		return result
	}

	static def tableswitch(U1 tag, U1 pad0, U4 ^default, U4 low, U4 high, JumpOffset... jumpOffsets) {
		val result = JbcFactory.eINSTANCE.createTABLESWITCH
		result.tag = tag
		result.^default = ^default
		result.pad0 = pad0
		result.low = low
		result.high = high
		result.jumpOffsets.addAll(jumpOffsets)
		return result
	}

	static def tableswitch(U1 tag, U1 pad0, U1 pad1, U4 ^default, U4 low, U4 high, JumpOffset... jumpOffsets) {
		val result = JbcFactory.eINSTANCE.createTABLESWITCH
		result.tag = tag
		result.^default = ^default
		result.pad0 = pad0
		result.pad1 = pad1
		result.low = low
		result.high = high
		result.jumpOffsets.addAll(jumpOffsets)
		return result
	}

	static def tableswitch(U1 tag, U1 pad0, U1 pad1, U1 pad2, U4 ^default, U4 low, U4 high, JumpOffset... jumpOffsets) {
		val result = JbcFactory.eINSTANCE.createTABLESWITCH
		result.tag = tag
		result.^default = ^default
		result.pad0 = pad0
		result.pad1 = pad1
		result.pad2 = pad2
		result.low = low
		result.high = high
		result.jumpOffsets.addAll(jumpOffsets)
		return result
	}

	static def jumpOffset(U4 offset) {
		val result = JbcFactory.eINSTANCE.createJumpOffset
		result.offset = offset
		return result
	}

	static def nop(U1 tag) {
		val result = JbcFactory.eINSTANCE.createNOP
		result.tag = tag
		return result
	}

}
