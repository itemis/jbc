package com.itemis.jbc.binary;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.eclipse.xtext.xbase.lib.Pair;

import com.itemis.jbc.jbc.ALOAD;
import com.itemis.jbc.jbc.ANEWARRAY;
import com.itemis.jbc.jbc.ASTORE;
import com.itemis.jbc.jbc.BIPUSH;
import com.itemis.jbc.jbc.CHECKCAST;
import com.itemis.jbc.jbc.CodeTableEntry;
import com.itemis.jbc.jbc.DLOAD;
import com.itemis.jbc.jbc.DSTORE;
import com.itemis.jbc.jbc.FLOAD;
import com.itemis.jbc.jbc.FSTORE;
import com.itemis.jbc.jbc.GETFIELD;
import com.itemis.jbc.jbc.GETSTATIC;
import com.itemis.jbc.jbc.GOTO;
import com.itemis.jbc.jbc.GOTO_W;
import com.itemis.jbc.jbc.IFEQ;
import com.itemis.jbc.jbc.IFGE;
import com.itemis.jbc.jbc.IFGT;
import com.itemis.jbc.jbc.IFLE;
import com.itemis.jbc.jbc.IFLT;
import com.itemis.jbc.jbc.IFNE;
import com.itemis.jbc.jbc.IFNONNULL;
import com.itemis.jbc.jbc.IFNULL;
import com.itemis.jbc.jbc.IF_ACMPEQ;
import com.itemis.jbc.jbc.IF_ACMPNE;
import com.itemis.jbc.jbc.IF_ICMPEQ;
import com.itemis.jbc.jbc.IF_ICMPGE;
import com.itemis.jbc.jbc.IF_ICMPGT;
import com.itemis.jbc.jbc.IF_ICMPLE;
import com.itemis.jbc.jbc.IF_ICMPLT;
import com.itemis.jbc.jbc.IF_ICMPNE;
import com.itemis.jbc.jbc.IINC;
import com.itemis.jbc.jbc.ILOAD;
import com.itemis.jbc.jbc.INSTANCEOF;
import com.itemis.jbc.jbc.INVOKEDYNAMIC;
import com.itemis.jbc.jbc.INVOKEINTERFACE;
import com.itemis.jbc.jbc.INVOKESPECIAL;
import com.itemis.jbc.jbc.INVOKESTATIC;
import com.itemis.jbc.jbc.INVOKEVIRTUAL;
import com.itemis.jbc.jbc.ISTORE;
import com.itemis.jbc.jbc.JSR;
import com.itemis.jbc.jbc.JSR_W;
import com.itemis.jbc.jbc.JbcFactory;
import com.itemis.jbc.jbc.JumpOffset;
import com.itemis.jbc.jbc.LDC;
import com.itemis.jbc.jbc.LDC2_W;
import com.itemis.jbc.jbc.LDC_W;
import com.itemis.jbc.jbc.LLOAD;
import com.itemis.jbc.jbc.LOOKUPSWITCH;
import com.itemis.jbc.jbc.LSTORE;
import com.itemis.jbc.jbc.MULTIANEWARRAY;
import com.itemis.jbc.jbc.MatchOffsetPair;
import com.itemis.jbc.jbc.NEW;
import com.itemis.jbc.jbc.NEWARRAY;
import com.itemis.jbc.jbc.PUTFIELD;
import com.itemis.jbc.jbc.PUTSTATIC;
import com.itemis.jbc.jbc.RET;
import com.itemis.jbc.jbc.SIPUSH;
import com.itemis.jbc.jbc.TABLESWITCH;
import com.itemis.jbc.jbc.WIDE;

public enum Opcode {

	AALOAD(50),

	AASTORE(83),

	ACONST_NULL(1),

	ALOAD(25) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 2;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			ALOAD result = JbcFactory.eINSTANCE.createALOAD();
			result.setIndex(reader.readU1());
			return result;
		}
	},

	ALOAD_0(42),

	ALOAD_1(43),

	ALOAD_2(44),

	ALOAD_3(45),

	ANEWARRAY(189) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			ANEWARRAY result = JbcFactory.eINSTANCE.createANEWARRAY();
			result.setIndex(reader.readConstantClassRef());
			return result;
		}
	},

	ARETURN(176),

	ARRAYLENGTH(190),

	ASTORE(58) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 2;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			ASTORE result = JbcFactory.eINSTANCE.createASTORE();
			result.setIndex(reader.readU1());
			return result;
		}
	},

	ASTORE_0(75),

	ASTORE_1(76),

	ASTORE_2(77),

	ASTORE_3(78),

	ATHROW(191),

	BALOAD(51),

	BASTORE(84),

	BIPUSH(16) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 2;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			BIPUSH result = JbcFactory.eINSTANCE.createBIPUSH();
			result.setByte(reader.readU1());
			return result;
		}
	},

	CALOAD(52),

	CASTORE(85),

	CHECKCAST(192) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			CHECKCAST result = JbcFactory.eINSTANCE.createCHECKCAST();
			result.setIndex(reader.readConstantClassRef());
			return result;
		}
	},

	D2F(144),

	D2I(142),

	D2L(143),

	DADD(99),

	DALOAD(49),

	DASTORE(82),

	DCMPG(152),

	DCMPL(151),

	DCONST_0(14),

	DCONST_1(15),

	DDIV(111),

	DLOAD(24) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 2;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			DLOAD result = JbcFactory.eINSTANCE.createDLOAD();
			result.setIndex(reader.readU1());
			return result;
		}
	},

	DLOAD_0(38),

	DLOAD_1(39),

	DLOAD_2(40),

	DLOAD_3(41),

	DMUL(107),

	DNEG(119),

	DREM(115),

	DRETURN(175),

	DSTORE(57) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 2;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			DSTORE result = JbcFactory.eINSTANCE.createDSTORE();
			result.setIndex(reader.readU1());
			return result;
		}
	},

	DSTORE_0(71),

	DSTORE_1(72),

	DSTORE_2(73),

	DSTORE_3(74),

	DSUB(103),

	DUP(89),

	DUP_X1(90),

	DUP_X2(91),

	DUP2(92),

	DUP2_X1(93),

	DUP2_X2(94),

	F2D(141),

	F2I(139),

	F2L(140),

	FADD(98),

	FALOAD(48),

	FASTORE(81),

	FCMPG(150),

	FCMPL(149),

	FCONST_0(11),

	FCONST_1(12),

	FCONST_2(13),

	FDIV(110),

	FLOAD(23) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 2;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			FLOAD result = JbcFactory.eINSTANCE.createFLOAD();
			result.setIndex(reader.readU1());
			return result;
		}
	},

	FLOAD_0(34),

	FLOAD_1(35),

	FLOAD_2(36),

	FLOAD_3(37),

	FMUL(106),

	FNEG(118),

	FREM(114),

	FRETURN(174),

	FSTORE(56) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 2;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			FSTORE result = JbcFactory.eINSTANCE.createFSTORE();
			result.setIndex(reader.readU1());
			return result;
		}
	},

	FSTORE_0(67),

	FSTORE_1(68),

	FSTORE_2(69),

	FSTORE_3(70),

	FSUB(102),

	GETFIELD(180) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			GETFIELD result = JbcFactory.eINSTANCE.createGETFIELD();
			result.setIndex(reader.readConstantFieldRef());
			return result;
		}
	},

	GETSTATIC(178) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			GETSTATIC result = JbcFactory.eINSTANCE.createGETSTATIC();
			result.setIndex(reader.readConstantFieldRef());
			return result;
		}
	},

	GOTO(167) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			GOTO result = JbcFactory.eINSTANCE.createGOTO();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	GOTO_W(200) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 5;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			GOTO_W result = JbcFactory.eINSTANCE.createGOTO_W();
			map.put(result, Pair.of(reader.readInt(), null));
			return result;
		}
	},

	I2B(145),

	I2C(146),

	I2D(135),

	I2F(134),

	I2L(133),

	I2S(147),

	IADD(96),

	IALOAD(46),

	IAND(126),

	IASTORE(79),

	ICONST_ML(2),

	ICONST_0(3),

	ICONST_1(4),

	ICONST_2(5),

	ICONST_3(6),

	ICONST_4(7),

	ICONST_5(8),

	IDIV(108),

	IF_ACMPEQ(165) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			IF_ACMPEQ result = JbcFactory.eINSTANCE.createIF_ACMPEQ();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	IF_ACMPNE(166) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			IF_ACMPNE result = JbcFactory.eINSTANCE.createIF_ACMPNE();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	IF_ICMPEQ(159) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			IF_ICMPEQ result = JbcFactory.eINSTANCE.createIF_ICMPEQ();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	IF_ICMPNE(160) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			IF_ICMPNE result = JbcFactory.eINSTANCE.createIF_ICMPNE();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	IF_ICMPLT(161) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			IF_ICMPLT result = JbcFactory.eINSTANCE.createIF_ICMPLT();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	IF_ICMPGE(162) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			IF_ICMPGE result = JbcFactory.eINSTANCE.createIF_ICMPGE();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	IF_ICMPGT(163) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			IF_ICMPGT result = JbcFactory.eINSTANCE.createIF_ICMPGT();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	IF_ICMPLE(164) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			IF_ICMPLE result = JbcFactory.eINSTANCE.createIF_ICMPLE();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	IFEQ(153) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			IFEQ result = JbcFactory.eINSTANCE.createIFEQ();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	IFNE(154) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			IFNE result = JbcFactory.eINSTANCE.createIFNE();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	IFLT(155) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			IFLT result = JbcFactory.eINSTANCE.createIFLT();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	IFGE(156) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			IFGE result = JbcFactory.eINSTANCE.createIFGE();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	IFGT(157) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			IFGT result = JbcFactory.eINSTANCE.createIFGT();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	IFLE(158) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			IFLE result = JbcFactory.eINSTANCE.createIFLE();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	IFNONNULL(199) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			IFNONNULL result = JbcFactory.eINSTANCE.createIFNONNULL();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	IFNULL(198) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			IFNULL result = JbcFactory.eINSTANCE.createIFNULL();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	IINC(132) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			IINC result = JbcFactory.eINSTANCE.createIINC();
			result.setIndex(reader.readU1());
			result.setConst(reader.readU1());
			return result;
		}
	},

	ILOAD(21) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 2;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			ILOAD result = JbcFactory.eINSTANCE.createILOAD();
			result.setIndex(reader.readU1());
			return result;
		}
	},

	ILOAD_0(26),

	ILOAD_1(27),

	ILOAD_2(28),

	ILOAD_3(29),

	IMUL(104),

	INEG(116),

	INSTANCEOF(193) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			INSTANCEOF result = JbcFactory.eINSTANCE.createINSTANCEOF();
			result.setIndex(reader.readConstantClassRef());
			return result;
		}
	},

	INVOKEDYNAMIC(186) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 5;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			INVOKEDYNAMIC result = JbcFactory.eINSTANCE.createINVOKEDYNAMIC();
			result.setIndex(reader.readConstantPoolEntryRef());
			result.setA0(reader.readU1());
			result.setA1(reader.readU1());
			return result;
		}
	},

	INVOKEINTERFACE(185) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 5;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			INVOKEINTERFACE result = JbcFactory.eINSTANCE.createINVOKEINTERFACE();
			result.setIndex(reader.readConstantPoolEntryRef());
			result.setCount(reader.readU1());
			result.setA0(reader.readU1());
			return result;
		}
	},

	INVOKESPECIAL(183) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			INVOKESPECIAL result = JbcFactory.eINSTANCE.createINVOKESPECIAL();
			result.setIndex(reader.readConstantPoolEntryRef());
			return result;
		}
	},

	INVOKESTATIC(184) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			INVOKESTATIC result = JbcFactory.eINSTANCE.createINVOKESTATIC();
			result.setIndex(reader.readConstantPoolEntryRef());
			return result;
		}
	},

	INVOKEVIRTUAL(182) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			INVOKEVIRTUAL result = JbcFactory.eINSTANCE.createINVOKEVIRTUAL();
			result.setIndex(reader.readConstantMethodRef());
			return result;
		}
	},

	IOR(128),

	IREM(112),

	IRETURN(172),

	ISHL(120),

	ISHR(122),

	ISTORE(54) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 2;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			ISTORE result = JbcFactory.eINSTANCE.createISTORE();
			result.setIndex(reader.readU1());
			return result;
		}
	},

	ISTORE_0(59),

	ISTORE_1(60),

	ISTORE_2(61),

	ISTORE_3(62),

	ISUB(100),

	IUSHR(124),

	IXOR(130),

	JSR(168) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			JSR result = JbcFactory.eINSTANCE.createJSR();
			map.put(result, Pair.of(reader.readShort(), null));
			return result;
		}
	},

	JSR_W(201) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 5;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			JSR_W result = JbcFactory.eINSTANCE.createJSR_W();
			map.put(result, Pair.of(reader.readInt(), null));
			return result;
		}
	},

	L2D(138),

	L2F(137),

	L2I(136),

	LADD(97),

	LALOAD(47),

	LAND(127),

	LASTORE(80),

	LCMP(148),

	LCONST_0(9),

	LCONST_1(10),

	LDC(18) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 2;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			LDC result = JbcFactory.eINSTANCE.createLDC();
			result.setIndex(reader.readConstantPoolEntryRefFromByte());
			return result;
		}
	},

	LDC_W(19) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			LDC_W result = JbcFactory.eINSTANCE.createLDC_W();
			result.setIndex(reader.readConstantPoolEntryRef());
			return result;
		}
	},

	LDC2_W(20) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			LDC2_W result = JbcFactory.eINSTANCE.createLDC2_W();
			result.setIndex(reader.readConstantPoolEntryRef());
			return result;
		}
	},

	LDIV(109),

	LLOAD(22) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 2;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			LLOAD result = JbcFactory.eINSTANCE.createLLOAD();
			result.setIndex(reader.readU1());
			return result;
		}
	},

	LLOAD_0(30),

	LLOAD_1(31),

	LLOAD_2(32),

	LLOAD_3(33),

	LMUL(105),

	LNEG(117),

	LOOKUPSWITCH(171) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			LOOKUPSWITCH e = (LOOKUPSWITCH) entry;
			return 1 + (e.getPad0() == null ? 0 : 1) + (e.getPad1() == null ? 0 : 1) + (e.getPad2() == null ? 0 : 1) + 4
					+ 4 + e.getMatchOffsetPairs().size() * 8;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			LOOKUPSWITCH result = JbcFactory.eINSTANCE.createLOOKUPSWITCH();
			final int mod = (offset + 1) % 4;
			if (mod > 0) {
				result.setPad0(reader.readU1());
				if (mod < 3) {
					result.setPad1(reader.readU1());
					if (mod < 2) {
						result.setPad2(reader.readU1());
					}
				}
			}
			result.setDefault(reader.readU4());
			result.setNpairs(reader.readU4());
			final int npairCount = ClassFileAccessAPI.intValue(result.getNpairs());
			for (int n = 0; n < npairCount; n++) {
				MatchOffsetPair pair = JbcFactory.eINSTANCE.createMatchOffsetPair();
				pair.setMatch(reader.readU4());
				pair.setOffset(reader.readU4());
				result.getMatchOffsetPairs().add(pair);
			}
			return result;
		}
	},

	LOR(129),

	LREM(113),

	LRETURN(173),

	LSHL(121),

	LSHR(123),

	LSTORE(55) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 2;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			LSTORE result = JbcFactory.eINSTANCE.createLSTORE();
			result.setIndex(reader.readU1());
			return result;
		}
	},

	LSTORE_0(63),

	LSTORE_1(64),

	LSTORE_2(65),

	LSTORE_3(66),

	LSUB(101),

	LUSHR(125),

	LXOR(131),

	MONITORENTER(194),

	MONITOREXIT(195),

	MULTIANEWARRAY(197) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 4;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			MULTIANEWARRAY result = JbcFactory.eINSTANCE.createMULTIANEWARRAY();
			result.setIndex(reader.readConstantClassRef());
			result.setDimensions(reader.readU1());
			return result;
		}
	},

	NEW(187) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			NEW result = JbcFactory.eINSTANCE.createNEW();
			result.setIndex(reader.readConstantClassRef());
			return result;
		}
	},

	NEWARRAY(188) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 2;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			NEWARRAY result = JbcFactory.eINSTANCE.createNEWARRAY();
			result.setAtype(reader.readU1());
			return result;
		}
	},

	NOP(0),

	POP(87),

	POP2(88),

	PUTFIELD(181) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			PUTFIELD result = JbcFactory.eINSTANCE.createPUTFIELD();
			result.setIndex(reader.readConstantFieldRef());
			return result;
		}
	},

	PUTSTATIC(179) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			PUTSTATIC result = JbcFactory.eINSTANCE.createPUTSTATIC();
			result.setIndex(reader.readConstantFieldRef());
			return result;
		}
	},

	RET(169) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 2;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			RET result = JbcFactory.eINSTANCE.createRET();
			result.setIndex(reader.readU1());
			return result;
		}
	},

	RETURN(177),

	SALOAD(53),

	SASTORE(86),

	SIPUSH(17) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return 3;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			SIPUSH result = JbcFactory.eINSTANCE.createSIPUSH();
			result.setValue(reader.readU2());
			return result;
		}
	},

	SWAP(95),

	TABLESWITCH(170) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			TABLESWITCH e = (TABLESWITCH) entry;
			return 1 + (e.getPad0() == null ? 0 : 1) + (e.getPad1() == null ? 0 : 1) + (e.getPad2() == null ? 0 : 1) + 4
					+ 4 + 4 + e.getJumpOffsets().size() * 4;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			TABLESWITCH result = JbcFactory.eINSTANCE.createTABLESWITCH();
			final int mod = (offset + 1) % 4;
			if (mod > 0) {
				result.setPad0(reader.readU1());
				if (mod < 3) {
					result.setPad1(reader.readU1());
					if (mod < 2) {
						result.setPad2(reader.readU1());
					}
				}
			}
			result.setDefault(reader.readU4());
			result.setLow(reader.readU4());
			result.setHigh(reader.readU4());
			final int count = ClassFileAccessAPI.intValue(result.getHigh())
					- ClassFileAccessAPI.intValue(result.getLow()) + 1;
			for (int n = 0; n < count; n++) {
				JumpOffset jumpOffset = JbcFactory.eINSTANCE.createJumpOffset();
				jumpOffset.setOffset(reader.readU4());
				result.getJumpOffsets().add(jumpOffset);
			}
			return result;
		}
	},

	WIDE(196) {
		@Override
		protected int bytes(CodeTableEntry entry) {
			return ((WIDE) entry).getConst() == null ? 4 : 6;
		}

		@Override
		public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
				Map<CodeTableEntry, Pair<Integer, Integer>> map) {
			WIDE result = JbcFactory.eINSTANCE.createWIDE();
			result.setIndex(reader.readU2());
			int opcode = ClassFileAccessAPI.intValue(result.getIndex());
			if (Opcode.from(opcode) == IINC) {
				result.setConst(reader.readU2());
			}
			return result;
		}
	};

	private static final Set<Integer> usedCodes = new HashSet<>(); // ensure no code is used twice
	static {
		for (Opcode opcode : Opcode.values()) {
			if (usedCodes.contains(opcode.code))
				throw new RuntimeException("Duplicate code " + opcode.code);
		}
	}

	public final int code;

	private Opcode(int code) {
		this.code = code;
	}

	public static Opcode from(int opcode) {
		for (Opcode o : Opcode.values()) {
			if (o.code == opcode)
				return o;
		}
		throw new IllegalArgumentException("Opcode " + opcode + " is invalid.");
	}

	public static Opcode from(CodeTableEntry entry) {
		return Opcode.valueOf(entry.eClass().getName());
	}

	public static int byteCount(CodeTableEntry entry) {
		return from(entry).bytes(entry);
	}

	public CodeTableEntry readInstance(ByteCodeReader reader, int offset,
			Map<CodeTableEntry, Pair<Integer, Integer>> map) {
		try {
			// save some code by using reflection per default
			Method method = JbcFactory.class.getDeclaredMethod("create" + this.name());
			return (CodeTableEntry) method.invoke(JbcFactory.eINSTANCE);
		} catch (NoSuchMethodException | SecurityException | IllegalAccessException | IllegalArgumentException
				| InvocationTargetException e) {
			throw new RuntimeException(e);
		}
	}

	protected int bytes(CodeTableEntry entry) {
		return 1;
	}

}
