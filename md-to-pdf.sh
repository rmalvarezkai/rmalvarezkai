#bin/bash

# Require pandoc, lmodern, texlive-latex-recommended and texlive-latex-base
# apt-get install pandoc texlive-latex-base lmodern texlive-latex-recommended

RM=/bin/rm
PANDOC=/usr/bin/pandoc

INPUT_FILE=README.md

OUTPUT_FILE=Resume_latest.pdf

if [ -f ${INPUT_FILE} ]
then
    if [ -f ${OUTPUT_FILE} ]
    then
        ${RM} -f ${OUTPUT_FILE}
    fi

    ${PANDOC} ${INPUT_FILE} -f markdown -t pdf -s -o ${OUTPUT_FILE}
fi

