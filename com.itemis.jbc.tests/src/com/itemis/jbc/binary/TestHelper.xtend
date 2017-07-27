package com.itemis.jbc.binary

import com.itemis.jbc.jbc.ClassFile
import com.itemis.jbc.jbc.CodeTableEntry
import com.itemis.jbc.jbc.ConstantUtf8
import java.io.ByteArrayInputStream
import java.io.DataInputStream
import org.eclipse.emf.common.util.EList
import org.eclipse.emf.ecore.EObject

import static com.itemis.jbc.binary.ClassFileFactoryAPI.*
import static org.junit.Assert.*

import static extension com.itemis.jbc.binary.ClassFileAccessAPI.*

class TestHelper {

	public static def void assertTreeMatches(EObject realTree, EObject expectedTree) {
		assertEquals(expectedTree.eClass, realTree.eClass)
		for (attribute : expectedTree.eClass.EAttributes)
			assertEquals("'" + expectedTree.eContainingFeature.name + "." + attribute.name + "'",
				expectedTree.eGet(attribute), realTree.eGet(attribute))
		for (reference : expectedTree.eClass.EReferences)
			assertTreeMatches(realTree.eGet(reference), expectedTree.eGet(reference))
		assertEquals("Children of " + realTree.eClass.name, expectedTree.eContents.size, realTree.eContents.size)
		for (var n = 0; n < expectedTree.eContents.size; n++)
			assertTreeMatches(realTree.eContents.get(n), expectedTree.eContents.get(n))
	}

	private static def void assertTreeMatches(Object realTree, Object expectedTree) {
		if (realTree === null && expectedTree === null)
			return;
		if (realTree === null && (expectedTree as EObject).eContainer === null)
			return;
		if (expectedTree === null && (realTree as EObject).eContainer === null)
			return;
		assertNotNull("Real is 'null' but expected is '" + expectedTree + "'", realTree)
		assertNotNull("Expected is 'null' but real is '" + realTree + "'", expectedTree)
		assertSame(expectedTree.class, realTree.class)
		if (expectedTree instanceof EList<?>) {
			assertEquals(expectedTree.size, (realTree as EList<?>).size)
			for (var n = 0; n < expectedTree.size; n++)
				assertTreeMatches((realTree as EList<?>).get(n), expectedTree.get(n))
		}
	}

	public static def readClassFile(byte[] input) {
		reader(input).readClassFile
	}

	public static def readClassFile(String input) {
		reader(input).readClassFile
	}

	public static def writeClassFile(ClassFile classFile) {
		ByteCodeWriter.writeClassFile(classFile)
	}

	public static def readStandartClassFileWithCode(String code) {
		val cleanCode = code.replaceAll(' ', '')
		val byteCount = cleanCode.length / 2
		reader('''
			cafebabe 0000 0034
			0002
				01 0004 43 6F 64 65
			0002 0001 0003
			0000
			0000
			0001
				0001 0001 0001 0001
					0001 «(byteCount + 18).u4Value» 0001 0003 «byteCount.u4Value» «code» 0000 0000
			0000
		''').readClassFile
	}

	public static def readConstantPool(int constantPoolCount, String input) {
		reader(input).readConstantPool(u2(constantPoolCount))
	}

	private static def reader(String input) {
		reader(toByteArray(input.replaceAll("\\s", "")))
	}

	private static def reader(byte[] input) {
		new ByteCodeReader(new DataInputStream(new ByteArrayInputStream(input)))
	}

	private static def byte[] toByteArray(String input) {
		val result = newByteArrayOfSize(input.length / 2)
		for (var n = 0; n < result.length; n++) {
			result.set(n, toByte(input.substring(n * 2, n * 2 + 2)))
		}
		return result
	}

	private static def byte toByte(String input) {
		Integer.parseUnsignedInt(input.toLowerCase, 16) as byte;
	}

	public static def ClassFile standartClassFileWithCode(int codeSize, CodeTableEntry... code) {
		var ConstantUtf8 utf8
		return classFile(u4(-889275714), u2(0), u2(52), u2(2),
			constantPool(utf8 = constantUtf8(u1(1), uString("Code"))), u2(2), null, null, u2(0), interfaces(), u2(0),
			fields(), u2(1),
			methods(
				methodInfo(u2(1), utf8, utf8, u2(1),
					attributes(
						attributeCode(utf8, u4(codeSize + 18), u2(1), u2(3), u4(codeSize), codeTable(code), u2(0),
							exceptionTable(), u2(0), attributes())))), u2(0), attributes())
	}
}
