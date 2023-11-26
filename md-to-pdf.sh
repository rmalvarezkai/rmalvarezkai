#bin/bash

# Require pandoc, lmodern, texlive-latex-recommended, texlive-latex-base and texlive-latex-extra
# apt-get install pandoc texlive-latex-base lmodern texlive-latex-recommended texlive-latex-extra

RM=/usr/bin/rm
CP=/usr/bin/cp
CAT=/usr/bin/cat
GREP=/usr/bin/grep
SED=/usr/bin/sed
MKDIR=/usr/bin/mkdir
PANDOC=/usr/bin/pandoc

INPUT_FILE=README.md
OUTPUT_FILES="resume-latest.pdf index.html"
OUTPUT_DIR=docs

if [ -f ${INPUT_FILE} ]
then
    if ! [ -d ${OUTPUT_DIR} ]
    then
        ${MKDIR} -p ${OUTPUT_DIR}
    fi

    for OUTPUT_FILE in ${OUTPUT_FILES}
    do
        if [ -f ${OUTPUT_DIR}/${OUTPUT_FILE} ]
        then
            ${RM} -f ${OUTPUT_DIR}/${OUTPUT_FILE}
        fi

        TO_FORMAT="${OUTPUT_FILE##*.}"

        if [ ${TO_FORMAT} = "html" ]
        then
            ${CAT} ${INPUT_FILE} | ${PANDOC} -f markdown --metadata=title:Resume --template=pandoc-template.html -t ${TO_FORMAT} -s -o ${OUTPUT_DIR}/${OUTPUT_FILE}
        elif [ ${TO_FORMAT} = "pdf" ]
        then
            ${CAT} ${INPUT_FILE} | ${GREP} -v ${OUTPUT_FILE} | ${GREP} -v RESUME | ${SED} '/____PDF_NEXT_PAGE____/c\\\newpage' | ${PANDOC} -f markdown --highlight-style pygments -V colorlinks=true -V linkcolor=blue -V urlcolor=red -V toccolor=gray -t ${TO_FORMAT} -s -o ${OUTPUT_DIR}/${OUTPUT_FILE} --include-in-header=custom-header.tex
        else
            ${CAT} ${INPUT_FILE} | ${GREP} -v ${OUTPUT_FILE} | ${GREP} -v RESUME | ${PANDOC} -f markdown -V colorlinks=true -V linkcolor=blue -V urlcolor=red -V toccolor=gray -t ${TO_FORMAT} -s -o ${OUTPUT_DIR}/${OUTPUT_FILE}
        fi
    done
fi
