#!/usr/bin/env nextflow

/*
 * Use echo to print 'Hello World!' to a file
 */
/*process sayHello {

    input:
    val greeting

    output:
    path 'output.txt'

    script:
    """
    echo '${greeting}' > output.txt
    """
}

/*
 * Pipeline parameters
 */
/*
params {
    input: String = 'Holà mundo!'
}

workflow {

    main:
    // emit a greeting
    sayHello(params.input)

    publish:
    first_output = sayHello.out
}

output {
    first_output {
        path 'hello_channels'
        mode 'copy'
    }
}*/



params {
    input: String = "My name is Honey"
}


process helloWorld {

    // publishDir is an old way of saving outputs to another directory, do not use it, instead use the output{} block
    //publishDir 'nameResults/hello-world', mode: 'copy'

    input:
    val greetings

    script:
    """
    echo 'What would be your name? : ${greetings}' > output.txt
    """

    output:
    path 'output.txt'
}

workflow {
    main:
    my_channel_1 = channel.of(params.input).view()
    helloWorld(my_channel_1)

    publish:
    first_output = helloWorld.out
}

//this is the new method and it should be used
output {
    first_output {
        path 'hello-channels'
        mode 'copy'
    }
}

