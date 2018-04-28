
# Also see https://pymotw.com/2/zipfile/ for how to use zipfile module

from unrar import rarfile
from os import listdir, mkdir, chdir, rename, remove
from os.path import isfile, join, isdir, splitext, basename
import re
from zipfile import ZipFile
import zipfile
import string
import shutil
from titlecase import titlecase

def main(rardir):
    """Simplifies CoderProg RAR file

        Will keep: 
        * any zip files (assuming these contain source code)
        * File(s) with extension pdf XOR epub XOR azw3 mobi (in order of preference)

    Arguments:
        rardir {string} -- Path of directory containing RAR files
    """
    try:
        import zlib
        compression = zipfile.ZIP_DEFLATED
    except:
        compression = zipfile.ZIP_STORED

    TMPDIR = rardir + "/tmp"

    chdir(TMPDIR)

    if not isdir(TMPDIR):
        mkdir(TMPDIR)

    onlyfiles = [f for f in listdir(rardir) if isfile(join(rardir, f))]

    # Loop thru all RAR files
    for filename in onlyfiles:
        # If not a RAR file, skip file
        if not re.search(".rar$", filename.lower()):
            continue

        rar = rarfile.RarFile(join(rardir, filename))
        namelist = rar.namelist()
        zipIndex = -1
        pdfIndex = -1
        epubIndex = -1
        azw3Index = -1
	mobiIndex = -1
        for idx, name in enumerate(namelist):
            if re.search(".zip$", name.lower()):
                zipIndex = idx
                print(namelist[zipIndex])
            if re.search(".pdf$", name.lower()):
                pdfIndex = idx
                print(namelist[pdfIndex])
            if re.search(".epub$", name.lower()):
                epubIndex = idx
                print(namelist[epubIndex])        
            if re.search(".azw3$", name.lower()):
                azw3Index = idx
                print(namelist[azw3Index])
            if re.search(".mobi$", name.lower()):
                mobiIndex = idx
                print(namelist[mobiIndex])

        # First empty TMPDIR        
        files_to_clean = [f for f in listdir(TMPDIR) if isfile(join(TMPDIR, f))]
        for f in files_to_clean:
            remove(join(TMPDIR,f))

        # Save the zip file in any case
        if zipIndex > -1:
            rar.extract(namelist[zipIndex], TMPDIR)

        if pdfIndex > -1:
            rar.extract(namelist[pdfIndex], TMPDIR)
        elif epubIndex > -1:
            rar.extract(namelist[epubIndex], TMPDIR)
        elif azw3Index > -1:
            rar.extract(namelist[azw3Index], TMPDIR)
        elif mobiIndex > -1:
            rar.extract(namelist[mobiIndex], TMPDIR)
        
        # Create zip file
        zipname = TMPDIR + "/" + titlecase(splitext(filename)[0].replace("-", " ")) + ".zip"
        with ZipFile(zipname, 'w') as myzip:
            files_to_zip = [f for f in listdir(TMPDIR) if isfile(join(TMPDIR, f))]
            try:
                for tmpfile in files_to_zip:
                    if tmpfile == basename(zipname):
                        continue
                    nameparts = splitext(tmpfile)
                    newfilename = titlecase(nameparts[0].replace("-", " ")) + nameparts[1]
                    rename(tmpfile, newfilename)
                    myzip.write(newfilename, compress_type=compression)
            finally:
                myzip.close()
                # Move zip file out of the way, before next cleanup
                shutil.move(zipname, rardir)

    print("Done!")

if __name__ == "__main__": 
    main("/mnt/hgfs/DDD") 
