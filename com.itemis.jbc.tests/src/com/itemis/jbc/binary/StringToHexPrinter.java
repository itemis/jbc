package com.itemis.jbc.binary;

public class StringToHexPrinter {

	public static void main(String[] args) {
		printHex("LineNumberTable");
	}

	private static void printHex(String input) {
		for (int n = 0; n < input.length(); n++) {
			System.out.print(Integer.toHexString(input.charAt(n)).toUpperCase() + " ");
		}
	}

}
