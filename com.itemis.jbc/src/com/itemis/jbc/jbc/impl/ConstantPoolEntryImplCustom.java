/*******************************************************************************
* Copyright (c) 2008 - 2010 itemis AG (http://www.itemis.eu) and others.
* All rights reserved. This program and the accompanying materials
* are made available under the terms of the Eclipse Public License v1.0
* which accompanies this distribution, and is available at
* http://www.eclipse.org/legal/epl-v10.html
*******************************************************************************/
package com.itemis.jbc.jbc.impl;

import org.eclipse.emf.common.util.EList;

import com.itemis.jbc.jbc.ConstantPool;
import com.itemis.jbc.jbc.ConstantPoolEntry;

public class ConstantPoolEntryImplCustom extends com.itemis.jbc.jbc.impl.ConstantPoolEntryImpl {

	private int index = -1;

	/**
	 * Get the index inside the custom pool. This method takes into consideration
	 * that the pool starts at 1 and Long and Double entries consume two slots. The
	 * result is cached to ensure massive access to this value does not lead to
	 * performance issues.
	 * 
	 * @return The index inside the constant pool as needed by references inside the
	 *         byte code (start at 1, increment by one for each entry, by two for
	 *         each Long and Double).
	 */
	public int getConstantPoolReferenceIndex() {
		if (index == -1) {
			EList<ConstantPoolEntry> pool = ((ConstantPool) eContainer()).getCpInfo();
			int listIndex = pool.indexOf(this);
			if (listIndex == 0) {
				index = 1;
			} else {
				ConstantPoolEntryImplCustom previous = (ConstantPoolEntryImplCustom) pool.get(listIndex - 1);
				index = previous.getConstantPoolReferenceIndex() + previous.getIndexIncrement();
			}
		}
		return index;
	}

	protected int getIndexIncrement() {
		return 1;
	}

}
