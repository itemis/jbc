package com.itemis.jbc.binary

import com.itemis.jbc.jbc.AttributeInfo
import com.itemis.jbc.jbc.ClassFile
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
import com.itemis.jbc.jbc.GOTO
import com.itemis.jbc.jbc.GOTO_W
import com.itemis.jbc.jbc.IFEQ
import com.itemis.jbc.jbc.IFGE
import com.itemis.jbc.jbc.IFGT
import com.itemis.jbc.jbc.IFLE
import com.itemis.jbc.jbc.IFLT
import com.itemis.jbc.jbc.IFNE
import com.itemis.jbc.jbc.IFNONNULL
import com.itemis.jbc.jbc.IFNULL
import com.itemis.jbc.jbc.IF_ACMPEQ
import com.itemis.jbc.jbc.IF_ACMPNE
import com.itemis.jbc.jbc.IF_ICMPEQ
import com.itemis.jbc.jbc.IF_ICMPGE
import com.itemis.jbc.jbc.IF_ICMPGT
import com.itemis.jbc.jbc.IF_ICMPLE
import com.itemis.jbc.jbc.IF_ICMPLT
import com.itemis.jbc.jbc.IF_ICMPNE
import com.itemis.jbc.jbc.JbcFactory
import com.itemis.jbc.jbc.U1
import com.itemis.jbc.jbc.U2
import com.itemis.jbc.jbc.U4
import com.itemis.jbc.jbc.UString
import java.io.ByteArrayInputStream
import java.io.DataInputStream
import java.util.LinkedHashMap
import java.util.Map

import static com.itemis.jbc.binary.ClassFileFactoryAPI.*

import static extension com.itemis.jbc.binary.ClassFileAccessAPI.*

class ByteCodeReader {

	def static ClassFile fromByteArray(byte[] content) {
		return fromDataInputStream(new DataInputStream(new ByteArrayInputStream(content)))
	}

	def static fromDataInputStream(DataInputStream stream) {
		return new ByteCodeReader(stream).readClassFile
	}

	DataInputStream stream
	ClassFile classFile
	CodeTable currentCodeTable

	package new(DataInputStream stream) {
		this.stream = stream
	}

	package def readClassFile() {
		val result = JbcFactory.eINSTANCE.createClassFile
		classFile = result
		result.magic = readU4
		result.minorVersion = readU2
		result.majorVersion = readU2
		result.constantPoolCount = readU2
		result.constantPool = readConstantPool(result.constantPoolCount)
		result.accessFlags = readU2
		result.thisClass = readConstantClassRef
		result.superClass = readConstantClassRef
		result.interfaceCount = readU2
		result.interfaces = readInterfaces(result.interfaceCount)
		result.fieldsCount = readU2
		result.fields = readFields(result.fieldsCount)
		result.methodsCount = readU2
		result.methods = readMethods(result.methodsCount)
		result.attributesCount = readU2
		result.attributes = readAttributes(result.attributesCount)
		return result
	}

	package def ConstantPool readConstantPool(U2 constantPoolCount) {
		val result = JbcFactory.eINSTANCE.createConstantPool
		val map = new LinkedHashMap<ConstantPoolEntry, Pair<Integer, Integer>>
		for (var i = 0; i < constantPoolCount.intValue - 1; i++) { // length of constant pool is cont - 1
			val tag = readU1
			var ConstantPoolEntry constant;
			switch tag.intValue.entryTypeForTag {
				case ConstantUtf8:
					constant = readConstantUtf8(tag)
				case ConstantInteger:
					constant = constantInteger(tag, readU4)
				case ConstantFloat:
					constant = constantFloat(tag, readU4)
				case ConstantLong: {
					constant = constantLong(tag, readU4, readU4)
					i++ // 'long' needs two slots in the constant pool
				}
				case ConstantDouble: {
					constant = constantDouble(tag, readU4, readU4)
					i++ // 'double' needs two slots in the constant pool
				}
				case ConstantClass:
					map.put(constant = constantClass(tag, null), Pair.of(stream.readUnsignedShort, null))
				case ConstantString:
					map.put(constant = constantString(tag, null), Pair.of(stream.readUnsignedShort, null))
				case ConstantFieldRef:
					map.put(constant = constantFieldRef(tag, null, null),
						Pair.of(stream.readUnsignedShort, stream.readUnsignedShort))
				case ConstantMethodRef:
					map.put(constant = constantMethodRef(tag, null, null),
						Pair.of(stream.readUnsignedShort, stream.readUnsignedShort))
				case ConstantInterfaceMethodRef:
					map.put(constant = constantInterfaceMethodRef(tag, null, null),
						Pair.of(stream.readUnsignedShort, stream.readUnsignedShort))
				case ConstantNameAndType:
					map.put(constant = constantNameAndType(tag, null, null),
						Pair.of(stream.readUnsignedShort, stream.readUnsignedShort))
				case ConstantMethodHandle:
					map.put(constant = constantMethodHandle(tag, readU1, null), Pair.of(stream.readUnsignedShort, null))
				case ConstantMethodType:
					map.put(constant = constantMethodType(tag, null), Pair.of(stream.readUnsignedShort, null))
				case ConstantInvoceDynamic:
					map.put(constant = constantInvoceDynamic(tag, readU2, null),
						Pair.of(stream.readUnsignedShort, null))
				case ConstantModule:
					map.put(constant = constantModule(tag, null), Pair.of(stream.readUnsignedShort, null))
				case ConstantPackage:
					map.put(constant = constantPackage(tag, null), Pair.of(stream.readUnsignedShort, null))
				default:
					throw new RuntimeException("Unknown tag: " + tag)
			}
			result.cpInfo.add(constant)
		}
		result.addFromMaps(map)
		return result
	}

	private def addFromMaps(ConstantPool pool, Map<ConstantPoolEntry, Pair<Integer, Integer>> map) {
		for (e : map.entrySet) {
			val entry = e.key
			switch entry {
				ConstantClass:
					entry.nameIndex = pool.getConstantUtf8(e.value.key)
				ConstantString:
					entry.stringIndex = pool.getConstantUtf8(e.value.key)
				ConstantFieldRef: {
					entry.classIndex = pool.getConstantClass(e.value.key);
					entry.nameAndTypeIndex = pool.getConstantNameAndType(e.value.value)
				}
				ConstantMethodRef: {
					entry.classIndex = pool.getConstantClass(e.value.key);
					entry.nameAndTypeIndex = pool.getConstantNameAndType(e.value.value)
				}
				ConstantInterfaceMethodRef: {
					entry.classIndex = pool.getConstantClass(e.value.key);
					entry.nameAndTypeIndex = pool.getConstantNameAndType(e.value.value)
				}
				ConstantNameAndType: {
					entry.nameIndex = pool.getConstantUtf8(e.value.key);
					entry.descriptorIndex = pool.getConstantUtf8(e.value.value)
				}
				ConstantMethodHandle:
					entry.referenceIndex = pool.getConstant(e.value.key)
				ConstantMethodType:
					entry.descriptorIndex = pool.getConstantUtf8(e.value.key)
				ConstantInvoceDynamic:
					entry.nameAndTypeIndex = pool.getConstantNameAndType(e.value.key)
				ConstantModule:
					entry.nameIndex = pool.getConstantUtf8(e.value.key)
				ConstantPackage:
					entry.nameIndex = pool.getConstantUtf8(e.value.key)
			}
		}
	}

	private def readConstantUtf8(U1 tag) {
		val result = JbcFactory.eINSTANCE.createConstantUtf8
		result.tag = tag
		result.content = readString
		return result
	}

	private def readInterfaces(U2 interfaceCount) {
		val result = JbcFactory.eINSTANCE.createInterfaces
		for (var i = 0; i < interfaceCount.intValue; i++)
			result.interfaceInfo.add(readInterface)
		return result
	}

	private def readInterface() {
		val result = JbcFactory.eINSTANCE.createInterface
		result.info = readConstantClassRef
		return result
	}

	private def readFields(U2 fieldsCount) {
		val result = JbcFactory.eINSTANCE.createFields
		for (var i = 0; i < fieldsCount.intValue; i++)
			result.fieldInfo.add(readField)
		return result
	}

	private def readField() {
		val result = JbcFactory.eINSTANCE.createFieldInfo
		result.accessFlags = readU2
		result.nameIndex = readConstantUtf8Ref
		result.descriptorIndex = readConstantUtf8Ref
		result.attributesCount = readU2
		result.attributes = readAttributes(result.attributesCount)
		return result
	}

	private def readMethods(U2 methodsCount) {
		val result = JbcFactory.eINSTANCE.createMethods
		for (var i = 0; i < methodsCount.intValue; i++)
			result.methodsInfo.add(readMethod)
		return result
	}

	private def readMethod() {
		val result = JbcFactory.eINSTANCE.createMethodInfo
		result.accessFlags = readU2
		result.nameIndex = readConstantUtf8Ref
		result.descriptorIndex = readConstantUtf8Ref
		result.attributesCount = readU2
		result.attributes = readAttributes(result.attributesCount)
		return result
	}

	private def readAttributes(U2 attributesCount) {
		val result = JbcFactory.eINSTANCE.createAttributes
		for (var i = 0; i < attributesCount.intValue; i++)
			result.attributeInfo.add(readAttribute)
		return result
	}

	private def AttributeInfo readAttribute() {
		val attributeNameIndex = readConstantUtf8Ref
		val attributeLength = readU4
		if (attributeNameIndex === null) {
			throw new RuntimeException // TODO create better exception
		}
		if ("ConstantValue".equals(attributeNameIndex.getStringValue())) {
			return readConstantValueAttribute(attributeNameIndex, attributeLength)
		} else if ("Code".equals(attributeNameIndex.getStringValue())) {
			return readCodeAttribute(attributeNameIndex, attributeLength)
		} else if ("SourceFile".equals(attributeNameIndex.getStringValue())) {
			return readSourceFileAttribute(attributeNameIndex, attributeLength)
		} else if ("LineNumberTable".equals(attributeNameIndex.getStringValue())) {
			return readLineNumberTableAttribute(attributeNameIndex, attributeLength)
		} else if ("LocalVariableTable".equals(attributeNameIndex.getStringValue())) {
			return readLocalVariableTableAttribute(attributeNameIndex, attributeLength)
		} else if ("Exceptions".equals(attributeNameIndex.getStringValue())) {
			return readExceptionsAttribute(attributeNameIndex, attributeLength)
		} else if ("InnerClasses".equals(attributeNameIndex.getStringValue())) {
			return readInnerClassesAttribute(attributeNameIndex, attributeLength)
		} else if ("EnclosingMethod".equals(attributeNameIndex.getStringValue())) {
			return readEnclosingMethodAttribute(attributeNameIndex, attributeLength)
		} else if ("Module".equals(attributeNameIndex.getStringValue())) {
			return readModuleAttribute(attributeNameIndex, attributeLength)
		}
		return readUnknownAttribute(attributeNameIndex, attributeLength)
	}

	def readUnknownAttribute(ConstantUtf8 attributeNameIndex, U4 attributeLength) {
		val result = JbcFactory.eINSTANCE.createUnknown
		result.attributeNameIndex = attributeNameIndex
		result.attributeLength = attributeLength
		result.info.addAll(readBytes(result.attributeLength.intValue))
		return result
	}

	def readConstantValueAttribute(ConstantUtf8 attributeNameIndex, U4 attributeLength) {
		val result = JbcFactory.eINSTANCE.createConstantValue
		result.attributeNameIndex = attributeNameIndex
		result.attributeLength = attributeLength
		result.constantValueIndex = readConstantPoolEntryRef
		return result
	}

	def readCodeAttribute(ConstantUtf8 attributeNameIndex, U4 attributeLength) {
		val result = JbcFactory.eINSTANCE.createCode
		result.attributeNameIndex = attributeNameIndex
		result.attributeLength = attributeLength
		result.maxStack = readU2
		result.maxLocals = readU2
		result.codeLength = readU4
		result.codeTable = readCodeTable(result.codeLength)
		result.exceptionTableLength = readU2
		result.exceptionTable = readExceptionTable(result.exceptionTableLength)
		result.attributesCount = readU2
		result.attributes = readAttributes(result.attributesCount)
		return result
	}

	private def readExceptionTable(U2 exceptionTableLength) {
		val result = JbcFactory.eINSTANCE.createExceptionTable
		for (var i = 0; i < exceptionTableLength.intValue; i++)
			result.exceptionTableEntry.add(readExceptionTableEntry)
		return result
	}

	private def readExceptionTableEntry() {
		val result = JbcFactory.eINSTANCE.createExceptionTableEntry
		result.startPc = readCodeTableEntryRef
		result.endPc = readCodeTableEntryRef
		result.handlerPc = readCodeTableEntryRef
		result.catchType = readConstantClassRef
		return result
	}

	private def readCodeTable(U4 codeLength) {
		val f = JbcFactory.eINSTANCE
		val result = f.createCodeTable
		this.currentCodeTable = result
		val Map<CodeTableEntry, Pair<Integer, Integer>> map = new LinkedHashMap<CodeTableEntry, Pair<Integer, Integer>>
		val length = codeLength.intValue
		var offset = 0
		while (offset < length) {
			val tag = readU1
			val opcode = Opcode.from(tag.intValue)
			val instance = opcode.readInstance(this, offset, map)
			instance.tag = tag
			offset += instance.byteCount
			result.instruction.add(instance)
		}
		for (entry : map.entrySet) {
			val code = entry.key
			switch code {
				GOTO: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				GOTO_W: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				IF_ACMPEQ: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				IF_ACMPNE: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				IF_ICMPEQ: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				IF_ICMPNE: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				IF_ICMPLT: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				IF_ICMPGE: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				IF_ICMPGT: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				IF_ICMPLE: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				IFEQ: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				IFNE: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				IFLT: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				IFGE: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				IFGT: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				IFLE: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				IFNONNULL: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				IFNULL: code.branch = code.table.instructionFromOffset(code.offset + entry.value.key)
				default: throw new RuntimeException() // TODO create better exception
			}
		}
		return result
	}

	private def readSourceFileAttribute(ConstantUtf8 attributeNameIndex, U4 attributeLength) {
		val result = JbcFactory.eINSTANCE.createSourceFile
		result.attributeNameIndex = attributeNameIndex
		result.attributeLength = attributeLength
		result.sourceFileIndex = readConstantUtf8Ref
		return result
	}

	private def readLineNumberTableAttribute(ConstantUtf8 attributeNameIndex, U4 attributeLength) {
		val result = JbcFactory.eINSTANCE.createLineNumberTable
		result.attributeNameIndex = attributeNameIndex
		result.attributeLength = attributeLength
		result.lineNumberTableLength = readU2
		for (var n = 0; n < result.lineNumberTableLength.intValue; n++)
			result.lineNumbers.add(readLineNumber)
		return result
	}

	private def readLineNumber() {
		val result = JbcFactory.eINSTANCE.createLineNumber
		result.startPc = readCodeTableEntryRef
		result.lineNumber = readU2
		return result
	}

	private def readLocalVariableTableAttribute(ConstantUtf8 attributeNameIndex, U4 attributeLength) {
		val result = JbcFactory.eINSTANCE.createLocalVariableTable
		result.attributeNameIndex = attributeNameIndex
		result.attributeLength = attributeLength
		result.localVariableTableLength = readU2
		for (var n = 0; n < result.localVariableTableLength.intValue; n++)
			result.localVariables.add(readLocalVariable)
		return result
	}

	private def readLocalVariable() {
		val result = JbcFactory.eINSTANCE.createLocalVariable
		result.startPc = readCodeTableEntryRef
		result.length = readU2
		result.nameIndex = readConstantUtf8Ref
		result.descriptorIndex = readConstantUtf8Ref
		result.index = readU2
		return result
	}

	private def readExceptionsAttribute(ConstantUtf8 attributeNameIndex, U4 attributeLength) {
		val result = JbcFactory.eINSTANCE.createExceptions
		result.attributeNameIndex = attributeNameIndex
		result.attributeLength = attributeLength
		result.numberOfExceptions = readU2
		for (var n = 0; n < result.numberOfExceptions.intValue; n++)
			result.exception.add(readException)
		return result
	}

	private def readException() {
		val result = JbcFactory.eINSTANCE.createException
		result.index = readConstantClassRef
		return result
	}

	private def readInnerClassesAttribute(ConstantUtf8 attributeNameIndex, U4 attributeLength) {
		val result = JbcFactory.eINSTANCE.createInnerClasses
		result.attributeNameIndex = attributeNameIndex
		result.attributeLength = attributeLength
		result.numberOfClasses = readU2
		for (var n = 0; n < result.numberOfClasses.intValue; n++)
			result.innerClasses.add(readInnerClass)
		return result
	}

	private def readInnerClass() {
		val result = JbcFactory.eINSTANCE.createInnerClass
		result.innerClassInfoIndex = readConstantClassRef
		result.outerClassInfoIndex = readConstantClassRef
		result.innerNameIndex = readConstantUtf8Ref
		result.innerClassAccessFlags = readU2
		return result
	}

	private def readEnclosingMethodAttribute(ConstantUtf8 attributeNameIndex, U4 attributeLength) {
		val result = JbcFactory.eINSTANCE.createEnclosingMethod
		result.attributeNameIndex = attributeNameIndex
		result.attributeLength = attributeLength
		result.classIndex = readConstantClassRef
		result.methodIndex = readConstantNameAndTypeRef
		return result
	}

	private def readModuleAttribute(ConstantUtf8 attributeNameIndex, U4 attributeLength) {
		val result = JbcFactory.eINSTANCE.createModule
		result.attributeNameIndex = attributeNameIndex
		result.attributeLength = attributeLength
		result.moduleNameIndex = readConstantModuleRef
		result.moduleFlags = readU2
		result.moduleVersionIndex = readConstantUtf8Ref
		result.requiresCount = readU2
		for (var n = 0; n < result.requiresCount.intValue; n++)
			result.requires.add(readRequires)
		result.exportsCount = readU2
		for (var n = 0; n < result.exportsCount.intValue; n++)
			result.exports.add(readExports)
		result.opensCount = readU2
		for (var n = 0; n < result.opensCount.intValue; n++)
			result.opens.add(readOpens)
		result.usesCount = readU2
		for (var n = 0; n < result.usesCount.intValue; n++)
			result.uses.add(readUses)
		result.providesCount = readU2
		for (var n = 0; n < result.providesCount.intValue; n++)
			result.provides.add(readProvides)
		return result
	}

	package def readRequires() {
		val result = JbcFactory.eINSTANCE.createRequires
		result.requiresIndex = readConstantModuleRef
		result.requiresFlags = readU2
		result.requiresVersionIndex = readConstantUtf8Ref
		return result
	}

	package def readExports() {
		val result = JbcFactory.eINSTANCE.createExports
		result.exportsIndex = readConstantPackageRef
		result.exportsFlags = readU2
		result.exportsToCount = readU2
		for (var n = 0; n < result.exportsToCount.intValue; n++)
			result.exportsTo.add(readExportsTo)
		return result
	}

	package def readExportsTo() {
		val result = JbcFactory.eINSTANCE.createExportsTo
		result.exportsToIndex = readConstantModuleRef
		return result
	}

	package def readOpens() {
		val result = JbcFactory.eINSTANCE.createOpens
		result.opensIndex = readConstantPackageRef
		result.opensFlags = readU2
		result.opensToCount = readU2
		for (var n = 0; n < result.opensToCount.intValue; n++)
			result.opensTo.add(readOpensTo)
		return result
	}

	package def readOpensTo() {
		val result = JbcFactory.eINSTANCE.createOpensTo
		result.opensToIndex = readConstantModuleRef
		return result
	}

	package def readUses() {
		val result = JbcFactory.eINSTANCE.createUses
		result.usesIndex = readConstantClassRef
		return result
	}

	package def readProvides() {
		val result = JbcFactory.eINSTANCE.createProvides
		result.providesIndex = readConstantClassRef
		result.providesWithCount = readU2
		for (var n = 0; n < result.providesWithCount.intValue; n++)
			result.providesWith.add(readProvidesWith)
		return result
	}

	package def readProvidesWith() {
		val result = JbcFactory.eINSTANCE.createProvidesWith
		result.providesWithIndex = readConstantClassRef
		return result
	}

	package def readConstantPoolEntryRef() {
		classFile.constantPool.getConstant(stream.readUnsignedShort)
	}

	package def readConstantPoolEntryRefFromByte() {
		classFile.constantPool.getConstant(stream.readUnsignedByte)
	}

	package def readConstantUtf8Ref() {
		classFile.constantPool.getConstantUtf8(stream.readUnsignedShort)
	}

	package def readConstantClassRef() {
		classFile.constantPool.getConstantClass(stream.readUnsignedShort)
	}

	package def readConstantFieldRef() {
		classFile.constantPool.getConstantFieldRef(stream.readUnsignedShort)
	}

	package def readConstantMethodRef() {
		classFile.constantPool.getConstantMethodRef(stream.readUnsignedShort)
	}

	package def readConstantNameAndTypeRef() {
		classFile.constantPool.getConstantNameAndType(stream.readUnsignedShort)
	}

	package def readConstantModuleRef() {
		classFile.constantPool.getConstantModule(stream.readUnsignedShort)
	}

	package def readConstantPackageRef() {
		classFile.constantPool.getConstantPackage(stream.readUnsignedShort)
	}

	package def readCodeTableEntryRef() {
		currentCodeTable.instructionFromOffset(stream.readUnsignedShort)
	}

	package def U1 readU1() {
		val result = JbcFactory.eINSTANCE.createU1
		result.value = String.format("%02X", stream.readUnsignedByte)
		return result
	}

	package def U2 readU2() {
		val result = JbcFactory.eINSTANCE.createU2
		result.value = String.format("%04X", stream.readUnsignedShort)
		return result
	}

	package def U4 readU4() {
		val result = JbcFactory.eINSTANCE.createU4
		result.value = String.format("%08X", stream.readInt)
		return result
	}

	package def UString readString() {
		val result = JbcFactory.eINSTANCE.createUString
		result.value = stream.readUTF
		return result
	}

	package def U1[] readBytes(int count) {
		val result = newArrayOfSize(count)
		for (var i = 0; i < count; i++)
			result.set(i, readU1)
		return result
	}

	package def int readUnsignedShort() {
		return stream.readUnsignedShort
	}

	package def int readShort() {
		return stream.readShort
	}

	package def int readInt() {
		return stream.readInt
	}

	private def int getByteCount(CodeTableEntry entry) {
		return Opcode.byteCount(entry)
	}

}
