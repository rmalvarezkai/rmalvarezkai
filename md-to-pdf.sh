#bin/bash

# Require pandoc, lmodern, texlive-latex-recommended and texlive-latex-base
# apt-get install pandoc texlive-latex-base lmodern texlive-latex-recommended

RM=/bin/rm
CAT=/usr/bin/cat
GREP=/usr/bin/grep
PANDOC=/usr/bin/pandoc

INPUT_FILE=README.md

OUTPUT_FILE=Resume_latest.pdf

if [ -f ${INPUT_FILE} ]
then
    if [ -f ${OUTPUT_FILE} ]
    then
        ${RM} -f ${OUTPUT_FILE}
    fi

    ${CAT} ${INPUT_FILE} | ${GREP} -v RESUME | ${GREP} -v ${OUTPUT_FILE} | ${PANDOC} -f markdown -V colorlinks=true -V linkcolor=blue -V urlcolor=red -V toccolor=gray -t pdf -s -o ${OUTPUT_FILE}
fi








