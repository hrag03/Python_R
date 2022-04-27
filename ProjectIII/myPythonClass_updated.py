import string
from myPythonHelperModule import extract_words
from myPythonHelperModule import is_word

class Message():
    def __init__(self, text):
        self.msg_txt = text
        self.accepted_words = extract_words('words.txt')

    def get_message_text(self):
        return self.msg_txt

    def get_accepted_words(self):
        copy_accepted_words = self.accepted_words
        return copy_accepted_words


    def make_shift_dict(self, shift):
        def easy_shift(list, shift):
            list1 = []
            for i in range(0, 26):
                if (i < 26 - shift):
                    list1 += list[shift + i]
                else:
                    list1 += list[i - 26 + shift]
            newdict = {list[n]: list1[n] for n in range(len(list))}
            return newdict
        dictionary = easy_shift(string.ascii_lowercase, shift)
        dictionary.update(easy_shift(string.ascii_uppercase, shift))
        return dictionary

    def shift_useCase(self, shift):
        shift_dict = self.make_shift_dict(shift)
        text = self.msg_txt
        text = list(text)
        for i in range(0, len(text)):
            if (text[i] in string.ascii_letters):
                text[i] = shift_dict[text[i]]
        return "".join(text)

#Test
abc = Message("Hello")
print(abc.make_shift_dict(2))


class AnyTextMessage(Message):
    def __init__(self, text, shift):
        self.msg_txt = text
        self.shift = shift
        self.encr_shift_dict = Message.make_shift_dict(self, shift)
        self.encr_msg_txt = Message.shift_useCase(self, shift)
        self.accepted_words = extract_words('words.txt')
    def get_shift(self):
        return self.shift
    
    def get_encr_dict(self):
        copy_encr = self.encr_shift_dict
        return copy_encr
    def get_encr_msg(self):
        return self.encr_msg_txt
    def change_shift(self, newshift):
        self.shift = newshift 
        pass


class CaesarsDecoder(Message):
    def __init__(self, text):
        self.msg_txt = text
        self.accepted = extract_words('words.txt')
        
    def decrypt_message(self):
        text1 = self.msg_txt
        msg = Message(text1)
        shft_counter = []
        for i in range(0,26):
            msg1 = msg.shift_useCase(i)
            msg1 = msg1.split()
            count = 0
            for word in msg1:
                if (is_word(self.accepted, word)):
                    count += 1
            shft_counter.append(count)
        for i in range(0, len(shft_counter)):
            if (shft_counter[i] == max(shft_counter)):
                return(i, msg.shift_useCase(i))
        
message = CaesarsDecoder("Alc hmh xli glmgoir gvsww xli vseh? Tpexs: Jsv xli kviexiv kssh. Oevp Qevb: Mx aew e lmwxsvmgep mrizmxefmpmxc. Rmixdwgli: Figeywi mj csy kedi xss psrk egvsww xli Vseh, xli Vseh kediw epws egvsww csy.")
print(message.decrypt_message())

