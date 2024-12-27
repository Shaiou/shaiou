#!/usr/bin/env python3

from datetime import datetime,timedelta
from pathlib import Path
from PIL import Image, ExifTags
import logging
import os
import re
import shutil
import cv2
import numpy
import click

logger = logging.getLogger()
logging.basicConfig(level=logging.INFO)

@click.group(invoke_without_command=True)
def cli():
    pass

def are_identical_files(source,target):
    a = cv2.imread(source)
    b = cv2.imread(target)
    #cv2.imshow("Original", a)
    #cv2.imshow("Duplicate", b)
    #cv2.waitKey(0)
    #cv2.destroyAllWindows()
    return (len(a) == len(b)) and (not numpy.any(cv2.subtract(a, b)))

#@click.option("-f","file", required=True)
#@click.option("-t","--target-folder", default="")
#@click.option("-o","--offset",type=int,default=0)
#@click.option("--move", is_flag=True, show_default=True, default=False, help="Move instead of copy")
#@cli.command()
def copy_file(file,move=False,target_folder="",offset=0):
    exif = Image.open(file)._getexif()
    if not exif:
        print(f'[ERROR] No exif data for {file}')
        return
    p = Path(file)
    for k in [ 36867, 306 ]:
        if k in exif:
            src_format = '%Y:%m:%d %H:%M:%S'
            dst_format = '%Y-%m-%d-%H-%M-%S'
            file_date = datetime.strptime(exif[k], src_format) + timedelta(seconds=45)
            date_string = file_date.strftime(dst_format)
            year = file_date.strftime('%Y')
            if not target_folder:
                target_folder = p.parent
            year_folder = f'{target_folder}/{year}'
            logging.debug(f'Creating folder {year_folder} if it does not exist')
            #os.makedirs(year_folder, exist_ok=True)
            suffix = p.suffix.lower()
            base_newname = f'{year_folder}/{date_string}'
            newname = f'{base_newname}{suffix}'
            idx = 0
            while os.path.exists(newname):
                logger.warn(f'Skipping duplicate files {file} {newname}')
                return
                #if are_identical_files(file,newname):
                #    logger.warn(f'Skipping duplicate files {file} {newname}')
                #    break
                #idx += 1
                #logger.info(f'{newname} already exists, trying with {base_newname}_{idx}{p.suffix}')
                #newname = f'{base_newname}_{idx}{suffix}'
            else:
                try:
                    if move:
                        logger.info(f'Moving {file} to {newname}')
                        #shutil.move(file,f'{newname}')
                    else:
                        logger.info(f'Copying {file} to {newname}')
                        #shutil.copy(file,f'{newname}')
                    break
                except Exception as e:
                    logger.error(f'oops {file} {e}')
            break
    else:
        logger.error(f'[ERROR] missing date exif in {file}')
        logger.error(exif)

@click.option("-s","--source-folder")
@click.option("-t","--target-folder", default="")
@click.option("-o","--offset",type=int,default=0)
@click.option("--move", is_flag=True,show_default=True, default=False, help="Move instead of copy")
@cli.command()
def copy_folder(source_folder,move,target_folder,offset):
    files = os.listdir(source_folder)
    for file in files:
        if re.match("^.*.jp*g$",file,re.IGNORECASE):
            duplicate_file = copy_file(f'{source_folder}/{file}',move=move,target_folder=target_folder,offset=offset)
        else:
            logger.debug(f'{file} is not a jpg')

if __name__ == "__main__":
    cli()
