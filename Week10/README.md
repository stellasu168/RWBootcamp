RW iOS Bootcamp Assigment 10

This week's homework is about GCD and iOS Concurrency. 

Course work: 
https://www.raywenderlich.com/9461083-ios-concurrency-with-gcd-and-operations
https://www.raywenderlich.com/966538-arc-and-memory-management-in-swift

Additional resources:
https://www.swiftbysundell.com/articles/swifts-closure-capturing-mechanics/
https://theswiftdev.com/ultimate-grand-central-dispatch-tutorial-in-swift/

Grand central dispatch:
- Grand central dispatch (GCD) framework organizes task into queues, FIFO.
- But the order of the completion is not guaranteed. The main thread should only be used for user interface tasks. 
- You app needs concurrency to run more than one task at a time, usually one or more non-UI tasks like Network downloads running while the user continues to interact with your app's UI. 
- With synchronous execution the queue waits for the work, with async execution the code returns immediately without waiting for the task to complete.

iOS concurrency: 
- Concurrency means doing multiple tasks at the same time. 
- In iOS, concurrency is used to improve producitivity and UI responsiveness, provived by the tools like Thread, GCD and Operation. 
- To better realize how to use concurrency, The basic notion is the queue. 
- The queues have closures lined up and according to the FIFO order, the system pulls them one by one and deploys them on the appropriate threads. 
- Concurrent queue - task finishes at their own speed. So you won’t know when task will stop. You want to use this one if you want to get things done asap and doesn’t care which finishes first. 
- If you let these non-UI tasks run on the main queue, your UI will stop. OTOH (on the other hand) all UI updates must happen on the main queue.
- EX: URLSession.shared.dataTask is a slow non-UI task, by default, runs off the main queue.

Automatic reference counting (ARC):
- Everytime you create a pointer, Swift will keep count for you. And whenever that pointer goes out of scope, like sets it to Nil for example. It will decrement the count for you. And when it gets to zero, it will get take out of the heap instantly. 
- You can influence by three types. Strong, weak and unowned. 

Weak: 
- Means I’m only interested in it, if someone else is interested in it. If no one wants it, set me to nil. Like don’t keep that thing on my account, kind of pointer. 
- So the type of this pointer is Optional. 
- We use Weak commonly in outlets and delegations. (Strong held by the view hierarchy, so outlets can be weak). So if an outlet is deleted, the pointer will be deleted (Nil) as well. 
- A weak pointer will NEVER keep an object in the *heap. 
- It can prevent memory leaks

Strong:
- Strong is the default reference counting (pointer). We never have to type Strong out. 
- As long as anyone has a strong pointer to an instance, it will stay in the heap. 

 
