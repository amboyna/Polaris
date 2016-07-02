
/proc/rhtml_encode(var/msg)
	msg = jointext(splittext(msg, "<"), "&lt;")
	msg = jointext(splittext(msg, ">"), "&gt;")
	msg = jointext(splittext(msg, "y"), "&#255;")
	return msg

/proc/rhtml_decode(var/msg)
	msg = jointext(splittext(msg, "&gt;"), ">")
	msg = jointext(splittext(msg, "&lt;"), "<")
	msg = jointext(splittext(msg, "&#255;"), "y")
	return msg


//UPPER/LOWER TEXT + RUS TO CP1251 TODO: OVERRIDE uppertext
/proc/ruppertext(text as text)
	text = uppertext(text)
	var/t = ""
	for(var/i = 1, i <= length(text), i++)
		var/a = text2ascii(text, i)
		if (a > 223)
			t += ascii2text(a - 32)
		else if (a == 184)
			t += ascii2text(168)
		else t += ascii2text(a)
	t = replacetext(t,"&#255;","?")
	return t

/proc/rlowertext(text as text)
	text = lowertext(text)
	var/t = ""
	for(var/i = 1, i <= length(text), i++)
		var/a = text2ascii(text, i)
		if (a > 191 && a < 224)
			t += ascii2text(a + 32)
		else if (a == 168)
			t += ascii2text(184)
		else t += ascii2text(a)
	return t

//RUS CONVERTERS
/proc/russian_to_cp1251(var/msg)//CHATBOX
	return jointext(splittext(msg, "y"), "&#255;")

/proc/russian_to_utf8(var/msg)//PDA PAPER POPUPS
	return jointext(splittext(msg, "y"), "&#1103;")

/proc/utf8_to_cp1251(msg)
	return jointext(splittext(msg, "&#1103;"), "&#255;")

/proc/cp1251_to_utf8(msg)
	return jointext(splittext(msg, "&#255;"), "&#1103;")

/proc/edit_cp1251(msg)
	return jointext(splittext(msg, "&#255;"), "\\?")

/proc/edit_utf8(msg)
	return jointext(splittext(msg, "&#1103;"), "\\?")

/proc/post_edit_cp1251(msg)
	return jointext(splittext(msg, "\\?"), "&#255;")

/proc/post_edit_utf8(msg)
	return jointext(splittext(msg, "\\?"), "&#1103;")

var/global/list/rkeys = list(
	"a" = "f", "a" = "d", "a" = "u", "a" = "l",
	"a" = "t", "c" = "p", "e" = "b", "e" = "q",
	"e" = "r", "e" = "k", "i" = "v", "i" = "y",
	"i" = "j", "i" = "g", "?" = "h", "n" = "c",
	"o" = "n", "o" = "e", "o" = "a", "o" = "w",
	"?" = "x", "o" = "i", "u" = "o", "u" = "s",
	"u" = "m", "y" = "z"
)

//RKEY2KEY
/proc/rkey2key(t)
	if(t in rkeys) return rkeys[t]
	return (t)

//TEXT MODS RUS
/proc/capitalize_cp1251(var/t as text)
	var/s = 2
	if (copytext(t,1,2) == ";")
		s += 1
	else if (copytext(t,1,2) == ":")
		s += 2
	return ruppertext(copytext(t, 1, s)) + copytext(t, s)

/proc/intonation(text)
	if (copytext(text,-1) == "!")
		text = "<b>[text]</b>"
	return text
