package com.itemis.jbc.ui.custom

import com.itemis.jbc.binary.ByteCodeReader
import com.itemis.jbc.generator.JBCCodeTemplates
import java.io.BufferedReader
import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream
import java.io.DataOutputStream
import java.io.IOException
import java.io.InputStream
import java.io.InputStreamReader
import org.eclipse.core.runtime.CoreException
import org.eclipse.core.runtime.IStatus
import org.eclipse.core.runtime.Status
import org.eclipse.ui.PlatformUI

class JBCInputStreamContentReader {

	private static final int DEFAULT_FILE_SIZE = 15 * 1024;

	def readContent(InputStream contentStream, String encoding) throws CoreException {
		val content = readContent(contentStream)
		if (content.size > 4 && content.get(0) == -54 && content.get(1) == -2 && content.get(2) == -70 &&
			content.get(3) == -66) { // CAFEBABE
			return readContentFromClassFile(content)
		} else {
			return readContentFromTextFile(content, encoding)
		}
	}

	def private byte[] readContent(InputStream inputStream) {
		try {
			val baos = new ByteArrayOutputStream()
			val dos = new DataOutputStream(baos)
			val data = newByteArrayOfSize(4096)
			var count = inputStream.read(data)
			while (count != -1) {
				dos.write(data, 0, count)
				count = inputStream.read(data)
			}
			return baos.toByteArray();
		} catch (IOException x) {
			var String message;
			if (x.getMessage() !== null)
				message = x.getMessage()
			else
				message = ""
			val IStatus s = new Status(IStatus.ERROR, PlatformUI.PLUGIN_ID, IStatus.OK, message, x)
			throw new CoreException(s)
		} finally {
			inputStream.close()
		}
	}

	def private String readContentFromTextFile(byte[] content, String enc) {
		val in = new BufferedReader(new InputStreamReader(new ByteArrayInputStream(content), enc), DEFAULT_FILE_SIZE)
		try {
			val buffer = new StringBuffer(DEFAULT_FILE_SIZE)
			val readBuffer = newCharArrayOfSize(2048)
			var n = in.read(readBuffer)
			while (n > 0) {
				buffer.append(readBuffer, 0, n)
				n = in.read(readBuffer)
			}
			return buffer.toString()
		} catch (IOException x) {
			var String message
			if (x.getMessage() !== null)
				message = x.getMessage()
			else
				message = ""
			val IStatus s = new Status(IStatus.ERROR, PlatformUI.PLUGIN_ID, IStatus.OK, message, x)
			throw new CoreException(s)
		}
	}

	def private String readContentFromClassFile(byte[] content) {
		val classFile = ByteCodeReader.fromByteArray(content)
		return JBCCodeTemplates.code(classFile)
	}

}
