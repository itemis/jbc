package com.itemis.jbc.roundtrip;

import java.util.function.Function;

public class SimpleClosure {

	void addFromMap() {
		Function<Boolean, Boolean> function = (Boolean builder) -> {
			return true;
		};
		function.apply(true);
	}

}
