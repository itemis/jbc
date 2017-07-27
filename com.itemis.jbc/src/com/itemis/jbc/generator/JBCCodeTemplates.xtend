package com.itemis.jbc.generator

import com.itemis.jbc.jbc.AALOAD
import com.itemis.jbc.jbc.AASTORE
import com.itemis.jbc.jbc.ACONST_NULL
import com.itemis.jbc.jbc.ALOAD
import com.itemis.jbc.jbc.ALOAD_0
import com.itemis.jbc.jbc.ALOAD_1
import com.itemis.jbc.jbc.ALOAD_2
import com.itemis.jbc.jbc.ALOAD_3
import com.itemis.jbc.jbc.ANEWARRAY
import com.itemis.jbc.jbc.ARETURN
import com.itemis.jbc.jbc.ARRAYLENGTH
import com.itemis.jbc.jbc.ASTORE
import com.itemis.jbc.jbc.ASTORE_0
import com.itemis.jbc.jbc.ASTORE_1
import com.itemis.jbc.jbc.ASTORE_2
import com.itemis.jbc.jbc.ASTORE_3
import com.itemis.jbc.jbc.ATHROW
import com.itemis.jbc.jbc.Attributes
import com.itemis.jbc.jbc.BALOAD
import com.itemis.jbc.jbc.BASTORE
import com.itemis.jbc.jbc.BIPUSH
import com.itemis.jbc.jbc.CALOAD
import com.itemis.jbc.jbc.CASTORE
import com.itemis.jbc.jbc.CHECKCAST
import com.itemis.jbc.jbc.ClassFile
import com.itemis.jbc.jbc.Code
import com.itemis.jbc.jbc.CodeTable
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
import com.itemis.jbc.jbc.ConstantNameAndType
import com.itemis.jbc.jbc.ConstantPool
import com.itemis.jbc.jbc.ConstantString
import com.itemis.jbc.jbc.ConstantUtf8
import com.itemis.jbc.jbc.ConstantValue
import com.itemis.jbc.jbc.D2F
import com.itemis.jbc.jbc.D2I
import com.itemis.jbc.jbc.D2L
import com.itemis.jbc.jbc.DADD
import com.itemis.jbc.jbc.DALOAD
import com.itemis.jbc.jbc.DASTORE
import com.itemis.jbc.jbc.DCMPG
import com.itemis.jbc.jbc.DCMPL
import com.itemis.jbc.jbc.DCONST_0
import com.itemis.jbc.jbc.DCONST_1
import com.itemis.jbc.jbc.DDIV
import com.itemis.jbc.jbc.DLOAD
import com.itemis.jbc.jbc.DLOAD_0
import com.itemis.jbc.jbc.DLOAD_1
import com.itemis.jbc.jbc.DLOAD_2
import com.itemis.jbc.jbc.DLOAD_3
import com.itemis.jbc.jbc.DMUL
import com.itemis.jbc.jbc.DNEG
import com.itemis.jbc.jbc.DREM
import com.itemis.jbc.jbc.DRETURN
import com.itemis.jbc.jbc.DSTORE
import com.itemis.jbc.jbc.DSTORE_0
import com.itemis.jbc.jbc.DSTORE_1
import com.itemis.jbc.jbc.DSTORE_2
import com.itemis.jbc.jbc.DSTORE_3
import com.itemis.jbc.jbc.DSUB
import com.itemis.jbc.jbc.DUP
import com.itemis.jbc.jbc.DUP2
import com.itemis.jbc.jbc.DUP2_X1
import com.itemis.jbc.jbc.DUP2_X2
import com.itemis.jbc.jbc.DUP_X1
import com.itemis.jbc.jbc.DUP_X2
import com.itemis.jbc.jbc.ExceptionTable
import com.itemis.jbc.jbc.Exceptions
import com.itemis.jbc.jbc.F2D
import com.itemis.jbc.jbc.F2I
import com.itemis.jbc.jbc.F2L
import com.itemis.jbc.jbc.FADD
import com.itemis.jbc.jbc.FALOAD
import com.itemis.jbc.jbc.FASTORE
import com.itemis.jbc.jbc.FCMPG
import com.itemis.jbc.jbc.FCMPL
import com.itemis.jbc.jbc.FCONST_0
import com.itemis.jbc.jbc.FCONST_1
import com.itemis.jbc.jbc.FCONST_2
import com.itemis.jbc.jbc.FDIV
import com.itemis.jbc.jbc.FLOAD
import com.itemis.jbc.jbc.FLOAD_0
import com.itemis.jbc.jbc.FLOAD_1
import com.itemis.jbc.jbc.FLOAD_2
import com.itemis.jbc.jbc.FLOAD_3
import com.itemis.jbc.jbc.FMUL
import com.itemis.jbc.jbc.FNEG
import com.itemis.jbc.jbc.FREM
import com.itemis.jbc.jbc.FRETURN
import com.itemis.jbc.jbc.FSTORE
import com.itemis.jbc.jbc.FSTORE_0
import com.itemis.jbc.jbc.FSTORE_1
import com.itemis.jbc.jbc.FSTORE_2
import com.itemis.jbc.jbc.FSTORE_3
import com.itemis.jbc.jbc.FSUB
import com.itemis.jbc.jbc.FieldInfo
import com.itemis.jbc.jbc.Fields
import com.itemis.jbc.jbc.GETFIELD
import com.itemis.jbc.jbc.GETSTATIC
import com.itemis.jbc.jbc.GOTO
import com.itemis.jbc.jbc.GOTO_W
import com.itemis.jbc.jbc.I2B
import com.itemis.jbc.jbc.I2C
import com.itemis.jbc.jbc.I2D
import com.itemis.jbc.jbc.I2F
import com.itemis.jbc.jbc.I2L
import com.itemis.jbc.jbc.I2S
import com.itemis.jbc.jbc.IADD
import com.itemis.jbc.jbc.IALOAD
import com.itemis.jbc.jbc.IAND
import com.itemis.jbc.jbc.IASTORE
import com.itemis.jbc.jbc.ICONST_0
import com.itemis.jbc.jbc.ICONST_1
import com.itemis.jbc.jbc.ICONST_2
import com.itemis.jbc.jbc.ICONST_3
import com.itemis.jbc.jbc.ICONST_4
import com.itemis.jbc.jbc.ICONST_5
import com.itemis.jbc.jbc.ICONST_ML
import com.itemis.jbc.jbc.IDIV
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
import com.itemis.jbc.jbc.IINC
import com.itemis.jbc.jbc.ILOAD
import com.itemis.jbc.jbc.ILOAD_0
import com.itemis.jbc.jbc.ILOAD_1
import com.itemis.jbc.jbc.ILOAD_2
import com.itemis.jbc.jbc.ILOAD_3
import com.itemis.jbc.jbc.IMUL
import com.itemis.jbc.jbc.INEG
import com.itemis.jbc.jbc.INSTANCEOF
import com.itemis.jbc.jbc.INVOKEDYNAMIC
import com.itemis.jbc.jbc.INVOKEINTERFACE
import com.itemis.jbc.jbc.INVOKESPECIAL
import com.itemis.jbc.jbc.INVOKESTATIC
import com.itemis.jbc.jbc.INVOKEVIRTUAL
import com.itemis.jbc.jbc.IOR
import com.itemis.jbc.jbc.IREM
import com.itemis.jbc.jbc.IRETURN
import com.itemis.jbc.jbc.ISHL
import com.itemis.jbc.jbc.ISHR
import com.itemis.jbc.jbc.ISTORE
import com.itemis.jbc.jbc.ISTORE_0
import com.itemis.jbc.jbc.ISTORE_1
import com.itemis.jbc.jbc.ISTORE_2
import com.itemis.jbc.jbc.ISTORE_3
import com.itemis.jbc.jbc.ISUB
import com.itemis.jbc.jbc.IUSHR
import com.itemis.jbc.jbc.IXOR
import com.itemis.jbc.jbc.InnerClasses
import com.itemis.jbc.jbc.Interfaces
import com.itemis.jbc.jbc.JSR
import com.itemis.jbc.jbc.JSR_W
import com.itemis.jbc.jbc.L2D
import com.itemis.jbc.jbc.L2F
import com.itemis.jbc.jbc.L2I
import com.itemis.jbc.jbc.LADD
import com.itemis.jbc.jbc.LALOAD
import com.itemis.jbc.jbc.LAND
import com.itemis.jbc.jbc.LASTORE
import com.itemis.jbc.jbc.LCMP
import com.itemis.jbc.jbc.LCONST_0
import com.itemis.jbc.jbc.LCONST_1
import com.itemis.jbc.jbc.LDC
import com.itemis.jbc.jbc.LDC2_W
import com.itemis.jbc.jbc.LDC_W
import com.itemis.jbc.jbc.LDIV
import com.itemis.jbc.jbc.LLOAD
import com.itemis.jbc.jbc.LLOAD_0
import com.itemis.jbc.jbc.LLOAD_1
import com.itemis.jbc.jbc.LLOAD_2
import com.itemis.jbc.jbc.LLOAD_3
import com.itemis.jbc.jbc.LMUL
import com.itemis.jbc.jbc.LNEG
import com.itemis.jbc.jbc.LOOKUPSWITCH
import com.itemis.jbc.jbc.LOR
import com.itemis.jbc.jbc.LREM
import com.itemis.jbc.jbc.LRETURN
import com.itemis.jbc.jbc.LSHL
import com.itemis.jbc.jbc.LSHR
import com.itemis.jbc.jbc.LSTORE
import com.itemis.jbc.jbc.LSTORE_0
import com.itemis.jbc.jbc.LSTORE_1
import com.itemis.jbc.jbc.LSTORE_2
import com.itemis.jbc.jbc.LSTORE_3
import com.itemis.jbc.jbc.LSUB
import com.itemis.jbc.jbc.LUSHR
import com.itemis.jbc.jbc.LXOR
import com.itemis.jbc.jbc.LineNumberTable
import com.itemis.jbc.jbc.LocalVariableTable
import com.itemis.jbc.jbc.MONITORENTER
import com.itemis.jbc.jbc.MONITOREXIT
import com.itemis.jbc.jbc.MULTIANEWARRAY
import com.itemis.jbc.jbc.MethodInfo
import com.itemis.jbc.jbc.Methods
import com.itemis.jbc.jbc.NEW
import com.itemis.jbc.jbc.NEWARRAY
import com.itemis.jbc.jbc.NOP
import com.itemis.jbc.jbc.POP
import com.itemis.jbc.jbc.POP2
import com.itemis.jbc.jbc.PUTFIELD
import com.itemis.jbc.jbc.PUTSTATIC
import com.itemis.jbc.jbc.RET
import com.itemis.jbc.jbc.RETURN
import com.itemis.jbc.jbc.SALOAD
import com.itemis.jbc.jbc.SASTORE
import com.itemis.jbc.jbc.SIPUSH
import com.itemis.jbc.jbc.SWAP
import com.itemis.jbc.jbc.SourceFile
import com.itemis.jbc.jbc.TABLESWITCH
import com.itemis.jbc.jbc.U1
import com.itemis.jbc.jbc.Unknown
import com.itemis.jbc.jbc.WIDE
import org.apache.commons.lang3.StringEscapeUtils
import org.eclipse.emf.common.util.EList

import static extension com.itemis.jbc.binary.ClassFileAccessAPI.*

class JBCCodeTemplates {

	def static String code(ClassFile classFile) {
		'''
			ClassFile {
				«classFile.magic.value» «classFile.minorVersion.value» «classFile.majorVersion.value» «classFile.constantPoolCount.value» «classFile.constantPool.code»
				«classFile.accessFlags.value» «classFile.thisClass.index.u2Value» «classFile.superClass.index.u2Value» «classFile.interfaceCount.value» «classFile.interfaces.code»
				«classFile.fieldsCount.value» «classFile.fields.code»
				«classFile.methodsCount.value» «classFile.methods.code»
				«classFile.attributesCount.value» «classFile.attributes.code»
			}
		'''
	}

	def static String code(ConstantPool constantPool) {
		'''
			ConstantPool {
				«FOR constant : constantPool.cpInfo»
					«constant.constantCode»
				«ENDFOR»
			}
		'''
	}

	def dispatch static String constantCode(ConstantUtf8 constant) {
		'''utf8 «constant.tag.value» "«StringEscapeUtils.escapeJava(constant.content.value)»"'''
	}

	def dispatch static String constantCode(ConstantInteger constant) {
		'''integer «constant.tag.value» «constant.bytes.value»'''
	}

	def dispatch static String constantCode(ConstantFloat constant) {
		'''float «constant.tag.value» «constant.bytes.value»'''
	}

	def dispatch static String constantCode(ConstantLong constant) {
		'''long «constant.tag.value» «constant.highBytes.value» «constant.lowBytes.value»'''
	}

	def dispatch static String constantCode(ConstantDouble constant) {
		'''double «constant.tag.value» «constant.highBytes.value» «constant.lowBytes.value»'''
	}

	def dispatch static String constantCode(ConstantClass constant) {
		'''class «constant.tag.value» «constant.nameIndex?.index.u2Value»'''
	}

	def dispatch static String constantCode(ConstantString constant) {
		'''string «constant.tag.value» «constant.stringIndex?.index.u2Value»'''
	}

	def dispatch static String constantCode(ConstantFieldRef constant) {
		'''fieldRef «constant.tag.value» «constant.classIndex?.index.u2Value» «constant.nameAndTypeIndex?.index.u2Value»'''
	}

	def dispatch static String constantCode(ConstantMethodRef constant) {
		'''methodRef «constant.tag.value» «constant.classIndex?.index.u2Value» «constant.nameAndTypeIndex?.index.u2Value»'''
	}

	def dispatch static String constantCode(ConstantInterfaceMethodRef constant) {
		'''interfaceMethodRef «constant.tag.value» «constant.classIndex?.index.u2Value» «constant.nameAndTypeIndex?.index.u2Value»'''
	}

	def dispatch static String constantCode(ConstantNameAndType constant) {
		'''nameAndType «constant.tag.value» «constant.nameIndex?.index.u2Value» «constant.descriptorIndex?.index.u2Value»'''
	}

	def dispatch static String constantCode(ConstantMethodHandle constant) {
		'''methodHandle «constant.tag.value» «constant.referenceKind.value» «constant.referenceIndex?.index.u2Value»'''
	}

	def dispatch static String constantCode(ConstantMethodType constant) {
		'''methodType «constant.tag.value» «constant.descriptorIndex?.index.u2Value»'''
	}

	def dispatch static String constantCode(ConstantInvoceDynamic constant) {
		'''invoceDynamic «constant.tag.value» «constant.bootstrapMethodAttrIndex.value» «constant.nameAndTypeIndex?.index.u2Value»'''
	}

	def static String code(Interfaces interfaces) {
		'''
			Interfaces {
				«FOR i : interfaces.interfaceInfo»
					«i.info.index.u2Value»
				«ENDFOR»
			}
		'''
	}

	def static String code(Fields fields) {
		'''
			Fields {
				«FOR field : fields.fieldInfo»
					«field.code»
				«ENDFOR»
			}
		'''
	}

	def static String code(FieldInfo field) {
		'''field «field.accessFlags.value» «field.nameIndex.index.u2Value» «field.descriptorIndex.index.u2Value» «field.attributesCount.value» «field.attributes.code»'''
	}

	def static String code(Methods methods) {
		'''
			Methods {
				«FOR method : methods.methodsInfo»
					«method.code»
				«ENDFOR»
			}
		'''
	}

	def static String code(MethodInfo method) {
		'''method «method.accessFlags.value» «method.nameIndex.index.u2Value» «method.descriptorIndex.index.u2Value» «method.attributesCount.value» «method.attributes.code»'''
	}

	def static String code(Attributes attributes) {
		'''
			Attributes {
				«FOR attribute : attributes.attributeInfo»
					«attribute.attributeCode»
				«ENDFOR»
			}
		'''
	}

	def dispatch static String attributeCode(Unknown attribute) {
		'''
			unknown «attribute.attributeNameIndex.index.u2Value» «attribute.attributeLength.value» Info { «attribute.info.code»}
		'''
	}

	def dispatch static String attributeCode(ConstantValue attribute) {
		'''constantValue «attribute.attributeNameIndex.index.u2Value» «attribute.attributeLength.value» «attribute.constantValueIndex.index.u2Value»'''
	}

	def dispatch static String attributeCode(Code attribute) {
		'''
			code «attribute.attributeNameIndex.index.u2Value» «attribute.attributeLength.value» «attribute.maxStack.value» «attribute.maxLocals.value» «attribute.codeLength.value» «attribute.codeTable.code» «attribute.exceptionTableLength.value» «attribute.exceptionTable.code» «attribute.attributesCount.value» «attribute.attributes.code»
		'''
	}

	def dispatch static String attributeCode(SourceFile attribute) {
		'''sourceFile «attribute.attributeNameIndex.index.u2Value» «attribute.attributeLength.value» «attribute.sourceFileIndex.index.u2Value»'''
	}

	def dispatch static String attributeCode(LineNumberTable attribute) {
		'''
		lineNumberTable «attribute.attributeNameIndex.index.u2Value» «attribute.attributeLength.value» «attribute.lineNumberTableLength.value» Table {
			«FOR line : attribute.lineNumbers»
				lineNumber «line.startPc.offset.u2Value» «line.lineNumber.value»
			«ENDFOR»
		}'''
	}

	def dispatch static String attributeCode(LocalVariableTable attribute) {
		'''
		localVariableTable «attribute.attributeNameIndex.index.u2Value» «attribute.attributeLength.value» «attribute.localVariableTableLength.value» Table {
			«FOR variable : attribute.localVariables»
				localVariable «variable.startPc.offset.u2Value» «variable.length.value» «variable.nameIndex.index.u2Value» «variable.descriptorIndex.index.u2Value» «variable.index.value»
			«ENDFOR»
		}'''
	}

	def dispatch static String attributeCode(Exceptions attribute) {
		'''
		exceptions «attribute.attributeNameIndex.index.u2Value» «attribute.attributeLength.value» «attribute.numberOfExceptions.value» Table {
			«FOR exception : attribute.exception»
				exception «exception.index.index.u2Value»
			«ENDFOR»
		}'''
	}

	def dispatch static String attributeCode(InnerClasses attribute) {
		'''
		innerClasses «attribute.attributeNameIndex.index.u2Value» «attribute.attributeLength.value» «attribute.numberOfClasses.value» Table {
			«FOR innerClass : attribute.innerClasses»
				innerClass «innerClass.innerClassInfoIndex.index.u2Value» «innerClass.outerClassInfoIndex.index.u2Value» «innerClass.innerNameIndex.index.u2Value» «innerClass.innerClassAccessFlags.value»
			«ENDFOR»
		}'''
	}

	private def static String code(CodeTable codeTable) {
		 '''Code {
	«FOR instruction : codeTable.instruction»
		«instruction.instructionCode»
	«ENDFOR»
}'''
	}

	private def dispatch static String instructionCode(AALOAD it) '''aaload «tag.value»'''
	private def dispatch static String instructionCode(AASTORE it) '''aastore «tag.value»'''
	private def dispatch static String instructionCode(ACONST_NULL it) '''aconst_null «tag.value»'''
	private def dispatch static String instructionCode(ALOAD it) '''aload «tag.value» «index.value»'''
	private def dispatch static String instructionCode(ALOAD_0 it) '''aload_0 «tag.value»'''
	private def dispatch static String instructionCode(ALOAD_1 it) '''aload_1 «tag.value»'''
	private def dispatch static String instructionCode(ALOAD_2 it) '''aload_2 «tag.value»'''
	private def dispatch static String instructionCode(ALOAD_3 it) '''aload_3 «tag.value»'''
	private def dispatch static String instructionCode(ANEWARRAY it) '''anewarray «tag.value» «index.index.u2Value»'''
	private def dispatch static String instructionCode(ARETURN it) '''areturn «tag.value»'''
	private def dispatch static String instructionCode(ARRAYLENGTH it) '''arraylength «tag.value»''' 
	private def dispatch static String instructionCode(ASTORE it) '''astore «tag.value» «index.value»'''
	private def dispatch static String instructionCode(ASTORE_0 it) '''astore_0 «tag.value»'''
	private def dispatch static String instructionCode(ASTORE_1 it) '''astore_1 «tag.value»'''
	private def dispatch static String instructionCode(ASTORE_2 it) '''astore_2 «tag.value»'''
	private def dispatch static String instructionCode(ASTORE_3 it) '''astore_3 «tag.value»'''
	private def dispatch static String instructionCode(ATHROW it) '''athrow «tag.value»'''
	private def dispatch static String instructionCode(BALOAD it) '''baload «tag.value»'''
	private def dispatch static String instructionCode(BASTORE it) '''bastore «tag.value»'''
	private def dispatch static String instructionCode(BIPUSH it) '''bipush «tag.value» «byte.value»'''
	private def dispatch static String instructionCode(CALOAD it) '''caload «tag.value»'''
	private def dispatch static String instructionCode(CASTORE it) '''castore «tag.value»''' 
	private def dispatch static String instructionCode(CHECKCAST it) '''checkcast «tag.value» «index.index.u2Value»'''
	private def dispatch static String instructionCode(D2F it) '''d2f «tag.value»'''
	private def dispatch static String instructionCode(D2I it) '''d2i «tag.value»'''
	private def dispatch static String instructionCode(D2L it) '''d2l «tag.value»'''
	private def dispatch static String instructionCode(DADD it) '''dadd «tag.value»'''
	private def dispatch static String instructionCode(DALOAD it) '''daload «tag.value»'''
	private def dispatch static String instructionCode(DASTORE it) '''dastore «tag.value»'''
	private def dispatch static String instructionCode(DCMPG it) '''dcmpg «tag.value»'''
	private def dispatch static String instructionCode(DCMPL it) '''dcmpl «tag.value»'''
	private def dispatch static String instructionCode(DCONST_0 it) '''dconst_0 «tag.value»'''
	private def dispatch static String instructionCode(DCONST_1 it) '''dconst_1 «tag.value»'''
	private def dispatch static String instructionCode(DDIV it) '''ddiv «tag.value»'''
	private def dispatch static String instructionCode(DLOAD it) '''dload «tag.value» «index.value»'''
	private def dispatch static String instructionCode(DLOAD_0 it) '''dload_0 «tag.value»'''
	private def dispatch static String instructionCode(DLOAD_1 it) '''dload_1 «tag.value»'''
	private def dispatch static String instructionCode(DLOAD_2 it) '''dload_2 «tag.value»'''
	private def dispatch static String instructionCode(DLOAD_3 it) '''dload_3 «tag.value»'''
	private def dispatch static String instructionCode(DMUL it) '''dmul «tag.value»'''
	private def dispatch static String instructionCode(DNEG it) '''dneg «tag.value»'''
	private def dispatch static String instructionCode(DREM it) '''drem «tag.value»'''
	private def dispatch static String instructionCode(DRETURN it) '''dreturn «tag.value»'''
	private def dispatch static String instructionCode(DSTORE it) '''dstore «tag.value» «index.value»'''
	private def dispatch static String instructionCode(DSTORE_0 it) '''dstore_0 «tag.value»'''
	private def dispatch static String instructionCode(DSTORE_1 it) '''dstore_1 «tag.value»'''
	private def dispatch static String instructionCode(DSTORE_2 it) '''dstore_2 «tag.value»'''
	private def dispatch static String instructionCode(DSTORE_3  it) '''dstore_3 «tag.value»'''
	private def dispatch static String instructionCode(DSUB it) '''dsub «tag.value»'''
	private def dispatch static String instructionCode(DUP it) '''dup «tag.value»'''
	private def dispatch static String instructionCode(DUP_X1 it) '''dup_x1 «tag.value»'''
	private def dispatch static String instructionCode(DUP_X2 it) '''dup_x2 «tag.value»'''
	private def dispatch static String instructionCode(DUP2 it) '''dup2 «tag.value»'''
	private def dispatch static String instructionCode(DUP2_X1 it) '''dup2_x1 «tag.value»'''
	private def dispatch static String instructionCode(DUP2_X2 it) '''dup2_x2 «tag.value»'''
	private def dispatch static String instructionCode(F2D it) '''f2d «tag.value»'''
	private def dispatch static String instructionCode(F2I it) '''f2i «tag.value»'''
	private def dispatch static String instructionCode(F2L it) '''f2l «tag.value»'''
	private def dispatch static String instructionCode(FADD it) '''fadd «tag.value»'''
	private def dispatch static String instructionCode(FALOAD it) '''faload «tag.value»'''
	private def dispatch static String instructionCode(FASTORE it) '''fastore «tag.value»'''
	private def dispatch static String instructionCode(FCMPG it) '''fcmpg «tag.value»'''
	private def dispatch static String instructionCode(FCMPL  it) '''fcmpl «tag.value»'''
	private def dispatch static String instructionCode(FCONST_0 it) '''fconst_0 «tag.value»'''
	private def dispatch static String instructionCode(FCONST_1 it) '''fconst_1 «tag.value»'''
	private def dispatch static String instructionCode(FCONST_2 it) '''fconst_2 «tag.value»'''
	private def dispatch static String instructionCode(FDIV it) '''fdiv «tag.value»'''
	private def dispatch static String instructionCode(FLOAD it) '''fload «tag.value» «index.value»'''
	private def dispatch static String instructionCode(FLOAD_0 it) '''fload_0 «tag.value»'''
	private def dispatch static String instructionCode(FLOAD_1 it) '''fload_1 «tag.value»'''
	private def dispatch static String instructionCode(FLOAD_2 it) '''fload_2 «tag.value»'''
	private def dispatch static String instructionCode(FLOAD_3 it) '''fload_3 «tag.value»'''
	private def dispatch static String instructionCode(FMUL it) '''fmul «tag.value»'''
	private def dispatch static String instructionCode(FNEG it) '''fneg «tag.value»'''
	private def dispatch static String instructionCode(FREM it) '''frem «tag.value»'''
	private def dispatch static String instructionCode(FRETURN it) '''freturn «tag.value»'''
	private def dispatch static String instructionCode(FSTORE it) '''fstore «tag.value» «index.value»'''
	private def dispatch static String instructionCode(FSTORE_0 it) '''fstore_0 «tag.value»'''
	private def dispatch static String instructionCode(FSTORE_1 it) '''fstore_1 «tag.value»'''
	private def dispatch static String instructionCode(FSTORE_2 it) '''fstore_2 «tag.value»'''
	private def dispatch static String instructionCode(FSTORE_3 it) '''fstore_3 «tag.value»'''
	private def dispatch static String instructionCode(FSUB it) '''fsub «tag.value»'''
	private def dispatch static String instructionCode(GETFIELD it) '''getfield «tag.value» «index.index.u2Value»'''
	private def dispatch static String instructionCode(GETSTATIC it) '''getstatic «tag.value» «index.index.u2Value»'''
	private def dispatch static String instructionCode(GOTO it) '''goto «tag.value» «(branch.offset - offset).u2SignedValue»'''
	private def dispatch static String instructionCode(GOTO_W it) '''goto_w «tag.value» «(branch.offset - offset).u4SignedValue»'''
	private def dispatch static String instructionCode(I2B it) '''i2b «tag.value»'''
	private def dispatch static String instructionCode(I2C it) '''i2c «tag.value»'''
	private def dispatch static String instructionCode(I2D it) '''i2d «tag.value»'''
	private def dispatch static String instructionCode(I2F it) '''i2f «tag.value»'''
	private def dispatch static String instructionCode(I2L it) '''i2l «tag.value»'''
	private def dispatch static String instructionCode(I2S it) '''i2s «tag.value»'''
	private def dispatch static String instructionCode(IADD it) '''iadd «tag.value»'''
	private def dispatch static String instructionCode(IALOAD it) '''iaload «tag.value»'''
	private def dispatch static String instructionCode(IAND it) '''iand «tag.value»'''
	private def dispatch static String instructionCode(IASTORE it) '''iastore «tag.value»'''
	private def dispatch static String instructionCode(ICONST_ML it) '''iconst_ml «tag.value»'''
	private def dispatch static String instructionCode(ICONST_0 it) '''iconst_0 «tag.value»'''
	private def dispatch static String instructionCode(ICONST_1 it) '''iconst_1 «tag.value»'''
	private def dispatch static String instructionCode(ICONST_2 it) '''iconst_2 «tag.value»'''
	private def dispatch static String instructionCode(ICONST_3 it) '''iconst_3 «tag.value»'''
	private def dispatch static String instructionCode(ICONST_4 it) '''iconst_4 «tag.value»'''
	private def dispatch static String instructionCode(ICONST_5 it) '''iconst_5 «tag.value»'''
	private def dispatch static String instructionCode(IDIV it) '''idiv «tag.value»'''
	private def dispatch static String instructionCode(IF_ACMPEQ it) '''if_acmpeq «tag.value» «(branch.offset - offset).u2SignedValue»'''
	private def dispatch static String instructionCode(IF_ACMPNE it) '''if_acmpne «tag.value» «(branch.offset - offset).u2SignedValue»'''
	private def dispatch static String instructionCode(IF_ICMPEQ it) '''if_icmpeq «tag.value» «(branch.offset - offset).u2SignedValue»'''
	private def dispatch static String instructionCode(IF_ICMPGE it) '''if_icmpge «tag.value» «(branch.offset - offset).u2SignedValue»'''
	private def dispatch static String instructionCode(IF_ICMPGT it) '''if_icmpgt «tag.value» «(branch.offset - offset).u2SignedValue»'''
	private def dispatch static String instructionCode(IF_ICMPLE it) '''if_icmple «tag.value» «(branch.offset - offset).u2SignedValue»'''
	private def dispatch static String instructionCode(IF_ICMPLT it) '''if_icmplt «tag.value» «(branch.offset - offset).u2SignedValue»'''
	private def dispatch static String instructionCode(IF_ICMPNE  it) '''if_icmpne «tag.value» «(branch.offset - offset).u2SignedValue»'''
	private def dispatch static String instructionCode(IFEQ it) '''ifeq «tag.value» «(branch.offset - offset).u2SignedValue»'''
	private def dispatch static String instructionCode(IFNE it) '''ifne «tag.value» «(branch.offset - offset).u2SignedValue»'''
	private def dispatch static String instructionCode(IFLT it) '''iflt «tag.value» «(branch.offset - offset).u2SignedValue»'''
	private def dispatch static String instructionCode(IFGE it) '''ifge «tag.value» «(branch.offset - offset).u2SignedValue»'''
	private def dispatch static String instructionCode(IFGT it) '''ifgt «tag.value» «(branch.offset - offset).u2SignedValue»'''
	private def dispatch static String instructionCode(IFLE it) '''ifle «tag.value» «(branch.offset - offset).u2SignedValue»'''
	private def dispatch static String instructionCode(IFNONNULL it) '''ifnonnull «tag.value» «(branch.offset - offset).u2SignedValue»'''
	private def dispatch static String instructionCode(IFNULL it) '''ifnull «tag.value» «(branch.offset - offset).u2SignedValue»'''
	private def dispatch static String instructionCode(IINC it) '''iinc «tag.value» «index.value» «const.value»'''
	private def dispatch static String instructionCode(ILOAD it) '''iload «tag.value» «index.value»'''
	private def dispatch static String instructionCode(ILOAD_0 it) '''iload_0 «tag.value»'''
	private def dispatch static String instructionCode(ILOAD_1 it) '''iload_1 «tag.value»'''
	private def dispatch static String instructionCode(ILOAD_2 it) '''iload_2 «tag.value»'''
	private def dispatch static String instructionCode(ILOAD_3  it) '''iload_3 «tag.value»'''
	private def dispatch static String instructionCode(IMUL it) '''imul «tag.value»'''
	private def dispatch static String instructionCode(INEG it) '''ineg «tag.value»'''
	private def dispatch static String instructionCode(INSTANCEOF it) '''instanceof «tag.value» «index.index.u2Value»'''
	private def dispatch static String instructionCode(INVOKEDYNAMIC it) '''invokedynamic «tag.value» «index.index.u2Value» «a0.value» «a1.value»'''
	private def dispatch static String instructionCode(INVOKEINTERFACE it) '''invokeinterface «tag.value» «index.index.u2Value» «count.value» «a0.value»'''
	private def dispatch static String instructionCode(INVOKESPECIAL it) '''invokespecial «tag.value» «index.index.u2Value»'''
	private def dispatch static String instructionCode(INVOKESTATIC it) '''invokestatic «tag.value» «index.index.u2Value»'''
	private def dispatch static String instructionCode(INVOKEVIRTUAL it) '''invokevirtual «tag.value» «index.index.u2Value»'''
	private def dispatch static String instructionCode(IOR  it) '''ior «tag.value»'''
	private def dispatch static String instructionCode(IREM it) '''irem «tag.value»'''
	private def dispatch static String instructionCode(IRETURN it) '''ireturn «tag.value»'''
	private def dispatch static String instructionCode(ISHL it) '''ishl «tag.value»'''
	private def dispatch static String instructionCode(ISHR it) '''ishr «tag.value»'''
	private def dispatch static String instructionCode(ISTORE it) '''istore «tag.value» «index.value»'''
	private def dispatch static String instructionCode(ISTORE_0 it) '''istore_0 «tag.value»'''
	private def dispatch static String instructionCode(ISTORE_1 it) '''istore_1 «tag.value»'''
	private def dispatch static String instructionCode(ISTORE_2 it) '''istore_2 «tag.value»'''
	private def dispatch static String instructionCode(ISTORE_3 it) '''istore_3 «tag.value»'''
	private def dispatch static String instructionCode(ISUB it) '''isub «tag.value»'''
	private def dispatch static String instructionCode(IUSHR it) '''iushr «tag.value»'''
	private def dispatch static String instructionCode(IXOR it) '''ixor «tag.value»'''
	private def dispatch static String instructionCode(JSR it) '''jsr «tag.value» «branch.offset.u2Value»'''
	private def dispatch static String instructionCode(JSR_W it) '''jsr_w «tag.value» «branch.offset.u4Value»'''
	private def dispatch static String instructionCode(L2D it) '''l2d «tag.value»'''
	private def dispatch static String instructionCode(L2F it) '''l2f «tag.value»'''
	private def dispatch static String instructionCode(L2I it) '''l2i «tag.value»'''
	private def dispatch static String instructionCode(LADD it) '''ladd «tag.value»'''
	private def dispatch static String instructionCode(LALOAD it) '''laload «tag.value»'''
	private def dispatch static String instructionCode(LAND it) '''land «tag.value»'''
	private def dispatch static String instructionCode(LASTORE it) '''lastore «tag.value»'''
	private def dispatch static String instructionCode(LCMP it) '''lcmp «tag.value»'''
	private def dispatch static String instructionCode(LCONST_0 it) '''lconst_0 «tag.value»'''
	private def dispatch static String instructionCode(LCONST_1 it) '''lconst_1 «tag.value»'''
	private def dispatch static String instructionCode(LDC it) '''ldc «tag.value» «index.index.u1Value»'''
	private def dispatch static String instructionCode(LDC_W it) '''ldc_w «tag.value» «index.index.u2Value»'''
	private def dispatch static String instructionCode(LDC2_W it) '''ldc2_w «tag.value» «index.index.u2Value»'''
	private def dispatch static String instructionCode(LDIV it) '''ldiv «tag.value»'''
	private def dispatch static String instructionCode(LLOAD it) '''lload «tag.value» «index.value»'''
	private def dispatch static String instructionCode(LLOAD_0 it) '''lload_0 «tag.value»'''
	private def dispatch static String instructionCode(LLOAD_1 it) '''lload_1 «tag.value»'''
	private def dispatch static String instructionCode(LLOAD_2 it) '''lload_2 «tag.value»'''
	private def dispatch static String instructionCode(LLOAD_3 it) '''lload_3 «tag.value»'''
	private def dispatch static String instructionCode(LMUL it) '''lmul «tag.value»'''
	private def dispatch static String instructionCode(LNEG it) '''lneg «tag.value»'''
	private def dispatch static String instructionCode(LOOKUPSWITCH it) {
		  '''lookupswitch «tag.value» «IF pad0!==null» «pad0.value»«ENDIF»«IF pad1!==null» «pad1.value»«ENDIF»«IF pad2!==null» «pad2.value»«ENDIF» «^default.value» «npairs.value»'''
		+ ''' matchOffsetPairs {«FOR p:matchOffsetPairs SEPARATOR " ,"»«p.match.value» «p.offset.value»«ENDFOR» }'''
	}
	private def dispatch static String instructionCode(LOR it) '''lor «tag.value»'''
	private def dispatch static String instructionCode(LREM it) '''lrem «tag.value»'''
	private def dispatch static String instructionCode(LRETURN it) '''lreturn «tag.value»'''
	private def dispatch static String instructionCode(LSHL it) '''lshl «tag.value»'''
	private def dispatch static String instructionCode(LSHR it) '''lshr «tag.value»'''
	private def dispatch static String instructionCode(LSTORE  it) '''lstore «tag.value» «index.value»'''
	private def dispatch static String instructionCode(LSTORE_0 it) '''lstore_0 «tag.value»'''
	private def dispatch static String instructionCode(LSTORE_1 it) '''lstore_1 «tag.value»'''
	private def dispatch static String instructionCode(LSTORE_2 it) '''lstore_2 «tag.value»'''
	private def dispatch static String instructionCode(LSTORE_3 it) '''lstore_3 «tag.value»'''
	private def dispatch static String instructionCode(LSUB it) '''lsub «tag.value»'''
	private def dispatch static String instructionCode(LUSHR it) '''lushr «tag.value»'''
	private def dispatch static String instructionCode(LXOR it) '''lxor «tag.value»'''
	private def dispatch static String instructionCode(MONITORENTER it) '''monitorenter «tag.value»'''
	private def dispatch static String instructionCode(MONITOREXIT it) '''monitorexit «tag.value»'''
	private def dispatch static String instructionCode(MULTIANEWARRAY it) '''multianewarray «tag.value» «index.index.u2Value» «dimensions.value»'''
	private def dispatch static String instructionCode(NEW  it) '''new «tag.value» «index.index.u2Value»'''
	private def dispatch static String instructionCode(NEWARRAY it) '''newarray «tag.value» «atype.value»'''
	private def dispatch static String instructionCode(NOP it) '''nop «tag.value»'''
	private def dispatch static String instructionCode(POP it) '''pop «tag.value»'''
	private def dispatch static String instructionCode(POP2 it) '''pop2 «tag.value»'''
	private def dispatch static String instructionCode(PUTFIELD it) '''putfield «tag.value» «index.index.u2Value»'''
	private def dispatch static String instructionCode(PUTSTATIC it) '''putstatic «tag.value» «index.index.u2Value»'''
	private def dispatch static String instructionCode(RET it) '''ret «tag.value» «index.value»'''
	private def dispatch static String instructionCode(RETURN it) '''return «tag.value»'''
	private def dispatch static String instructionCode(SALOAD it) '''saload «tag.value»'''
	private def dispatch static String instructionCode(SASTORE it) '''sastore «tag.value»'''
	private def dispatch static String instructionCode(SIPUSH it) '''sipush «tag.value» «value.value»'''
	private def dispatch static String instructionCode(SWAP it) '''swap «tag.value»'''
	private def dispatch static String instructionCode(TABLESWITCH it)  {
		  '''tableswitch «tag.value» «IF pad0!==null» «pad0.value»«ENDIF»«IF pad1!==null» «pad1.value»«ENDIF»«IF pad2!==null» «pad2.value»«ENDIF» «^default.value» «low.value» «high.value»'''
		+ ''' jumpOffsets {«FOR p:jumpOffsets SEPARATOR " "»«p.offset.value»«ENDFOR» '''
		+ '''}'''
	}
	private def dispatch static String instructionCode(WIDE it) '''wide «tag.value» «opcode.value» «index.value» «IF const !== null» «const.value»«ENDIF»'''

	private def static String code(ExceptionTable exceptionTable) '''ExceptionTable {
	«FOR entry : exceptionTable.exceptionTableEntry»
		entry «entry.startPc.offset.u2Value» «entry.endPc.offset.u2Value» «entry.handlerPc.offset.u2Value» «entry.catchType.index.u2Value»
	«ENDFOR»
}'''

	private def static String code(EList<U1> bytes) {
		'''«FOR b : bytes»«b.value» «ENDFOR»'''
	}

}
