#! /usr/local/bin/zsh
# needed the operands to be like : {"one":"vaule1","two":value2"}{"three":"value3","four":"value4"}
echo $@ | sed 's/}{/,/g'
