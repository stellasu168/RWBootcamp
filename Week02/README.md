Class vs Struct

I think for a small Game object like this, it really doesn't matter which one to use. I just pick Class because I'm more familiar with it from Java. Also, I don't want to use mutating keyword everywhere. But, I learned that once I start implementing closures and delegates, and other reference related tasks. I will appreciate value types along with Protocol Oriented Programming soon. Structs in Swift are powerful and have many features. They have stored properties, computed properties and methods. Also, they can conform to protocols and gain their behaviors. 

The main difference between those two is that Classes are reference type, Structs are value type objects.

What is a reference type?
When we are initializing an object, RAM allocates memory space and address to it. Then, assigns its memory address to the object we created.

What is a value type?
A value type is a type whose value is copied when it’s assigned to a variable or constant, or when it’s passed to a function.

With structs, when an instance is created with a constant, let, it's not possible to mutate its property since the instance has its own copy and the let protects anyone from interfering with its own instance.

With structs, when an instance is created with a constant, let, it's not possible to mutate its property since the instance has its own copy and the let protects anyone from interfering with its own instance.


