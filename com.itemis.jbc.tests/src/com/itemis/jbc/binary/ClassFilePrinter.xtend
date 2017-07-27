package com.itemis.jbc.binary

class ClassFilePrinter {
	
	def static void main(String[] args) {
		val stream = Object.getResourceAsStream("Object.class")
		var count = 1;
		var i = stream.read
		while (i != -1) {
			print(Integer.toHexString(i) + " ")
			if (count % 16 == 0)
				println
			i = stream.read
			count++
		}
	}
	
}