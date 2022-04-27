library(reticulate)
source("myRClass.R")
source_python("myPythonClass_updated.py")
source_python("myPythonHelperModule.py")

## Create a test case ###
### Part 1 ###
# 1. Save the encrypted story from the secretstory.txt file as my_story, using one of your Python Helper Module functions.
my_story <- get_story_text()
# 2. Create an instance of CaesarsDecoder with my_story as its initial input.  
input <- CaesarsDecoder(my_story)
# 3. Print the decrypted message of my_story.
print(input$decrypt_message())

### Part 2 ### 
# 4. Create a variable called my_new_story and let it be equal to a story of your choice. Save it as a string.
my_new_story <- 'Everyone had lost all their hair due to global fallout, a man found a strand of hair in his soup'
# 5. Create an instance of AnytextMessage and with my_new_story and the shift of your choice as its inputs. 
inst <- AnyTextMessage(my_new_story, 5L)
# 6. Use one of the AnytextMessage methods to encrypt my_new_story.
# 7. Save the output of the encryption in a text file called: "mysecretstory.txt"
write.table(as.character(inst$encr_msg_txt), file = 'mysecretstory.txt')
### Part 3 ###
# 8. Create an instance of the employee object called john with the name "John" of boss ("Mr. X" of age 52 - who is a Person object) and a salary of 100.
boss <- new("Person", name = "Mr. X", age = 52)
john <- new("Employee", boss = boss, salary = 100, name = "John", age = 18)
# 9. Let john get a raise of 15 percent.
john@salary <- raise(john, percent = 15)
# 10. Print the new salary of john.
john@salary

# "Mr. X" now wants to send a secret message to john and he doesn't want other employees to find out.
# 11. Use the generic function secret to let "Mr. X" create an encrypted message with the shift you like. 
secret_msg <- "The case code is two, one, three, six, five, nine. Don't share with anyone John!"
to_john <- secret(boss, secret_msg)
# 12. Use the generic function secret to let john decrypt the encrypted message.

# 13. Create an instance of a new Employee called suzan, let suzan try decryting the message. If your code is right, suzan's message should be even more decrypted because only john can decrypt the Message of "Mr. X".
suzan <- new('Employee', boss = boss, salary = 200, name = 'Suzan', age = 19)
test_john <- secret(john, message = secret(boss, secret_msg))
test_john
test_suzan <- secret(suzan, message = secret(boss, secret_msg))
test_suzan

### Part 4: Optional #### 
# Write your own test cases as you would like and use more of the methods you defined in the classes. 
# You can try changing the shift of an existing message using one of the class methods 
# Or you can try Decrypting the message of suzan. 

my_text <- "R language is so uncomfortable to work with!"
enc_text <- AnyTextMessage(my_text, 3L)
the_text <- enc_text$encr_msg_txt
enc_text$encr_msg_txt
double_enc <- AnyTextMessage(the_text, 4L)
double_enc$encr_msg_txt

res <- CaesarsDecoder(double_enc$encr_msg_txt)
res$decrypt_message()

### Good Luck! ### 
### THE END ### 