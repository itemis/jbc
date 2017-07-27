package com.itemis.jbc.roundtrip

import com.google.inject.Inject
import com.itemis.jbc.binary.ByteCodeReader
import com.itemis.jbc.binary.ByteCodeWriter
import com.itemis.jbc.generator.JBCCodeTemplates
import com.itemis.jbc.jbc.ClassFile
import com.itemis.jbc.parser.antlr.internal.InternalJBCParser
import com.itemis.jbc.tests.JBCInjectorProvider
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.Ignore
import org.junit.Test
import org.junit.runner.RunWith

import static com.itemis.jbc.binary.TestHelper.*
import static org.junit.Assert.*

@RunWith(XtextRunner)
@InjectWith(JBCInjectorProvider)
class RoundtripTest {

	@Inject	ParseHelper<ClassFile> parseClass
	@Inject ValidationTestHelper validation

	@Test def mostSimpleClass() { MostSimpleClass.assertRoundTrip }

	@Test def helloWorldClass() { HelloWorld.assertRoundTrip }

	@Test def helloWithExceptionHandlerClass() { HelloWithExceptionHandler.assertRoundTrip }

	@Test def interfaceImplementingClass() { InterfaceImplementingClass.assertRoundTrip }

	@Test def simpleClosureClass() { SimpleClosure.assertRoundTrip }

	@Test def objectClass() { Object.assertRoundTrip }

	@Test def numberClass() { Number.assertRoundTrip }

	@Test def longClass() { Long.assertRoundTrip }

	@Test def doubleClass() { Double.assertRoundTrip }

	/*@Ignore*/ @Test def classClass() { Class.assertRoundTrip }

	@Test def byteCodeReaderClass() { ByteCodeReader.assertRoundTrip }

	@Test def scalaClass0() { assertRoundTrip("ConsoleLogger.class", loadByteCode("ConsoleLogger.cls", RoundtripTest)) }

	@Test def scalaClass1() { assertRoundTrip("ConsoleLogger$class.class", loadByteCode("ConsoleLogger$class.cls", RoundtripTest)) }

	@Ignore @Test def internalJBCParserClass() { InternalJBCParser.assertRoundTrip }

	private def void assertRoundTrip(Class<?> c) {
		assertRoundTrip(c.name, loadByteCode(c))
	}
	
	private def void assertRoundTrip(String name, byte[] loadedByteCode) {
//		println(Arrays.toString(loadedByteCode))
		val loadedClassFile = loadClassFile(loadedByteCode)
		assertEquals(name + " is not loaded at all", "CAFEBABE", loadedClassFile.magic.value)
		val printedClassFile = JBCCodeTemplates.code(loadedClassFile)
		assertTrue(name + " can not be printed at all", printedClassFile.startsWith("ClassFile"))
//		println(printedClassFile)
		val backreadClassFile = parseClass.parse(printedClassFile)
		validation.assertNoErrors(backreadClassFile)
		assertTreeMatches(loadedClassFile, backreadClassFile)
		assertEquals(name + " is not correctly readed back", "CAFEBABE", backreadClassFile.magic.value)
		val backreadByteCode = ByteCodeWriter.writeClassFile(loadedClassFile)
//		println(Arrays.toString(backreadByteCode))
//		assertEquals(Arrays.toString(loadedByteCode), Arrays.toString(backreadByteCode))
		assertArrayEquals(backreadByteCode, loadedByteCode)
//		val roundtripClassFile = loadClassFile(backreadByteCode)
//		assertTreeMatches(loadedClassFile, roundtripClassFile)
	}

	private def byte[] loadByteCode(Class<?> c) {
		val simpleName = c.simpleName + ".class"
		return loadByteCode(simpleName, c)
	}
	
	private def byte[] loadByteCode(String simpleName, Class<?> c) {
		val result = newArrayList
		val stream = c.getResourceAsStream(simpleName)
		try {
			var int b;
			while ((b = stream.read) != -1)
				result.add(b as byte)
			return result
		} finally {
			stream.close
		}
	}

	private def loadClassFile(byte[] byteCode) {
		ByteCodeReader.fromByteArray(byteCode)
	}

}
