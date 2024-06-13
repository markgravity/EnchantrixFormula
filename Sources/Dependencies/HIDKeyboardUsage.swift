//
//  HIDKeyboardUsage.swift
//  Enchantrix
//
//  Created by MarkG on 29/5/24.
//

import IOKit.hid
import Carbon

@objc public enum HIDKeyboardUsage: UInt32 {

    case errorRollOver = 0x01
    case postFail = 0x02
    case errorUndefined = 0x03
    case a = 0x04
    case b = 0x05
    case c = 0x06
    case d = 0x07
    case e = 0x08
    case f = 0x09
    case g = 0x0A
    case h = 0x0B
    case i = 0x0C
    case j = 0x0D
    case k = 0x0E
    case l = 0x0F
    case m = 0x10
    case n = 0x11
    case o = 0x12
    case p = 0x13
    case q = 0x14
    case r = 0x15
    case s = 0x16
    case t = 0x17
    case u = 0x18
    case v = 0x19
    case w = 0x1A
    case x = 0x1B
    case y = 0x1C
    case z = 0x1D
    case one = 0x1E
    case two = 0x1F
    case three = 0x20
    case four = 0x21
    case five = 0x22
    case six = 0x23
    case seven = 0x24
    case eight = 0x25
    case nine = 0x26
    case zero = 0x27
    case returnOrEnter = 0x28
    case escape = 0x29
    case deleteOrBackspace = 0x2A
    case tab = 0x2B
    case spacebar = 0x2C
    case hyphenUnderscore = 0x2D
    case equalsPlus = 0x2E
    case openBracket = 0x2F
    case closeBracket = 0x30
    case backslashPipe = 0x31
    case nonUSPoundTilde = 0x32
    case semicolonColon = 0x33
    case singleQuoteDoubleQuote = 0x34
    case graveAccentTilde = 0x35
    case commaLessThan = 0x36
    case periodGreaterThan = 0x37
    case slashQuestionMark = 0x38
    case capsLock = 0x39
    case f1 = 0x3A
    case f2 = 0x3B
    case f3 = 0x3C
    case f4 = 0x3D
    case f5 = 0x3E
    case f6 = 0x3F
    case f7 = 0x40
    case f8 = 0x41
    case f9 = 0x42
    case f10 = 0x43
    case f11 = 0x44
    case f12 = 0x45
    case printScreen = 0x46
    case scrollLock = 0x47
    case pause = 0x48
    case insert = 0x49
    case home = 0x4A
    case pageUp = 0x4B
    case deleteForward = 0x4C
    case end = 0x4D
    case pageDown = 0x4E
    case rightArrow = 0x4F
    case leftArrow = 0x50
    case downArrow = 0x51
    case upArrow = 0x52
    case keypadNumLockClear = 0x53
    case keypadSlash = 0x54
    case keypadAsterisk = 0x55
    case keypadHyphen = 0x56
    case keypadPlus = 0x57
    case keypadEnter = 0x58
    case keypadOne = 0x59
    case keypadTwo = 0x5A
    case keypadThree = 0x5B
    case keypadFour = 0x5C
    case keypadFive = 0x5D
    case keypadSix = 0x5E
    case keypadSeven = 0x5F
    case keypadEight = 0x60
    case keypadNine = 0x61
    case keypadZero = 0x62
    case keypadPeriod = 0x63
    case nonUSBackslash = 0x64
    case application = 0x65
    case power = 0x66
    case keypadEquals = 0x67
    case f13 = 0x68
    case f14 = 0x69
    case f15 = 0x6A
    case f16 = 0x6B
    case f17 = 0x6C
    case f18 = 0x6D
    case f19 = 0x6E
    case f20 = 0x6F
    case f21 = 0x70
    case f22 = 0x71
    case f23 = 0x72
    case f24 = 0x73
    case execute = 0x74
    case help = 0x75
    case menu = 0x76
    case select = 0x77
    case stop = 0x78
    case again = 0x79
    case undo = 0x7A
    case cut = 0x7B
    case copy = 0x7C
    case paste = 0x7D
    case find = 0x7E
    case mute = 0x7F
    case volumeUp = 0x80
    case volumeDown = 0x81
    case commandLeft = 0xE3
    case commandRight = 0xE7
    case shiftLeft = 0xE1
    case shiftRight = 0xE5
    case controlLeft = 0xE0
    case controlRight = 0xE4
    case optionLeft = 0xE2
    case optionRight = 0xE6
}

public extension HIDKeyboardUsage {

    var keyCode: Int {
        switch self {
        case .a: return kVK_ANSI_A
        case .b: return kVK_ANSI_B
        case .c: return kVK_ANSI_C
        case .d: return kVK_ANSI_D
        case .e: return kVK_ANSI_E
        case .f: return kVK_ANSI_F
        case .g: return kVK_ANSI_G
        case .h: return kVK_ANSI_H
        case .i: return kVK_ANSI_I
        case .j: return kVK_ANSI_J
        case .k: return kVK_ANSI_K
        case .l: return kVK_ANSI_L
        case .m: return kVK_ANSI_M
        case .n: return kVK_ANSI_N
        case .o: return kVK_ANSI_O
        case .p: return kVK_ANSI_P
        case .q: return kVK_ANSI_Q
        case .r: return kVK_ANSI_R
        case .s: return kVK_ANSI_S
        case .t: return kVK_ANSI_T
        case .u: return kVK_ANSI_U
        case .v: return kVK_ANSI_V
        case .w: return kVK_ANSI_W
        case .x: return kVK_ANSI_X
        case .y: return kVK_ANSI_Y
        case .z: return kVK_ANSI_Z
        case .one: return kVK_ANSI_1
        case .two: return kVK_ANSI_2
        case .three: return kVK_ANSI_3
        case .four: return kVK_ANSI_4
        case .five: return kVK_ANSI_5
        case .six: return kVK_ANSI_6
        case .seven: return kVK_ANSI_7
        case .eight: return kVK_ANSI_8
        case .nine: return kVK_ANSI_9
        case .zero: return kVK_ANSI_0
        case .returnOrEnter: return kVK_Return
        case .escape: return kVK_Escape
        case .deleteOrBackspace: return kVK_Delete
        case .tab: return kVK_Tab
        case .spacebar: return kVK_Space
        case .hyphenUnderscore: return kVK_ANSI_Minus
        case .equalsPlus: return kVK_ANSI_Equal
        case .openBracket: return kVK_ANSI_LeftBracket
        case .closeBracket: return kVK_ANSI_RightBracket
        case .backslashPipe: return kVK_ANSI_Backslash
        case .nonUSPoundTilde: return kVK_ISO_Section
        case .semicolonColon: return kVK_ANSI_Semicolon
        case .singleQuoteDoubleQuote: return kVK_ANSI_Quote
        case .graveAccentTilde: return kVK_ANSI_Grave
        case .commaLessThan: return kVK_ANSI_Comma
        case .periodGreaterThan: return kVK_ANSI_Period
        case .slashQuestionMark: return kVK_ANSI_Slash
        case .capsLock: return kVK_CapsLock
        case .f1: return kVK_F1
        case .f2: return kVK_F2
        case .f3: return kVK_F3
        case .f4: return kVK_F4
        case .f5: return kVK_F5
        case .f6: return kVK_F6
        case .f7: return kVK_F7
        case .f8: return kVK_F8
        case .f9: return kVK_F9
        case .f10: return kVK_F10
        case .f11: return kVK_F11
        case .f12: return kVK_F12
        case .printScreen: return kVK_F13 // No direct mapping, using F13 as placeholder
        case .scrollLock: return kVK_F14 // No direct mapping, using F14 as placeholder
        case .pause: return kVK_F15 // No direct mapping, using F15 as placeholder
        case .insert: return kVK_Help
        case .home: return kVK_Home
        case .pageUp: return kVK_PageUp
        case .deleteForward: return kVK_ForwardDelete
        case .end: return kVK_End
        case .pageDown: return kVK_PageDown
        case .rightArrow: return kVK_RightArrow
        case .leftArrow: return kVK_LeftArrow
        case .downArrow: return kVK_DownArrow
        case .upArrow: return kVK_UpArrow
        case .keypadNumLockClear: return kVK_ANSI_KeypadClear
        case .keypadSlash: return kVK_ANSI_KeypadDivide
        case .keypadAsterisk: return kVK_ANSI_KeypadMultiply
        case .keypadHyphen: return kVK_ANSI_KeypadMinus
        case .keypadPlus: return kVK_ANSI_KeypadPlus
        case .keypadEnter: return kVK_ANSI_KeypadEnter
        case .keypadOne: return kVK_ANSI_Keypad1
        case .keypadTwo: return kVK_ANSI_Keypad2
        case .keypadThree: return kVK_ANSI_Keypad3
        case .keypadFour: return kVK_ANSI_Keypad4
        case .keypadFive: return kVK_ANSI_Keypad5
        case .keypadSix: return kVK_ANSI_Keypad6
        case .keypadSeven: return kVK_ANSI_Keypad7
        case .keypadEight: return kVK_ANSI_Keypad8
        case .keypadNine: return kVK_ANSI_Keypad9
        case .keypadZero: return kVK_ANSI_Keypad0
        case .keypadPeriod: return kVK_ANSI_KeypadDecimal
        case .nonUSBackslash: return kVK_ISO_Section // No direct mapping, using ISO Section as placeholder
        case .application: return kVK_ANSI_KeypadEnter // No direct mapping, using Keypad Enter as placeholder
        case .keypadEquals: return kVK_ANSI_KeypadEquals
        case .f13: return kVK_F13
        case .f14: return kVK_F14
        case .f15: return kVK_F15
        case .f16: return kVK_F16
        case .f17: return kVK_F17
        case .f18: return kVK_F18
        case .f19: return kVK_F19
        case .f20: return kVK_F20
        case .execute: return kVK_ANSI_KeypadEnter // No direct mapping, using Keypad Enter as placeholder
        case .help: return kVK_Help
        case .menu: return kVK_ANSI_KeypadEnter // No direct mapping, using Keypad Enter as placeholder
        case .select: return kVK_ANSI_KeypadEnter // No direct mapping, using Keypad Enter as placeholder
        case .stop: return kVK_ANSI_KeypadEnter // No direct mapping, using Keypad Enter as placeholder
        case .again: return kVK_ANSI_KeypadEnter // No direct mapping, using Keypad Enter as placeholder
        case .undo: return kVK_ANSI_KeypadEnter // No direct mapping, using Keypad Enter as placeholder
        case .cut: return kVK_ANSI_KeypadEnter // No direct mapping, using Keypad Enter as placeholder
        case .copy: return kVK_ANSI_KeypadEnter // No direct mapping, using Keypad Enter as placeholder
        case .paste: return kVK_ANSI_KeypadEnter // No direct mapping, using Keypad Enter as placeholder
        case .find: return kVK_ANSI_KeypadEnter // No direct mapping, using Keypad Enter as placeholder
        case .mute: return kVK_Mute
        case .volumeUp: return kVK_VolumeUp
        case .volumeDown: return kVK_VolumeDown
        case .commandLeft: return kVK_Command
        case .commandRight: return kVK_Command
        case .shiftLeft: return kVK_Shift
        case .shiftRight: return kVK_RightShift
        case .controlLeft: return kVK_Control
        case .controlRight: return kVK_RightControl
        case .optionLeft: return kVK_Option
        case .optionRight: return kVK_RightOption
        case .errorRollOver, .postFail, .errorUndefined, .f21, .f22, .f23, .f24, .power:
            return -1
        }
    }
}
