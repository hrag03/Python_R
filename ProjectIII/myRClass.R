#### HELPER CODE #######
setClass("Person", slots=c(name = "character", age = "numeric"))
### END HELPER CODE ###

# Part 1. 
# Your program is based on S4 objects.
# Consider that an employee is a person who has a salary and gets a raise from time to time.

library(reticulate)
source_python('myPythonClass_updated.py')


# 1. Write an inherited class from the Person class, called Employee, who's attributes are boss (which is a Person object) and the salary (which is a numeric object).
setClass('Employee', slots=c(boss = 'Person', salary = 'numeric'), contains = 'Person')
# 2. Write a Generic function called raise with the following arguments: An object and a percentage numeric variable. 
setGeneric('raise', function(obj, percent = 'numeric') {
  standardGeneric(('raise'))
})
setMethod('raise', 'Employee', function(obj, percent = 0) {
  return(obj@salary * ((percent / 100) + 1))
})
# 3. Write the Employee's specific method for the generic function raise which will take the object and percentage as an argument.
# For example if raise was called on an Employee object it should be used as follows:
# raise(john, percent=10) where john is an instance of the Employee object and percent is the raise percentage that will be applied on John's salary.

# Part 2.
# 4. Create a generic function called secret with th following arguments: The object and a message variable which will be a string. 
setGeneric('secret', function(obj, message = 'string') {
  standardGeneric('secret')
})
# 5. Create a Person object's method for secret with the object and message arguments and let this method, encrypt a message using your Python encrypter. This function returns a string.
setMethod('secret', 'Person', function(obj, message = 'string') {
  msg <- AnyTextMessage(message, 4L)
  secret <- msg$get_encr_msg()
  return(secret)
})
# 6. Create an Employee's object's method for secret with the object and message arguments and let this method, decrypt a message using your Python encrypter ONLY for Employees whos name is "John"!
setMethod('secret', 'Employee', function(obj, message) {
  msg <- CaesarsDecoder(message)
  shift <- as.integer(msg$decrypt_message()[1])
  if (obj@name == 'John') {
    decrypt <- msg$decrypt_message()
    return(decrypt)
  } else {
    msg <- AnyTextMessage(message, as.integer(26 - shift))
    encrypt <- msg$get_encr_msg()
    return(encrypt)
  }
})

 
boss <- new('Person', name = 'Boss', age = 18)
robert <- new('Employee', name = 'Robert', age = 22, boss = boss, salary = 2000)
john <- new('Employee', name = 'John', age = 20, boss = boss, salary = 3000)
vigen <- new('Employee', name = 'Vigen', age = 25, boss = boss, salary = 1500)


# If the employee's name is not "John", apply more encryption on top of the encrypted message. This function returns a string.
