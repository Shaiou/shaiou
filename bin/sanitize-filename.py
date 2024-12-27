#!/usr/bin/env python3

import os
import unicodedata
import re
import shutil

from pathlib import Path

def slugify(filename, allow_unicode=False):
    """
    Taken from https://github.com/django/django/blob/master/django/utils/text.py
    Convert to ASCII if 'allow_unicode' is False. Convert spaces or repeated
    dashes to single dashes. Remove characters that aren't alphanumerics,
    underscores, or hyphens. Convert to lowercase. Also strip leading and
    trailing whitespace, dashes, and underscores.
    """
    value = str(Path(filename).stem)
    if allow_unicode:
        value = unicodedata.normalize('NFKC', value)
    else:
        value = unicodedata.normalize('NFKD', value).encode('ascii', 'ignore').decode('ascii')
    value = re.sub(r'[^\w\s-]', '', value.lower())
    return (re.sub(r'[-\s]+', '-', value).strip('-_') +  Path(filename).suffix).lower()

files = os.listdir(".")
for file in files:
    newname = slugify(file)
    if newname != file:
        print(f'Renaming "{file} to {slugify(file)}')
        shutil.move(file,slugify(file))
    else:
        print(f'Skipping proper filename {file}')



