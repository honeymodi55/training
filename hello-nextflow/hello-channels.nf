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
    //input: String = "My name is Honey"
    //input = ["Honey", "Bunny", "Sunny"]
    input: Path = 'data/greetings.csv'
}


process helloWorld {

    // publishDir is an old way of saving outputs to another directory, do not use it, instead use the output{} block
    //publishDir 'nameResults/hello-world', mode: 'copy'

    input:
    val greetings

    script:
    """
    echo 'What would be your name? : ${greetings}' > '${greetings}-output.txt'
    """

    output:
    path "${greetings}-output.txt"
}

workflow {
    main:
    // my_channel_1 = channel.of('My name is Honey').view() //This is for a single string

    //my_channel_1 = channel.of('Honey', 'Bunny', 'Sunny').view() //This is for Multiple strings echoing the result in their respective output files

    //channel_array = params.input
    /*my_channel_1 = channel.of(channel_array)
                          .view{ mygreeting -> "Before flattening: $mygreeting" }
                          .flatten()
                          .view{ mygreeting -> "After flattening: $mygreeting" }*/

    my_channel_1 = channel.fromPath(params.input)
                          .view{ csv -> "Before using splitCsv() function: $csv" }
                          .splitCsv()
                          .view{ csv -> "After using splitCsv() function: $csv" }
                          .map{ row -> row[0] }
                          .view{ maps -> "After mapping: $maps" }
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

