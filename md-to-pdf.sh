#bin/bash

# Require pandoc, lmodern, texlive-latex-recommended and texlive-latex-base
# apt-get install pandoc texlive-latex-base lmodern texlive-latex-recommended

RM=/usr/bin/rm
CP=/usr/bin/cp
CAT=/usr/bin/cat
GREP=/usr/bin/grep
MKDIR=/usr/bin/mkdir
PANDOC=/usr/bin/pandoc

INPUT_FILE=README.md
OUTPUT_FILES="Resume_latest.pdf index.html"
OUTPUT_DIR=docs

if [ -f ${INPUT_FILE} ]
then
    if ! [ -d ${OUTPUT_DIR} ]
    then
        ${MKDIR} -p ${OUTPUT_DIR}
    fi

    for OUTPUT_FILE in ${OUTPUT_FILES}
    do
        if [ -f ${OUTPUT_FILE} ]
        then
            ${RM} -f ${OUTPUT_FILE}
        fi

        TO_FORMAT="${OUTPUT_FILE##*.}"

        ${CAT} ${INPUT_FILE} | ${GREP} -v ${OUTPUT_FILE} | ${GREP} -v RESUME | ${PANDOC} -f markdown -V colorlinks=true -V linkcolor=blue -V urlcolor=red -V toccolor=gray -t ${TO_FORMAT} -s -o ${OUTPUT_FILE}
        ${CP} -f ${OUTPUT_FILE} ${OUTPUT_DIR}/${OUTPUT_FILE}
    done
fi




