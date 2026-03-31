#!/usr/bin/env nextflow

/*
 * Use echo to print 'Hello World!' to a file
 */
/*process sayHello {

    output:
    path 'output.txt'

    script:
    """
    echo 'Hello World!' > output.txt
    """
}

workflow {

    main:
    // emit a greeting
    sayHello()
}*/


params {
    input: String = "My name is Honey"
}

process helloWorld {

    // publishDir is an old way of saving outputs to another directory, do not use it, instead use the output{} block
    //publishDir 'nameResults/hello-world', mode: 'copy'

    script:
    """
    echo 'What would be your name? : ${params.input}' > output.txt
    """

    output:
    path 'output.txt'
}

workflow {
    main:
    helloWorld()

    publish:
    first_output = helloWorld.out
}

//this is the new method and it should be used
output {
    first_output {
        path 'hello-world'
        mode 'copy'
    }
}
