if CommandLine.arguments.count != 2 {
    print("Usage: hello Name")
} else {
    let name = CommandLine.arguments[1]
    sayHello(name: name)
}

