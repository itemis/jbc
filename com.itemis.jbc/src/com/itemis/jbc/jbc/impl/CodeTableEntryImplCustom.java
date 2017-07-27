/*******************************************************************************
* Copyright (c) 2008 - 2010 itemis AG (http://www.itemis.eu) and others.
* All rights reserved. This program and the accompanying materials
* are made available under the terms of the Eclipse Public License v1.0
* which accompanies this distribution, and is available at
* http://www.eclipse.org/legal/epl-v10.html
*******************************************************************************/
package com.itemis.jbc.jbc.impl;

import org.eclipse.emf.common.util.EList;

import com.itemis.jbc.binary.Opcode;
import com.itemis.jbc.jbc.CodeTable;
import com.itemis.jbc.jbc.CodeTableEntry;

public class CodeTableEntryImplCustom extends com.itemis.jbc.jbc.impl.CodeTableEntryImpl {

	private int offset = -1;

	/**
	 * Get the byte offset inside the method of this entry. Needed when referencing
	 * the element.Result is cached for efficiency.
	 * 
	 * @return The byte offset this element is located inside its method.
	 */
	public int getCodeOffset() {
		if (offset == -1) {
			EList<CodeTableEntry> instructions = ((CodeTable) eContainer()).getInstruction();
			int listIndex = instructions.indexOf(this);
			if (listIndex == 0) {
				offset = 0;
			} else {
				CodeTableEntryImplCustom previous = (CodeTableEntryImplCustom) instructions.get(listIndex - 1);
				offset = previous.getCodeOffset() + Opcode.byteCount(previous);
			}
		}
		return offset;
	}

	protected int getOffsetIncrement() {
		return 1;
	}

}
