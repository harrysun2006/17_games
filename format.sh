# !/bin/bash

find ./ -name '*.pde' -print | xargs js-beautify -r --indent-size=2
